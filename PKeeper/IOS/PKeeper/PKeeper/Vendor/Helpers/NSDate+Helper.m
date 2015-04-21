//
// NSDate+Helper.h
//
// Created by Billy Gray on 2/26/09.
// Copyright (c) 2009–2012, ZETETIC LLC
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the ZETETIC LLC nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY ZETETIC LLC ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL ZETETIC LLC BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

/*
 * This guy can be a little unreliable and produce unexpected results,
 * you're better off using daysAgoAgainstMidnight
 */
- (NSUInteger)daysAgo {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
											   fromDate:self
												 toDate:[NSDate date]
												options:0];
	return [components day];
}

- (NSUInteger)daysAgoAgainstMidnight {
	// get a midnight version of ourself:
	NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
	[mdf setDateFormat:@"yyyy-MM-dd"];
	NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
	[mdf release];
	
	return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
	return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
	NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
	NSString *text = nil;
	switch (daysAgo) {
		case 0:
			text = @"Today";
			break;
		case 1:
			text = @"Yesterday";
			break;
		default:
			text = [NSString stringWithFormat:@"%d days ago", daysAgo];
	}
	return text;
}

+ (NSUInteger)weekday:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
	return [weekdayComponents weekday];
}

+ (NSUInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:(NSDate *)self];
	return [weekdayComponents weekday];
}

+ (NSString*)weakdayString:(NSDate*)date
{
    NSUInteger week = [NSDate weekday:date];
    NSString* weekday;
    switch (week)
    {
        case 1:
            weekday = @"周日";
            break;
        case 2:
            weekday = @"周一";
            break;
        case 3:
            weekday = @"周二";
            break;
        case 4:
            weekday = @"周三";
            break;
        case 5:
            weekday = @"周四";
            break;
        case 6:
            weekday = @"周五";
            break;
        case 7:
            weekday = @"周六";
            break;
        default:
            break;
    }
    return weekday;
}

+ (NSInteger)year {
    NSString *yearString = [NSDate stringFromDate:[NSDate date] withFormat:@"yyyy"];
    return [yearString intValue];
}




+ (NSDate *)dateFromString:(NSString *)string {
	return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:format];
	NSDate *date = [inputFormatter dateFromString:string];
	[inputFormatter release];
	return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
	return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
	return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime {
    /*
	 * if the date is in today, display 12-hour time with meridian,
	 * if it is within the last 7 days, display weekday name (Friday)
	 * if within the calendar year, display as Jan 23
	 * else display as Nov 11, 2008
	 */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    
	NSDate *today = [NSDate date];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
													 fromDate:today];
	
	NSDate *midnight = [calendar dateFromComponents:offsetComponents];
	NSString *displayString = nil;
	
	// comparing against midnight
    NSComparisonResult midnight_result = [date compare:midnight];
	if (midnight_result == NSOrderedDescending) {
		if (prefixed) {
			[displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
		} else {
			[displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
		}
	} else {
		// check if date is within last 7 days
		NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
		[componentsToSubtract setDay:-7];
		NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
		[componentsToSubtract release];
        NSComparisonResult lastweek_result = [date compare:lastweek];
		if (lastweek_result == NSOrderedDescending) {
            if (displayTime) {
                [displayFormatter setDateFormat:@"EEEE h:mm a"];
            } else {
                [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
            }
		} else {
			// check if same calendar year
			NSInteger thisYear = [offsetComponents year];
			
			NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
														   fromDate:date];
			NSInteger thatYear = [dateComponents year];
			if (thatYear >= thisYear) {
                if (displayTime) {
                    [displayFormatter setDateFormat:@"MMM d h:mm a"];
                }
                else {
                    [displayFormatter setDateFormat:@"MMM d"];
                }
			} else {
                if (displayTime) {
                    [displayFormatter setDateFormat:@"MMM d, yyyy h:mm a"];
                }
                else {
                    [displayFormatter setDateFormat:@"MMM d, yyyy"];
                }
			}
		}
		if (prefixed) {
			NSString *dateFormat = [displayFormatter dateFormat];
			NSString *prefix = @"'on' ";
			[displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
		}
	}
	
	// use display formatter to return formatted date string
	displayString = [displayFormatter stringFromDate:date];
    
    [displayFormatter release];
    
	return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
	return [[self class] stringForDisplayFromDate:date prefixed:prefixed alwaysDisplayTime:NO];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
	return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:format];
	NSString *timestamp_str = [outputFormatter stringFromDate:self];
	[outputFormatter release];
	return timestamp_str;
}

- (NSString *)string {
	return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateStyle:dateStyle];
	[outputFormatter setTimeStyle:timeStyle];
	NSString *outputString = [outputFormatter stringFromDate:self];
	[outputFormatter release];
	return outputString;
}

- (NSDate *)beginningOfWeek {
	// largely borrowed from "Date and Time Programming Guide for Cocoa"
	// we'll use the default calendar and hope for the best
	NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginningOfWeek = nil;
	BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
						   interval:NULL forDate:self];
	if (ok) {
		return beginningOfWeek;
	}
	
	// couldn't calc via range, so try to grab Sunday, assuming gregorian style
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
	
	/*
	 Create a date components to represent the number of days to subtract from the current date.
	 The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
	 */
	NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
	[componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
	beginningOfWeek = nil;
	beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
	[componentsToSubtract release];
	
	//normalize to midnight, extract the year, month, and day components and create a new date from those components.
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
											   fromDate:beginningOfWeek];
	return [calendar dateFromComponents:components];
}

- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
											   fromDate:self];
	return [calendar dateFromComponents:components];
}


- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
	NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
	// to get the end of week for a particular date, add (7 - weekday) days
	[componentsToAdd setDay:(7 - [weekdayComponents weekday])];
	NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
	[componentsToAdd release];
	
	return endOfWeek;
}

+ (NSString *)dateFormatString {
	return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
	return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
	return @"yyyy-MM-dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)dbFormatString {
	return [NSDate timestampFormatString];
}


////////////////////////////////////////////////////////////////////////////////////////////
+ (BOOL)isSameDay:(NSString*)oneDay anotherDay:(NSString*)anotherDay
{
    NSDate* oneDate = [NSDate dateFromString:oneDay];
    NSDate* anotherDate = [NSDate dateFromString:anotherDay];
    
    if ( [[oneDate beginningOfDay] isEqualToDate:[anotherDate beginningOfDay]])
    {
        return YES;
    }
    else
    {
        return FALSE;
    }
}

+ (NSTimeInterval)timeIntervalWithDate:(NSString *)strDate sinceDate:(NSString *)strAnotherDate
{
    NSDate *date = [[self class] dateFromString:strDate];
    NSDate *anotherDate = [[self class] dateFromString:strAnotherDate];
    return [date timeIntervalSinceDate:anotherDate];
}

+ (NSTimeInterval)timeIntervalWithDate:(NSString *)strDate
{
    NSDate *date = [[self class] dateFromString:strDate];
    return [date timeIntervalSinceDate:[NSDate date]];
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval withFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [NSDate stringFromDate:date withFormat:format];
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    return [NSDate stringFromTimeInterval:interval withFormat:@"yyyy年MM月dd日 HH:mm"];
}

+ (NSString *)dateStringFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDate *date = [NSDate dateFromString:string withFormat:format];
    return [NSDate stringFromDate:date withFormat:@"yyyy年MM月dd日"];
}

+ (BOOL)judgeIsOverTime:(NSString *)time withFormat:(NSString *)format
{
    NSString *dateString = [NSDate stringFromDate:[NSDate date] withFormat:format];
    return [NSDate timeIntervalWithDate:time sinceDate:dateString] >= 0;
}

+ (NSString *)stringTimesAgo:(NSString *)time withFormat:(NSString *)format
{
    NSDate *date = [NSDate dateFromString:time withFormat:format];
    
    NSInteger tyear = [NSDate year];
    NSInteger oyear = [[NSDate stringFromDate:date withFormat:@"yyyy"] intValue];
    if ( tyear != oyear )
    {
        return time;
    }
    else
    {
        NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate:date];
        
        if (diff < 60.f) {
            return @"刚刚";
        }
        
        diff = round(diff/60);
        if(diff < 60) {
            return [NSString stringWithFormat:@"%d分钟前", (int)diff];
        }
        
        diff = round(diff/60);
        if (diff < 24) {
            return [NSString stringWithFormat:@"%d小时前", (int)diff];
        }
        
        diff = round(diff/24);
        if (diff == 1) {
            return [NSDate stringFromDate:date withFormat:@"昨天 HH:mm"];
        } else {
            return [NSDate stringFromDate:date withFormat:@"MM月dd日 HH:mm"];
        }
    }
    
    return nil;
}

+ (NSString *)stringTimesAgo:(NSString *)time {
    return [NSDate stringTimesAgo:time withFormat:[NSDate timestampFormatString]];
}

+ (NSInteger)ageFromDate:(NSDate *)date
{
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeInterval = fabs(currentInterval - interval);
    return trunc(timeInterval / (60 * 60 * 24)) / 365;
}

+ (NSInteger)ageFromString:(NSString *)string
{
    NSDate *date = [NSDate dateFromString:string];
    return [NSDate ageFromDate:date];
}

+ (NSInteger)ageFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDate *date = [NSDate dateFromString:string withFormat:format];
    return [NSDate ageFromDate:date];
}

+ (NSDate*)dateDaysAgo:(NSUInteger)days fromDate:(NSDate*)fromDate
{
    NSDate* daysAgeOfDate;
    NSDate* date = fromDate;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* component = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSUInteger today = [component day];
    if (today < days)
    {
        if ([component month] == 1)
        {
            [component setMonth:12];
            [component setYear:[component year]-1];
            [component setDay:1];
            NSDate *firstDayDate = [calendar dateFromComponents:component];
            NSRange daysOfMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:firstDayDate];//获得该月的天数
            [component setDay:daysOfMonth.length - days + today];
        }
        else
        {
            [component setMonth:[component month]-1];
            [component setDay:1];
            NSDate *firstDayDate = [calendar dateFromComponents:component];
            NSRange daysOfMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:firstDayDate];//获得该月的天数
            [component setDay:daysOfMonth.length - days + today];
        }
    }
    else
    {
        [component setDay:[component day]-days];
    }
    daysAgeOfDate = [calendar dateFromComponents:component];
    return daysAgeOfDate;
}

+ (NSDate*)dateDaysAgo:(NSUInteger)days
{
    NSDate* daysAgeOfDate;
    daysAgeOfDate = [NSDate dateDaysAgo:days fromDate:[NSDate date]];
    return daysAgeOfDate;
}

+ (NSDate*)dateDaysAfter:(NSUInteger)days fromDate:(NSDate*)fromDate
{
    NSTimeInterval time = [fromDate timeIntervalSince1970];
    time+= 24*3600*days;
    NSDate* afterDay = [NSDate dateWithTimeIntervalSince1970:time];
    return afterDay;
}


@end