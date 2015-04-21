//
//  UIView+Mainpulation.m
//  PRG_MobileNews
//
//  Created by launching on 14-7-17.
//  Copyright (c) 2014年 launching. All rights reserved.
//

#import "UIView+Mainpulation.h"

@implementation UIView (Mainpulation)

@dynamic visible;

- (BOOL)visible
{
	return self.hidden ? NO : YES;
}

- (void)setVisible:(BOOL)flag
{
	self.hidden = flag ? NO : YES;
}

- (void)removeAllSubviews
{
	if ( self.subviews.count > 0 ) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    }
}

- (void)addShadow
{
    [[self layer] setShadowPath:[UIBezierPath bezierPathWithRect:self.bounds].CGPath];
    [[self layer] setShadowOffset:CGSizeMake(1, 2)];
    [[self layer] setShadowOpacity:0.80];
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
}

- (void)rotation:(BOOL)stop
{
    if ( !stop )
    {
        CABasicAnimation *rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0 ];
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotationAnimation.duration = 2;
        rotationAnimation.RepeatCount = MAXFLOAT;
        rotationAnimation.cumulative = NO;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.fillMode = kCAFillModeForwards;
        [self.layer addAnimation:rotationAnimation forKey:@"Rotation"];
    }
    else
    {
        [self.layer removeAnimationForKey:@"Rotation"];
    }
}

@end
