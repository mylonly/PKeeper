//
//  UIView+Mainpulation.h
//  PRG_MobileNews
//
//  Created by launching on 14-7-17.
//  Copyright (c) 2014年 launching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Mainpulation)

@property (assign, nonatomic) BOOL	visible;

// 移除所有子视图
- (void)removeAllSubviews;

// 设置阴影
- (void)addShadow;

// 旋转
- (void)rotation:(BOOL)stop;

@end
