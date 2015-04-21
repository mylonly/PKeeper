//
//  PKUserModel.m
//  PKeeper
//
//  Created by mylonly on 15/3/15.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKUserModel.h"

@implementation PKUserModel

DEF_SINGLETON(PKUserModel)

- (void)constructWithDict:(NSDictionary *)dict
{
    [PKUserModel shareInstance].userID = [[dict valueForKey:@"userId"] asNSString];
    [PKUserModel shareInstance].username = [[dict valueForKey:@"userName"] asNSString];
    [PKUserModel shareInstance].address  =[[dict valueForKey:@"address"] asNSString];
    [PKUserModel shareInstance].age = [[dict valueForKey:@"age"] asNSString];
    [PKUserModel shareInstance].email = [[dict valueForKey:@"email"] asNSString];
    [PKUserModel shareInstance].gender = [[dict valueForKey:@"gender"] asNSString];
    [PKUserModel shareInstance].mobile = [[dict valueForKey:@"mobile"] asNSString];
    [PKUserModel shareInstance].avatarUrl = [[dict valueForKey:@"picAddress"] asNSString];
    [PKUserModel shareInstance].qqNum = [[dict valueForKey:@"qq"] asNSString];
    [PKUserModel shareInstance].realName = [[dict valueForKey:@"realName"] asNSString];
    [PKUserModel shareInstance].workYear = [[dict valueForKey:@"workyear"] asNSString];
    [PKUserModel shareInstance].province = [[dict valueForKey:@"province"] asNSString];
    [PKUserModel shareInstance].city = [[dict valueForKey:@"city"] asNSString];
}

- (BOOL)checkCompleted
{
    if (!_address || [_address isEqualToString:@""])
    {
        return NO;
    }
    if (!_age || [_address isEqualToString:@""])
    {
        return NO;
    }
    if (!_email || [_email isEqualToString:@""])
    {
        return NO;
    }
    if (!_gender || [_gender isEqualToString:@""])
    {
        return NO;
    }
    if (!_mobile || [_mobile isEqualToString:@""])
    {
        return NO;
    }
    if (!_avatarUrl || [_avatarUrl isEqualToString:@""])
    {
        return NO;
    }
    if (!_qqNum || [_qqNum isEqualToString:@""])
    {
        return NO;
    }
    if (!_realName || [_realName isEqualToString:@""])
    {
        return NO;
    }
    if (!_province || [_province isEqualToString:@""])
    {
        return NO;
    }
    if (!_city || [_city isEqualToString:@""])
    {
        return NO;
    }
    return YES;
}

@end
