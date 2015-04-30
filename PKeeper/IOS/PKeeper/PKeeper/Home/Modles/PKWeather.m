//
//  PKWeather.m
//
//  Created by   on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PKWeather.h"


NSString *const kPKWeatherId = @"id";
NSString *const kPKWeatherMain = @"main";
NSString *const kPKWeatherIcon = @"icon";
NSString *const kPKWeatherDescription = @"description";


@interface PKWeather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PKWeather

@synthesize weatherIdentifier = _weatherIdentifier;
@synthesize main = _main;
@synthesize icon = _icon;
@synthesize weatherDescription = _weatherDescription;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.weatherIdentifier = [[self objectOrNilForKey:kPKWeatherId fromDictionary:dict] doubleValue];
            self.main = [self objectOrNilForKey:kPKWeatherMain fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kPKWeatherIcon fromDictionary:dict];
            self.weatherDescription = [self objectOrNilForKey:kPKWeatherDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weatherIdentifier] forKey:kPKWeatherId];
    [mutableDict setValue:self.main forKey:kPKWeatherMain];
    [mutableDict setValue:self.icon forKey:kPKWeatherIcon];
    [mutableDict setValue:self.weatherDescription forKey:kPKWeatherDescription];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.weatherIdentifier = [aDecoder decodeDoubleForKey:kPKWeatherId];
    self.main = [aDecoder decodeObjectForKey:kPKWeatherMain];
    self.icon = [aDecoder decodeObjectForKey:kPKWeatherIcon];
    self.weatherDescription = [aDecoder decodeObjectForKey:kPKWeatherDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_weatherIdentifier forKey:kPKWeatherId];
    [aCoder encodeObject:_main forKey:kPKWeatherMain];
    [aCoder encodeObject:_icon forKey:kPKWeatherIcon];
    [aCoder encodeObject:_weatherDescription forKey:kPKWeatherDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    PKWeather *copy = [[PKWeather alloc] init];
    
    if (copy) {

        copy.weatherIdentifier = self.weatherIdentifier;
        copy.main = [self.main copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.weatherDescription = [self.weatherDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
