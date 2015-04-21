//
//  PKUploadImage.h
//  PKeeper
//
//  Created by mylonly on 15/3/15.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UpYun.h"

@interface PKUploadImage : NSObject

@property (nonatomic,strong) UIImage* image;

@property (nonatomic,strong) NSData* imageData;

@property (nonatomic,strong) NSString* savekey;

@property (nonatomic,strong) NSString* imageName;

@property (nonatomic,strong) NSString* MD5;

- (void)uploadWithSuccessBlock:(SUCCESS_BLOCK)successBolck withProgressBlock:(PROGRESS_BLOCK)progressBolck;

@end
