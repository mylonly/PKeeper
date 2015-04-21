//
//  BBYGridImageCell.h
//  BabyunNew
//
//  Created by 田祥根 on 14/11/28.
//  Copyright (c) 2014年 mylony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBYGridImageCell : UIImageView

@property (nonatomic,assign) BOOL isShake;

@property (nonatomic,strong) UIImage* deleteIcon;

@property (nonatomic,strong) NSString* imageName;

@property (nonatomic,strong) UIImage* thumbImage;

@property (nonatomic,strong) UIImage* realImage;

- (void)showLoading;

- (void)hideLoading;

@end
