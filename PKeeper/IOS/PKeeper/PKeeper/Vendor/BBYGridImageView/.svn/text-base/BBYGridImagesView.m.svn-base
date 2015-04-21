//
//  BBYGridImagesView.m
//  BabyunNew
//
//  Created by 田祥根 on 14/11/26.
//  Copyright (c) 2014年 mylony. All rights reserved.
//
#define IMAGEVIEWBASETAG 1000


#import "BBYGridImagesView.h"
#import "UIView+Metrics.h"
#import "UIImageView+WebCache.h"
#import "BBYGridImageCell.h"
#import "UIImageView+XHURLDownload.h"
#import "SDWebImageDownloader.h"
#import "XHImageViewer.h"

@interface BBYGridImagesView ()<XHImageViewerDelegate>
{
    BOOL isTap; //XHImageViewer 存在一个同时点击两张图片导致的bug，用此变量杜绝同时点击两张图片
    BOOL isFull;
    NSMutableArray* showImageViews; //传入XHImageViewer的subViews显示顺序不对，用此数组维护图片的顺序。
    NSInteger currentIndex;
    BOOL shakeMode; //shake状态
    NSMutableArray* realImages;
    XHImageViewer* m_imageViewer;
}
@end

@implementation BBYGridImagesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_imageViewer = [[XHImageViewer alloc] init];
        m_imageViewer.delegate = self;
        m_imageViewer.backgroundScale = 1.f;

        //默认计算图片的imageWidth 和imageHeight
        self.countOfRow = 3;
        self.imageWidth = (self.width - IMAGESPACE*2)/self.countOfRow;
        self.imageHeight = self.imageWidth;
        self.placeHolderImage = [UIImage imageNamed:@"defaultImage.png"];
        showImageViews = [[NSMutableArray alloc] init];
        realImages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setImages:(NSArray *)images
{
    for (UIView* sub in self.subviews)
    {
        [sub removeFromSuperview];
    }
    self.height = 0;
    for (int i = 0; i < images.count; i++)
    {
        int row = i/_countOfRow;
        int column = i%_countOfRow;
        BBYGridImageCell* imageView = [[BBYGridImageCell alloc] initWithFrame:CGRectMake((_imageWidth+IMAGESPACE)*column, (_imageHeight+IMAGESPACE)*row, _imageWidth, _imageHeight)];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        UILongPressGestureRecognizer* longPressTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        imageView.gestureRecognizers = [NSArray arrayWithObjects:singleTap,longPressTap,nil];
        if ([images[i] isKindOfClass:[NSData class]])
        {
            imageView.image = [UIImage imageWithData:images[i]];
        }
        else if ([images[i] isKindOfClass:[NSString class]])
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:DEFAULTIMAGE];
        }
        else
        {
            imageView.image = images[i];
        }
        imageView.tag = IMAGEVIEWBASETAG + i;
        [self addSubview:imageView];
        self.height = imageView.y+imageView.height;
    }
}

- (void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    for (UIView* sub in self.subviews)
    {
        [sub removeFromSuperview];
    }
    self.height = 0;
    for (int i = 0; i < imageUrls.count; i++)
    {
        int row = i/_countOfRow;
        int column = i%_countOfRow;
        BBYGridImageCell* imageView = [[BBYGridImageCell alloc] initWithFrame:CGRectMake((_imageWidth+IMAGESPACE)*column, (_imageHeight+IMAGESPACE)*row, _imageWidth, _imageHeight)];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        //UILongPressGestureRecognizer* longPressTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [imageView addGestureRecognizer:singleTap];
        //[imageView addGestureRecognizer:longPressTap];
        imageView.tag = IMAGEVIEWBASETAG + i;
        [self addSubview:imageView];
        self.height = imageView.y+imageView.height;
    }
}


#pragma mark Action

- (void)singleTapAction:(UITapGestureRecognizer*)gesture
{
    isFull = YES;
    BBYGridImageCell* selectedView =(BBYGridImageCell*)gesture.view;
    currentIndex = selectedView.tag - IMAGEVIEWBASETAG;
    [m_imageViewer showWithImageViews:self.subviews selectedView:selectedView];
    if (_realImageUrls)
    {
        [selectedView loadWithURL:_realImageUrls[currentIndex] placeholer:nil showActivityIndicatorView:YES completionBlock:^(UIImage *image, NSURL *url, NSError *error) {
            if (!error) {
            }
        }];
    }
}


- (void)longPressAction:(UILongPressGestureRecognizer*)gesture
{
//    if (gesture.state == UIGestureRecognizerStateBegan)
//    {
//        for (BBYGridImageCell* v in self.subviews)
//        {
//            [v setIsShake:!v.isShake];
//        }
//    }
}


#pragma mark XHImageViewer delegate
- (void)imageViewer:(XHImageViewer *)imageViewer didChangeToImageView:(UIImageView *)selectedView
{
    currentIndex = selectedView.tag - IMAGEVIEWBASETAG;
    [selectedView loadWithURL:_realImageUrls[currentIndex] placeholer:nil showActivityIndicatorView:YES completionBlock:^(UIImage *image, NSURL *url, NSError *error) {
        if (!error) {
        }
    }];
}

- (void)imageViewer:(XHImageViewer *)imageViewer willDismissWithSelectedView:(UIImageView *)selectedView
{
    selectedView.transform = CGAffineTransformMakeRotation(2*M_PI);
}

- (void)imageViewer:(XHImageViewer *)imageViewer didDismissWithSelectedView:(UIImageView *)selectedView
{
    
}

- (UIView*)customTopToolBarOfImageViewer:(XHImageViewer *)imageViewer
{
    UIView* topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    UIButton* rotateBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 20, 40, 40)];
    [rotateBtn setImage:[UIImage imageNamed:@"trainingCenter_refreash"] forState:UIControlStateNormal];
    [rotateBtn addTarget:self action:@selector(rotateAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rotateBtn];
    return topView;
}

- (void)rotateAction:(UIButton*)sender
{
    UIView* imageView =  [m_imageViewer currentView];
    imageView.transform = CGAffineTransformRotate(imageView.transform,M_PI/2);
    NSLog(@"%@",imageView);
}

- (UIView*)customBottomToolBarOfImageViewer:(XHImageViewer *)imageViewer
{
    UIButton* downLoadBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, imageViewer.height - 80, 40, 40)];
    [downLoadBtn setImage:[UIImage imageNamed:@"icon_download.png"] forState:UIControlStateNormal];
    [downLoadBtn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    return downLoadBtn;
}

- (void)downloadAction:(UIButton*)sender
{
    UIImageWriteToSavedPhotosAlbum([m_imageViewer currentView].image,self,@selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
//    if(error != NULL)
//    {
//        [BBYAppManager showTips:[NSString stringWithFormat:@"%@",error]];
//    }
//    else
//    {
//        [BBYAppManager showTips:@"已成功保存至相册"];
//    }
}
@end
