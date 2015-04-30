//
//  PKCoord.m
//
//  Created by   on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PKCoord.h"


NSString *const kPKCoordLon = @"lon";
NSString *const kPKCoordLat = @"lat";


@interface PKCoord ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PKCoord

@synthesize lon = _lon;
@synthesize lat = _lat;


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
            self.lon = [[self objectOrNilForKey:kPKCoordLon fromDictionary:dict] doubleValue];
            self.lat = [[self objectOrNilForKey:kPKCoordLat fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lon] forKey:kPKCoordLon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kPKCoordLat];

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

    self.lon = [aDecoder decodeDoubleForKey:kPKCoordLon];
    self.lat = [aDecoder decodeDoubleForKey:kPKCoordLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_lon forKey:kPKCoordLon];
    [aCoder encodeDouble:_lat forKey:kPKCoordLat];
}

- (id)copyWithZone:(NSZone *)zone
{
    PKCoord *copy = [[PKCoord alloc] init];
    
    if (copy) {

        copy.lon = self.lon;
        copy.lat = self.lat;
    }
    
    return copy;
}


@end
