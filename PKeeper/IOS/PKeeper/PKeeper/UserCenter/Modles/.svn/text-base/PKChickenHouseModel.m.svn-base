//
//  PKChickenHouseModel.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/16.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKChickenHouseModel.h"
#import "PKUploadImage.h"

@implementation PKChickenHouseModel

DEF_SINGLETON(PKChickenHouseModel)

- (id)init
{
    self = [super init];
    if (self)
    {
        _chickenTypeAry = @[@"商品肉鸡(快大型)",@"黄羽肉鸡",@"青脚麻鸡",@"其他"];
        _houseScaleTypeAry = @[@"小于10万只",@"小于50万只",@"小于100万只",@"小于200万只",@"大于200万只"];
        _farmTypeAry = @[@"地面平养",@"网上平养",@"笼养",@"散养",@"其他"];
        _chickenHouseTypeAry = @[@"砖混简易",@"封闭钢架",@"大棚",@"其他"];
        _supportWaterTypeAry = @[@"全自动:水线加水壶",@"全自动:水线加乳头",@"人工辅助",@"其他"];
        _supportFoodTypeAry  =@[@"全自动供料",@"人工供料",@"其他"];
        _clearShitTypeAry = @[@"自动供粪",@"出栏后清粪",@"其他"];
        _chickenAgeTypeAry = @[@"单一日龄",@"多日龄混养"];
        _imageDataArray = [[NSMutableArray alloc] init];
        _imageUrlArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)constractWithDict:(NSDictionary *)dict
{
    if(!dict || [dict isKindOfClass:[NSNull class]])
    {
        return;
    }
    _houseID = [[dict valueForKey:@"cfactoryId"] asNSString];
    _houseName = [[dict valueForKey:@"cfactoryName"] asNSString];
    _houseAddress = [[dict valueForKey:@"cfactoryAddress"] asNSString];
    _houseCreatedTime = [[dict valueForKey:@"cbuildTime"] asNSString];
    
    self.houseScaleType = [[dict valueForKey:@"cfactoryScale"] integerValue];
    self.chickenHouseType = [[dict valueForKey:@"croomType"] integerValue];
    self.farmType = [[dict valueForKey:@"cfactoryMode"] integerValue];
    self.supportWaterType = [[dict valueForKey:@"cwaterSupply"] integerValue];
    self.supportFoodType = [[dict valueForKey:@"cfoodSupply"] integerValue];
    self.clearShitType = [[dict valueForKey:@"clearExcrement"] integerValue];
    self.chickenAgeType = [[dict valueForKey:@"cgroupStyle"] integerValue];
    self.chickenType = [[dict valueForKey:@"cfactoryType"] integerValue];
    
    NSString* imageUrl = [[dict valueForKey:@"picnames"] asNSString];
    [_imageUrlArray addObjectsFromArray:[imageUrl componentsSeparatedByString:@","]];
}

- (BOOL)checkCompleted
{
    if (!_houseID || [_houseID isEqualToString:@""])
    {
        return NO;
    }
    if (!_houseName || [_houseName isEqualToString:@""])
    {
        return NO;
    }
    if (!_houseAddress || [_houseAddress isEqualToString:@""])
    {
        return NO;
    }
    if (!_houseCreatedTime || [_houseCreatedTime isEqualToString:@""])
    {
        return NO;
    }
    
    return _houseScaleType && _chickenHouseType && _farmType && _supportFoodType && _supportWaterType && _clearShitType && _chickenAgeType && _chickenType;
}

- (void)getchickenInfo
{
    NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID};
    ASIHTTPRequest* request = [JSHttpHelper post:GET_CHICKENINFO withValue:param withDelegate:self withUserInfo:@"GetChickenInfo"];
    [request startAsynchronous];
}

- (void)submitChickenInfo
{
    [self uploadImage];
}

- (void)uploadImage
{
    if (_imageDataArray.count == 0)
    {
        [self submit];
    }
    __block int successUpload = 0;
    for (NSData* imageData in self.imageDataArray)
    {
        PKUploadImage* image = [[PKUploadImage alloc] init];
        image.imageData = imageData;
        [image uploadWithSuccessBlock:^(id result) {
            successUpload++;
            NSLog(@"image:%@上传成功",image.imageName);
            [_imageUrlArray addObject:UPYUNIMAGEPATH(image.savekey)];
            if (successUpload == _imageDataArray.count)
            {
                [self submit];
            }
        } withProgressBlock:^(CGFloat percent, long long requestDidSendBytes, long long totalBytes) {
        }];
    }
}

