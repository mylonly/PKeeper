//
//  PKNSObject.h
//
//  Created by   on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PKWind, PKClouds, PKCoord, PKMain, PKSys;

@interface PKNSObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) PKWind *wind;
@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) PKClouds *clouds;
@property (nonatomic, strong) PKCoord *coord;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double dt;
@property (nonatomic, assign) double cod;
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, strong) PKMain *main;
@property (nonatomic, strong) PKSys *sys;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

+ (NSDictionary *)imageMap;


@end
