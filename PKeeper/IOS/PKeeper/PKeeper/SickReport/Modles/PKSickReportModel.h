//
//  PKSickReportModel.h
//  PKeeper
//
//  Created by 田祥根 on 15/3/23.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKSickReportModel : NSObject

@property (nonatomic,strong) NSString* reportID;

@property (nonatomic,strong) NSString* reportTitle;

@property (nonatomic,strong) NSString* reportContent;

@property (nonatomic,strong) NSArray* picArray;

@property (nonatomic,strong) NSString* responseUserID;

@property (nonatomic,strong) NSString* responseContent;

@property (nonatomic,strong) NSString* responseCreator;

@property (nonatomic,strong) NSString* responseCreatorTime;

- (id)initWithDict:(NSDictionary*)dict;

@end
