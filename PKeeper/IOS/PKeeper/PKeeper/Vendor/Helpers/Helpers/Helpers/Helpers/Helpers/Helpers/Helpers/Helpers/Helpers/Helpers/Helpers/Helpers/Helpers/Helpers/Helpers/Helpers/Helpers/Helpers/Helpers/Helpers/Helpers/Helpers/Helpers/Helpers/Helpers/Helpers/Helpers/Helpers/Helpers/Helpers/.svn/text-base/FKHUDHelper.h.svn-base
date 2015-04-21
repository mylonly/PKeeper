//
//  FKHUDHelper.h
//  PRG_MobileNews
//
//  Created by launching on 14-7-23.
//  Copyright (c) 2014年 launching. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FKProgressHUDModeIndeterminate,
	FKProgressHUDModeText,
	FKProgressHUDModeWaring
} FKProgressHUDMode;

@interface FKHUDHelper : NSObject

AS_SINGLETON( FKHUDHelper );

// 加载loading提示
- (void)presentLoadingTips:(NSString *)tips;
- (void)presentLoadingTips:(NSString *)tips fromView:(UIView *)view;
- (void)dismissTips;

// 加载消息提示
- (void)presentMessageTips:(NSString *)tips;
- (void)presentMessageTips:(NSString *)tips fromView:(UIView *)view;
- (void)presentMessageTips:(NSString *)tips progressMode:(FKProgressHUDMode)mode fromView:(UIView *)view;

@end
