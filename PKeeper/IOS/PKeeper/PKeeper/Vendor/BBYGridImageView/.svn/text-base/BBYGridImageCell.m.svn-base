//
//  BBYGridImageCell.m
//  BabyunNew
//
//  Created by 田祥根 on 14/11/28.
//  Copyright (c) 2014年 mylony. All rights reserved.
//

#import "BBYGridImageCell.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+XHURLDownload.h"
#import "BBYGridImagesView.h"

@interface BBYGridImageCell ()
{
    UIActivityIndicatorView* indicator;
}
@end


@implementation BBYGridImageCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:indicator];
        indicator.hidesWhenStopped = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
//    if ([newSuperview isKindOfClass:[BBYGridImagesView class]])
//    {
//        [self sd_cancelCurrentImageLoad];
//        if (self.thumbImage)
//        {
//            self.image = self.thumbImage;
//        }
//        else
//        {
//            [self sd_setImageWithPreviousCachedImageWithURL:[BBYAppManager getImageUrl:self.imageName withSize:self.size] andPlaceholderImage:[UIImage imageNamed:@"defaultPic.png"] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                self.thumbImage = image;
//            }];
//        }
//    }
//    else
//    {
//        [self sd_setImageWithURL:[BBYAppManager getRealImageUrl:self.imageName] placeholderImage:self.thumbImage options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.realImage = image;
//        }];
//    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    NSLog(@"SSSS");
}

- (void)showLoading
{
    indicator.hidden = NO;
    indicator.center = self.center;
    [indicator startAnimating];
}

- (void)hideLoading
{
    [indicator stopAnimating];
}

- (void)setIsShake:(BOOL)isShake
{
    _isShake = isShake;
}

@end
