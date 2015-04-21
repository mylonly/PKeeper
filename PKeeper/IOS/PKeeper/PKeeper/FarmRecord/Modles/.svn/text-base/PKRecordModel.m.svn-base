//
//  PKRecordModel.m
//  PKeeper
//
//  Created by mylonly on 15/3/21.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKRecordModel.h"

@implementation PKRecordModel

- (id)init
{
    self =  [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        _recordContent = [dict valueForKey:@"daycontent"];
        _stage =(STAGETYPE)[[dict valueForKey:@"stage"] integerValue];
        _recordDay = [[dict valueForKey:@"day"] integerValue];
        _recordDayStr = [[dict valueForKey:@"recordtime"] asNSString];
        NSString* pic = [[dict valueForKey:@"pic"] asNSString];
        _picArray = [[pic componentsSeparatedByString:@","] mutableCopy];
        
        _isVaccine = [[dict valueForKey:@"vaccine"] boolValue];
        _isHealthcare = [[dict valueForKey:@"healthcare"] boolValue];
        _isDisinfect = [[dict valueForKey:@"disinfect"] boolValue];
        _isOutinsect = [[dict valueForKey:@"outinsect"] boolValue];
        
        _deadCount = [[dict valueForKey:@"deadcount"] integerValue];
        _eachWeight = [[dict valueForKey:@"eachweight"] floatValue];
        _eatFood = [[dict valueForKey:@"eatfood"] floatValue];
        _humidity = [[dict valueForKey:@"humidity"] floatValue];
        
        _recordID = [[dict valueForKey:@"id"] integerValue];
        _sunning = [[dict valueForKey:@"sunning"] floatValue];
        _temperature = [[dict valueForKey:@"temperature"] floatValue];
        _weedOut = [[dict valueForKey:@"weedout"] integerValue];
        
        _drinkWater = [[dict valueForKey:@"eatwater"] floatValue];
        _vaccineName = [[dict valueForKey:@"vacname"] asNSString];
        _disinfectCase = [[dict valueForKey:@"disoutectdesc"] asNSString];
        _veterinaryDrugName = [[dict valueForKey:@"vetdrug"] asNSString];
    }
    return self;
}

@end
