//
//  FKHUDHelper.m
//  PRG_MobileNews
//
//  Created by launching on 14-7-23.
//  Copyright (c) 2014年 launching. All rights reserved.
//

#import "FKHUDHelper.h"
#import "MBProgressHUD.h"

@implementation FKHUDHelper
{
    MBProgressHUD *__indicatorView;
}

DEF_SINGLETON( FKHUDHelper );

#pragma mark - loading tips

- (void)presentLoadingTips:(NSString *)tips
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self presentLoadingTips:tips fromView:window];
}

- (void)presentLoadingTips:(NSString *)tips fromView:(UIView *)view
{
    __indicatorView = [[MBProgressHUD alloc] initWithView:view];
    __indicatorView.LabelText = tips;
    [view addSubview:__indicatorView];
    [__indicatorView show:YES];
}

- (void)dismissTips
{
    [__indicatorView hide:YES];
}


#pragma mark - message tips

- (void)presentMessageTips:(NSString *)tips
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self presentMessageTips:tips fromView:window];
}

- (void)presentMessageTips:(NSString *)tips fromView:(UIView *)view
{
    [self presentMessageTips:tips progressMode:FKProgressHUDModeText fromView:view];
}

- (void)presentMessageTips:(NSString *)tips progressMode:(FKProgressHUDMode)mode fromView:(UIView *)view
{
    [self dismissTips];
    
    MBProgressHUD *progressView = [[MBProgressHUD alloc ]initWithView:view];
	[view addSubview:progressView];
    
    if (mode == FKProgressHUDModeWaring) {
        progressView.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_warnning"]];
    } else {
        progressView.customView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    progressView.mode = MBProgressHUDModeCustomView;
    progressView.LabelText = tips;
    [progressView show:NO];
    [self performBlock:^{
        [progressView hide:YES];
    } afterDelay:2.0];
}

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end