- (void)submit
{
    if(_houseID)
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"cfactoryId":_houseID,
                                @"cfactoryName":[PKChickenHouseModel shareInstance].houseName,
                                @"cfactoryAddress":[PKChickenHouseModel shareInstance].houseAddress,
                                @"cfactoryScale":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].houseScaleType],
                                @"cbuildTime":[PKChickenHouseModel shareInstance].houseCreatedTime,
                                @"croomType":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].chickenHouseType],
                                @"cfactoryMode":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].farmType],
                                @"cwaterSupply":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].supportWaterType],
                                @"cfoodSupply":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].supportFoodType],
                                @"clearExcrement":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].clearShitType],
                                @"cgroupStyle":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].chickenAgeType],
                                @"cfactoryType":[NSNumber numberWithInteger:_chickenType],
                                @"picnames":[_imageUrlArray componentsJoinedByString:@","]};
        ASIHTTPRequest* request = [JSHttpHelper get:UPDATE_CHICKENINFO withValue:param withDelegate:self withUserInfo:@"UpdateChickenInfo"];
        [request startAsynchronous];
    }
    else
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"cfactoryName":[PKChickenHouseModel shareInstance].houseName,
                                @"cfactoryAddress":[PKChickenHouseModel shareInstance].houseAddress,
                                @"cfactoryScale":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].houseScaleType],
                                @"cbuildTime":[PKChickenHouseModel shareInstance].houseCreatedTime,
                                @"croomType":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].chickenHouseType],
                                @"cfactoryMode":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].farmType],
                                @"cwaterSupply":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].supportWaterType],
                                @"cfoodSupply":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].supportFoodType],
                                @"clearExcrement":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].clearShitType],
                                @"cgroupStyle":[NSNumber numberWithInteger:[PKChickenHouseModel shareInstance].chickenAgeType],
                                @"cfactoryType":[NSNumber numberWithInteger:_chickenType],
                                @"picnames":[_imageUrlArray componentsJoinedByString:@","]};
        ASIHTTPRequest* request = [JSHttpHelper get:SUBMIT_CHICKENINFO withValue:param withDelegate:self withUserInfo:@"SubmitChickenInfo"];
        [request startAsynchronous];
    }
}

- (void)requestDidFailed:(ASIHTTPRequest *)theRequest
{
}

- (void)requestDidFinished:(ASIHTTPRequest *)theRequest
{
    NSLog(@"response:%@",theRequest.responseString);
    NSString* userInfo =  [theRequest.userInfo objectForKey:@"userInfo"];
    NSDictionary* response = [[CJSONDeserializer deserializer]deserialize:theRequest.responseData error:nil];
    NSString* message = [[response objectForKey:@"info"] asNSString];
    BOOL success = [[response objectForKey:@"result"] boolValue];
    if (!success)
    {
        NSLog(@"提交鸡场信息出错:%@",message);
        return;
    }
    else
    {
        if ([userInfo isEqualToString:@"SubmitChickenInfo"])
        {
            NSDictionary* dict = [response objectForKey:@"data"];
            _houseID = [[dict valueForKey:@"cfactoryId"] asNSString];
        }
        else if ([userInfo isEqualToString:@"UpdateChickenInfo"])
        {
            NSLog(@"更新鸡场信息成功");
        }
        else if ([userInfo isEqualToString:@"GetChickenInfo"])
        {
            NSDictionary* data = [response objectForKey:@"data"];
            [_imageUrlArray removeAllObjects];
            [self constractWithDict:data];
            
        }
    }
}


- (void)setHouseScaleType:(HOUSESCALETYPE)houseScaleType
{
    _houseScaleType = houseScaleType;
    if (houseScaleType)
    {
        _houseScaleTypeStr = _houseScaleTypeAry[houseScaleType-1];
    }
    else
    {
        _houseScaleTypeStr = @"未填写";
    }
}

- (void)setChickenHouseType:(CHICKENHOUSETYPE)chickenHouseType
{
    _chickenHouseType = chickenHouseType;
    if (chickenHouseType)
    {
        _chickenHouseTypeStr = _chickenHouseTypeAry[chickenHouseType-1];
    }
    else
    {
        _chickenHouseTypeStr = @"未填写";
    }
}

- (void)setFarmType:(FARMTYPE)farmType
{
    _farmType = farmType;
    if (farmType)
    {
        _farmTypeStr = _farmTypeAry[farmType-1];
    }
    else
    {
        _farmTypeStr = @"未填写";
    }
}

- (void)setSupportWaterType:(SUPPORTWATERTYPE)supportWaterType
{
    _supportWaterType = supportWaterType;
    if (supportWaterType)
    {
        _supportWaterTypeStr = _supportWaterTypeAry[supportWaterType-1];
    }
    else
    {
        _supportWaterTypeStr = @"未填写";
    }
}

- (void)setSupportFoodType:(SUPPORTFOODTYPE)supportFoodType
{
    _supportFoodType = supportFoodType;
    if (supportFoodType)
    {
        _supportFoodTypeStr = _supportFoodTypeAry[supportFoodType-1];
    }
    else
    {
        _supportFoodTypeStr = @"未填写";
    }
}

- (void)setClearShitType:(CLEARSHITTYPE)clearShitType
{
    _clearShitType = clearShitType;
    if (clearShitType)
    {
        _clearShitTypeStr = _clearShitTypeAry[clearShitType-1];
    }
    else
    {
        _clearShitTypeStr = @"未填写";
    }
}

- (void)setChickenAgeType:(CHICKAGETYPE)chickenAgeType
{
    _chickenAgeType = chickenAgeType;
    if (chickenAgeType)
    {
        _chickenAgeTypeStr = _chickenAgeTypeAry[chickenAgeType-1];
    }
    else
    {
        _chickenAgeTypeStr = @"未填写";
    }
}

- (void)setChickenType:(CHICKENTYPE)chickenType
{
    _chickenType  = chickenType;
    if (chickenType)
    {
        _chickenTypeStr = _chickenTypeAry[chickenType-1];
    }
    else
    {
        _chickenTypeStr = @"未填写";
    }
}


@end
