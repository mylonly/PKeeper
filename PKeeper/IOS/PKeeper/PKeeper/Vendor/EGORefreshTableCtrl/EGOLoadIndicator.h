//
//  EGOLoadIndicator.h
//  JstvNews
//
//  Created by launching on 14-2-20.
//  Copyright (c) 2014年 kukuasir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGOLoadIndicator : UIView

@property (nonatomic, assign) float progress;

- (void)startRotation;
- (void)stopRotation;

@end
