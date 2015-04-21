//
//  PKCourseModel.m
//  PKeeper
//
//  Created by mylonly on 15/3/14.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKCourseModel.h"

@implementation PKCourseModel

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _courseName = @"养鸡技术视频";
        _courseThumbUrl = [NSURL URLWithString:@"http://www.hhlcagri.gov.cn/uploadfile/D_1/D_664/D_814/doc/PicOnline_20111128111507_8e7726eb-9912-4b6f-a2e5-e7cbedb1c484.jpg"];
        _courseBrief = @"养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡";
        _courseDuration = 4880;
        _courseVideoUrl = [NSURL URLWithString:@"http://babyun-files.b0.upaiyun.com/videos/03/dd/33/61/42/03dd3361427aa0cbd8428c5ad76a8f0f.mp4"];
    }
    return self;
}

@end
