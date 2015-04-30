//
//  PKSys.m
//
//  Created by   on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PKSys.h"


NSString *const kPKSysMessage = @"message";
NSString *const kPKSysCountry = @"country";
NSString *const kPKSysSunset = @"sunset";
NSString *const kPKSysSunrise = @"sunrise";


@interface PKSys ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PKSys

@synthesize message = _message;
@synthesize country = _country;
@synthesize sunset = _sunset;
@synthesize sunrise = _sunrise;


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
            self.message = [[self objectOrNilForKey:kPKSysMessage fromDictionary:dict] doubleValue];
            self.country = [self objectOrNilForKey:kPKSysCountry fromDictionary:dict];
            self.sunset = [[self objectOrNilForKey:kPKSysSunset fromDictionary:dict] doubleValue];
            self.sunrise = [[self objectOrNilForKey:kPKSysSunrise fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.message] forKey:kPKSysMessage];
    [mutableDict setValue:self.country forKey:kPKSysCountry];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunset] forKey:kPKSysSunset];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunrise] forKey:kPKSysSunrise];

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

    self.message = [aDecoder decodeDoubleForKey:kPKSysMessage];
    self.country = [aDecoder decodeObjectForKey:kPKSysCountry];
    self.sunset = [aDecoder decodeDoubleForKey:kPKSysSunset];
    self.sunrise = [aDecoder decodeDoubleForKey:kPKSysSunrise];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_message forKey:kPKSysMessage];
    [aCoder encodeObject:_country forKey:kPKSysCountry];
    [aCoder encodeDouble:_sunset forKey:kPKSysSunset];
    [aCoder encodeDouble:_sunrise forKey:kPKSysSunrise];
}

- (id)copyWithZone:(NSZone *)zone
{
    PKSys *copy = [[PKSys alloc] init];
    
    if (copy) {

        copy.message = self.message;
        copy.country = [self.country copyWithZone:zone];
        copy.sunset = self.sunset;
        copy.sunrise = self.sunrise;
    }
    
    return copy;
}


@end
