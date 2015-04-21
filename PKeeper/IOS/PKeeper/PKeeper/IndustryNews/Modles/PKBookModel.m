//
//  PKBookModel.m
//  PKeeper
//
//  Created by mylonly on 15/3/14.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKBookModel.h"

@implementation PKBookModel

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _bookName = @"养鸡";
        _bookAuthor = @"张饶学";
        _bookPrice = 25;
        _bookCoverUrl = [NSURL URLWithString:@"http://www.hhlcagri.gov.cn/uploadfile/D_1/D_664/D_814/doc/PicOnline_20111128111507_8e7726eb-9912-4b6f-a2e5-e7cbedb1c484.jpg"];
        _bookBrief = @"养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡养鸡";
    }
    return self;
}

@end
