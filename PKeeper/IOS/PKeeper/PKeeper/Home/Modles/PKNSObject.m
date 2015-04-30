//
//  PKNSObject.m
//
//  Created by   on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PKNSObject.h"
#import "PKWind.h"
#import "PKClouds.h"
#import "PKCoord.h"
#import "PKWeather.h"
#import "PKMain.h"
#import "PKSys.h"


NSString *const kPKNSObjectWind = @"wind";
NSString *const kPKNSObjectBase = @"base";
NSString *const kPKNSObjectClouds = @"clouds";
NSString *const kPKNSObjectCoord = @"coord";
NSString *const kPKNSObjectId = @"id";
NSString *const kPKNSObjectDt = @"dt";
NSString *const kPKNSObjectCod = @"cod";
NSString *const kPKNSObjectWeather = @"weather";
NSString *const kPKNSObjectMain = @"main";
NSString *const kPKNSObjectSys = @"sys";
NSString *const kPKNSObjectName = @"name";


@interface PKNSObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PKNSObject

@synthesize wind = _wind;
@synthesize base = _base;
@synthesize clouds = _clouds;
@synthesize coord = _coord;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize dt = _dt;
@synthesize cod = _cod;
@synthesize weather = _weather;
@synthesize main = _main;
@synthesize sys = _sys;
@synthesize name = _name;


+ (NSDictionary *)imageMap {
    // 1
    static NSDictionary *_imageMap = nil;
    if (! _imageMap) {
        // 2
        _imageMap = @{
                      @"01d" : @"晴",
                      @"02d" : @"少云",
                      @"03d" : @"阴天",
                      @"04d" : @"多云",
                      @"09d" : @"大雨",
                      @"10d" : @"中雨",
                      @"11d" : @"闪电",
                      @"13d" : @"大雪",
                      @"50d" : @"雾",
                      @"01n" : @"夜晚 晴",
                      @"02n" : @"夜晚 晴",
                      @"03n" : @"夜晚多云",
                      @"04n" : @"夜晚多云",
                      @"09n" : @"大雨",
                      @"10n" : @"中雨",
                      @"11n" : @"闪电",
                      @"13n" : @"大雪-snow",
                      @"50n" : @"雾",
                      };
    }
    return _imageMap;
}

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
            self.wind = [PKWind modelObjectWithDictionary:[dict objectForKey:kPKNSObjectWind]];
            self.base = [self objectOrNilForKey:kPKNSObjectBase fromDictionary:dict];
            self.clouds = [PKClouds modelObjectWithDictionary:[dict objectForKey:kPKNSObjectClouds]];
            self.coord = [PKCoord modelObjectWithDictionary:[dict objectForKey:kPKNSObjectCoord]];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kPKNSObjectId fromDictionary:dict] doubleValue];
            self.dt = [[self objectOrNilForKey:kPKNSObjectDt fromDictionary:dict] doubleValue];
            self.cod = [[self objectOrNilForKey:kPKNSObjectCod fromDictionary:dict] doubleValue];
    NSObject *receivedPKWeather = [dict objectForKey:kPKNSObjectWeather];
    NSMutableArray *parsedPKWeather = [NSMutableArray array];
    if ([receivedPKWeather isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPKWeather) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPKWeather addObject:[PKWeather modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPKWeather isKindOfClass:[NSDictionary class]]) {
       [parsedPKWeather addObject:[PKWeather modelObjectWithDictionary:(NSDictionary *)receivedPKWeather]];
    }

    self.weather = [NSArray arrayWithArray:parsedPKWeather];
            self.main = [PKMain modelObjectWithDictionary:[dict objectForKey:kPKNSObjectMain]];
            self.sys = [PKSys modelObjectWithDictionary:[dict objectForKey:kPKNSObjectSys]];
            self.name = [self objectOrNilForKey:kPKNSObjectName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.wind dictionaryRepresentation] forKey:kPKNSObjectWind];
    [mutableDict setValue:self.base forKey:kPKNSObjectBase];
    [mutableDict setValue:[self.clouds dictionaryRepresentation] forKey:kPKNSObjectClouds];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kPKNSObjectCoord];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kPKNSObjectId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kPKNSObjectDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cod] forKey:kPKNSObjectCod];
    NSMutableArray *tempArrayForWeather = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weather) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeather addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeather addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kPKNSObjectWeather];
    [mutableDict setValue:[self.main dictionaryRepresentation] forKey:kPKNSObjectMain];
    [mutableDict setValue:[self.sys dictionaryRepresentation] forKey:kPKNSObjectSys];
    [mutableDict setValue:self.name forKey:kPKNSObjectName];

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

    self.wind = [aDecoder decodeObjectForKey:kPKNSObjectWind];
    self.base = [aDecoder decodeObjectForKey:kPKNSObjectBase];
    self.clouds = [aDecoder decodeObjectForKey:kPKNSObjectClouds];
    self.coord = [aDecoder decodeObjectForKey:kPKNSObjectCoord];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kPKNSObjectId];
    self.dt = [aDecoder decodeDoubleForKey:kPKNSObjectDt];
    self.cod = [aDecoder decodeDoubleForKey:kPKNSObjectCod];
    self.weather = [aDecoder decodeObjectForKey:kPKNSObjectWeather];
    self.main = [aDecoder decodeObjectForKey:kPKNSObjectMain];
    self.sys = [aDecoder decodeObjectForKey:kPKNSObjectSys];
    self.name = [aDecoder decodeObjectForKey:kPKNSObjectName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_wind forKey:kPKNSObjectWind];
    [aCoder encodeObject:_base forKey:kPKNSObjectBase];
    [aCoder encodeObject:_clouds forKey:kPKNSObjectClouds];
    [aCoder encodeObject:_coord forKey:kPKNSObjectCoord];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kPKNSObjectId];
    [aCoder encodeDouble:_dt forKey:kPKNSObjectDt];
    [aCoder encodeDouble:_cod forKey:kPKNSObjectCod];
    [aCoder encodeObject:_weather forKey:kPKNSObjectWeather];
    [aCoder encodeObject:_main forKey:kPKNSObjectMain];
    [aCoder encodeObject:_sys forKey:kPKNSObjectSys];
    [aCoder encodeObject:_name forKey:kPKNSObjectName];
}

- (id)copyWithZone:(NSZone *)zone
{
    PKNSObject *copy = [[PKNSObject alloc] init];
    
    if (copy) {

        copy.wind = [self.wind copyWithZone:zone];
        copy.base = [self.base copyWithZone:zone];
        copy.clouds = [self.clouds copyWithZone:zone];
        copy.coord = [self.coord copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.dt = self.dt;
        copy.cod = self.cod;
        copy.weather = [self.weather copyWithZone:zone];
        copy.main = [self.main copyWithZone:zone];
        copy.sys = [self.sys copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
