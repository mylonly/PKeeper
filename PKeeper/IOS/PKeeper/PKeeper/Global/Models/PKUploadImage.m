//
//  PKUploadImage.m
//  PKeeper
//
//  Created by mylonly on 15/3/15.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKUploadImage.h"
#import "NSData+MD5Digest.h"

@implementation PKUploadImage

- (void)setImage:(UIImage*)image
{
    _image = image;
     _imageData = UIImageJPEGRepresentation(image,0.5);
    _MD5 = [_imageData MD5HexDigest];
    _imageName = [NSString stringWithFormat:@"%@.jpg",_MD5];
    _savekey = [NSString stringWithFormat:@"%@/%@",[NSDate stringFromDate:[NSDate date] withFormat:@"yyyyMMdd"],_imageName];
}

- (void)setImageData:(NSData *)imageData
{
    _imageData = imageData;
    _image = [UIImage imageWithData:imageData];
    _MD5 = [_imageData MD5HexDigest];
    _imageName = [NSString stringWithFormat:@"%@.jpg",_MD5];
    _savekey = [NSString stringWithFormat:@"%@/%@",[NSDate stringFromDate:[NSDate date] withFormat:@"yyyyMMdd"],_imageName];
}

- (void)uploadWithSuccessBlock:(SUCCESS_BLOCK)successBolck withProgressBlock:(PROGRESS_BLOCK)progressBolck
{
    UpYun* upyun = [[UpYun alloc] init];
    upyun.successBlocker = successBolck;
    upyun.progressBlocker = progressBolck;
    [upyun uploadFile:_imageData saveKey:_savekey];
}

@end
