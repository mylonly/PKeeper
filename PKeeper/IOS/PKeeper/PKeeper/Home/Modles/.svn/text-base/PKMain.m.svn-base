//
//  PKMain.m
//
//  Created by   on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PKMain.h"


NSString *const kPKMainHumidity = @"humidity";
NSString *const kPKMainTempMin = @"temp_min";
NSString *const kPKMainTempMax = @"temp_max";
NSString *const kPKMainTemp = @"temp";
NSString *const kPKMainPressure = @"pressure";
NSString *const kPKMainGrndLevel = @"grnd_level";
NSString *const kPKMainSeaLevel = @"sea_level";


@interface PKMain ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PKMain

@synthesize humidity = _humidity;
@synthesize tempMin = _tempMin;
@synthesize tempMax = _tempMax;
@synthesize temp = _temp;
@synthesize pressure = _pressure;
@synthesize grndLevel = _grndLevel;
@synthesize seaLevel = _seaLevel;


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
            self.humidity = [[self objectOrNilForKey:kPKMainHumidity fromDictionary:dict] doubleValue];
            self.tempMin = [[self objectOrNilForKey:kPKMainTempMin fromDictionary:dict] doubleValue];
            self.tempMax = [[self objectOrNilForKey:kPKMainTempMax fromDictionary:dict] doubleValue];
            self.temp = [[self objectOrNilForKey:kPKMainTemp fromDictionary:dict] doubleValue];
            self.pressure = [[self objectOrNilForKey:kPKMainPressure fromDictionary:dict] doubleValue];
            self.grndLevel = [[self objectOrNilForKey:kPKMainGrndLevel fromDictionary:dict] doubleValue];
            self.seaLevel = [[self objectOrNilForKey:kPKMainSeaLevel fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kPKMainHumidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMin] forKey:kPKMainTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tempMax] forKey:kPKMainTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp] forKey:kPKMainTemp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kPKMainPressure];
    [mutableDict setValue:[NSNumber numberWithDouble:self.grndLevel] forKey:kPKMainGrndLevel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.seaLevel] forKey:kPKMainSeaLevel];

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

    self.humidity = [aDecoder decodeDoubleForKey:kPKMainHumidity];
    self.tempMin = [aDecoder decodeDoubleForKey:kPKMainTempMin];
    self.tempMax = [aDecoder decodeDoubleForKey:kPKMainTempMax];
    self.temp = [aDecoder decodeDoubleForKey:kPKMainTemp];
    self.pressure = [aDecoder decodeDoubleForKey:kPKMainPressure];
    self.grndLevel = [aDecoder decodeDoubleForKey:kPKMainGrndLevel];
    self.seaLevel = [aDecoder decodeDoubleForKey:kPKMainSeaLevel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_humidity forKey:kPKMainHumidity];
    [aCoder encodeDouble:_tempMin forKey:kPKMainTempMin];
    [aCoder encodeDouble:_tempMax forKey:kPKMainTempMax];
    [aCoder encodeDouble:_temp forKey:kPKMainTemp];
    [aCoder encodeDouble:_pressure forKey:kPKMainPressure];
    [aCoder encodeDouble:_grndLevel forKey:kPKMainGrndLevel];
    [aCoder encodeDouble:_seaLevel forKey:kPKMainSeaLevel];
}

- (id)copyWithZone:(NSZone *)zone
{
    PKMain *copy = [[PKMain alloc] init];
    
    if (copy) {

        copy.humidity = self.humidity;
        copy.tempMin = self.tempMin;
        copy.tempMax = self.tempMax;
        copy.temp = self.temp;
        copy.pressure = self.pressure;
        copy.grndLevel = self.grndLevel;
        copy.seaLevel = self.seaLevel;
    }
    
    return copy;
}


@end
