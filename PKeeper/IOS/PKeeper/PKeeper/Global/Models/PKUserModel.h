//
//  PKUserModel.h
//  PKeeper
//
//  Created by mylonly on 15/3/15.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKUserModel : NSObject

@property (nonatomic,strong) NSString* userID;

@property (nonatomic,strong) NSString* username;

@property (nonatomic,strong) NSString* realName;

@property (nonatomic,strong) NSString* workYear;

@property (nonatomic,strong) NSString* province;

@property (nonatomic,strong) NSString* city;

@property (nonatomic,strong) NSString* address;

@property (nonatomic,strong) NSString* age;

@property (nonatomic,strong) NSString* email;

@property (nonatomic,strong) NSString* gender;

@property (nonatomic,strong) NSString* mobile;

@property (nonatomic,strong) NSString* avatarUrl;

@property (nonatomic,strong) NSString* qqNum;

AS_SINGLETON(PKUserModel)

- (void)constructWithDict:(NSDictionary*)dict;

- (BOOL)checkCompleted;

@end
