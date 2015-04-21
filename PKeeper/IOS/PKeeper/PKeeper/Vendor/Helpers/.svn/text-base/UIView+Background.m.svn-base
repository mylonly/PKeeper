//
//  UIView+Background.m
//  PRG_MobileNews
//
//  Created by launching on 14-7-17.
//  Copyright (c) 2014年 launching. All rights reserved.
//

#import "UIView+Background.h"

@implementation UIView (Background)

@dynamic backgroundImageView;
@dynamic backgroundImage;

- (UIImageView *)backgroundImageView
{
	UIImageView *imageView = nil;
	
	for ( UIView *subView in self.subviews )
	{
		if ( [subView isKindOfClass:[UIImageView class]] ) {
			imageView = (UIImageView *)subView;
			break;
		}
	}
    
	if ( nil == imageView )
	{
		imageView = [[UIImageView alloc] initWithFrame:self.bounds];
		imageView.autoresizesSubviews = YES;
		imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		imageView.contentMode = UIViewContentModeScaleToFill;
		[self addSubview:imageView];
		[self sendSubviewToBack:imageView];
	}
	
	return imageView;
}

- (UIImage *)backgroundImage
{
	return self.backgroundImageView.image;
}

- (void)setBackgroundImage:(UIImage *)image
{
	UIImageView * imageView = self.backgroundImageView;
	if ( imageView )
	{
		if ( image )
		{
			imageView.image = image;
			imageView.frame = self.bounds;
			[imageView setNeedsDisplay];
		}
		else
		{
			imageView.image = nil;
			[imageView removeFromSuperview];
		}
	}
}

@end
