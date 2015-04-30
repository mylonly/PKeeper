//
//  PKWeather.h
//
//  Created by   on 15/4/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PKWeather : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double weatherIdentifier;
@property (nonatomic, strong) NSString *main;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *weatherDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
