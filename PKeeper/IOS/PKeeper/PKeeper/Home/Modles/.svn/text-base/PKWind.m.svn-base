//
//  PKWind.m
//
//  Created by   on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PKWind.h"


NSString *const kPKWindSpeed = @"speed";
NSString *const kPKWindDeg = @"deg";


@interface PKWind ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PKWind

@synthesize speed = _speed;
@synthesize deg = _deg;


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
            self.speed = [[self objectOrNilForKey:kPKWindSpeed fromDictionary:dict] doubleValue];
            self.deg = [[self objectOrNilForKey:kPKWindDeg fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.speed] forKey:kPKWindSpeed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deg] forKey:kPKWindDeg];

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

    self.speed = [aDecoder decodeDoubleForKey:kPKWindSpeed];
    self.deg = [aDecoder decodeDoubleForKey:kPKWindDeg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_speed forKey:kPKWindSpeed];
    [aCoder encodeDouble:_deg forKey:kPKWindDeg];
}

- (id)copyWithZone:(NSZone *)zone
{
    PKWind *copy = [[PKWind alloc] init];
    
    if (copy) {

        copy.speed = self.speed;
        copy.deg = self.deg;
    }
    
    return copy;
}


@end
