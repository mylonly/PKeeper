//
//  PKSickReportModel.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/23.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKSickReportModel.h"

@implementation PKSickReportModel

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _reportID = [[dict valueForKey:@"id"] asNSString];
        _reportTitle = [[dict valueForKey:@"title"] asNSString];
        _reportContent = [[dict valueForKey:@"desc"] asNSString];
        NSString* pic = [[dict valueForKey:@"pic"] asNSString];
        if (![pic isEqualToString:@""]) {
            _picArray = [pic componentsSeparatedByString:@","];
        }
        _responseUserID = [[dict valueForKey:@"resuserid"] asNSString];
        _responseCreator = [[dict valueForKey:@"resname"] asNSString];
        _responseContent = [[dict valueForKey:@"resdesc"] asNSString];
        _responseCreatorTime = [[dict valueForKey:@"restime"] asNSString];
    }
    return self;
}

@end
