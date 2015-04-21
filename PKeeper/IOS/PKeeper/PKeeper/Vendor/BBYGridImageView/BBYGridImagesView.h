//
//  BBYGridImagesView.h
//  BabyunNew
//
//  Created by 田祥根 on 14/11/26.
//  Copyright (c) 2014年 mylony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBYGridImagesView : UIView

@property (nonatomic,assign) CGFloat imageWidth;   //图片宽度,默认根据view的frame计算

@property (nonatomic,assign) CGFloat imageHeight;  //图片高度，默认等于高度

@property (nonatomic,assign) NSInteger countOfRow; //每行图片的数量，默认为3

@property (nonatomic,strong) NSArray* images;

@property (nonatomic,strong) NSArray* imageUrls; //图片url列表

@property (nonatomic,strong) UIImage* placeHolderImage; //仅当通过url获取图片时需要

@property (nonatomic,strong) NSArray* realImageUrls;//大图Url，当单击图片预览图片时需要

@end
