//
//  PKChickenHouseModel.h
//  PKeeper
//
//  Created by 田祥根 on 15/3/16.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    CHICKENTYPE_SPRJKDX = 1 , //商品肉鸡(快大型)
    CHICKENTYPE_HYRJ = 2 , //黄羽肉鸡
    CHICKENTYPE_QJMJ = 3 , //青脚麻鸡
    CHICKENTYPE_OTHER = 4 , //其他
}CHICKENTYPE; //养殖类型

typedef enum
{
    HOUSESCALETYPE_LESS_10 = 1 ,//小于10万只
    HOUSESCALETYPE_LESS_50 = 2 ,//小于50万只
    HOUSESCALETYPE_LESS_100 = 3, //小于100万只
    HOUSESCALETYPE_LESS_200 = 4,//小于200万只
    HOUSESCALETYPE_MORE_200 = 5, //大于200万只
}HOUSESCALETYPE; //养殖规模

typedef enum
{
    FARMTYPE_DMPY = 1, //地面平养
    FARMTYPE_WSPY = 2, //网上平养
    FARMTYPE_LY = 3,   //笼养
    FARMTYPE_SY = 4,   //散养
    FARMTYPE_OTHER = 5, //其他
}FARMTYPE; //养殖方式

typedef enum
{
    CHICKENHOUSETYPE_ZHJY = 1, //砖混简易
    CHICKENHOUSETYPE_FBGJ = 2, //封闭钢架
    CHICKENHOUSETYPE_DP = 3, //大棚
    CHICKENHOUSETYPE_OTHER = 4, //其他
}CHICKENHOUSETYPE;//鸡舍类型

typedef enum
{
    SUPPORTWATERTYPE_AUTO_SXJSH = 1, //全自动:水线加水壶
    SUPPORTWATERTYPE_AUTO_SXJRT = 2, //全自动:水线加乳头
    SUPPORTWATERTYPE_ASSIT_HOUMAN = 3, //人工辅助
    SUPPORTWATERTYPE_OTHER = 4, //其他
}SUPPORTWATERTYPE;//供水方式

typedef enum
{
    SUPPORTFOODTYPE_AUTOFOOD = 1, //全自动供料
    SUPPORTFOODTYPE_HUMANFOOD = 2, //人工供料
    SUPPORTFOODTYPE_OTHER = 3 , //其他
}SUPPORTFOODTYPE;//供料方式

typedef enum
{
    CLEARSHITTYPE_AUTO = 1, //自动供粪
    CLEARSHITTYPE_CLEAROUT = 2, //出栏后清粪
    CLEARSHITTYPE_OTHER = 3 ,//其他
}CLEARSHITTYPE;//清粪方式

typedef enum
{
    CHICKAGETYPE_DY = 1, //单一日龄
    CHICKAGETYPE_HY = 2, //多日龄混养
}CHICKAGETYPE;           //鸡邻组成

@interface PKChickenHouseModel : NSObject

@property (nonatomic,strong) NSString* houseID;

@property (nonatomic,strong) NSString* houseName;

@property (nonatomic,strong) NSString* houseAddress;

//鸡场规模

@property (nonatomic,strong) NSString* houseScaleTypeStr;
@property (nonatomic,assign) HOUSESCALETYPE houseScaleType;
@property (nonatomic,strong) NSArray* houseScaleTypeAry;

@property (nonatomic,strong) NSString* houseCreatedTime;
@property (nonatomic,strong) NSString* ChickenTime; //进鸡时间

//肉鸡类型
@property (nonatomic,assign) CHICKENTYPE chickenType;
@property (nonatomic,strong) NSString* chickenTypeStr;
@property (nonatomic,strong) NSArray* chickenTypeAry;

//养殖方式
@property (nonatomic,assign) FARMTYPE farmType;
@property (nonatomic,strong) NSString* farmTypeStr;
@property (nonatomic,strong) NSArray* farmTypeAry;

//鸡舍类型
@property (nonatomic,assign) CHICKENHOUSETYPE chickenHouseType;
@property (nonatomic,strong) NSString* chickenHouseTypeStr;
@property (nonatomic,strong) NSArray* chickenHouseTypeAry;

//供水方式
@property (nonatomic,assign) SUPPORTWATERTYPE supportWaterType;
@property (nonatomic,strong) NSString* supportWaterTypeStr;
@property (nonatomic,strong) NSArray* supportWaterTypeAry;

//供料方式
@property (nonatomic,assign) SUPPORTFOODTYPE supportFoodType;
@property (nonatomic,strong) NSString* supportFoodTypeStr;
@property (nonatomic,strong) NSArray* supportFoodTypeAry;

//清粪方式
@property (nonatomic,assign) CLEARSHITTYPE clearShitType;
@property (nonatomic,strong) NSString* clearShitTypeStr;
@property (nonatomic,strong) NSArray* clearShitTypeAry;

//鸡邻组成
@property (nonatomic,assign) CHICKAGETYPE chickenAgeType;
@property (nonatomic,strong) NSString* chickenAgeTypeStr;
@property (nonatomic,strong) NSArray* chickenAgeTypeAry;

@property (nonatomic,strong) NSMutableArray* imageUrlArray;
@property (nonatomic,strong) NSMutableArray* imageDataArray;

AS_SINGLETON(PKChickenHouseModel)

- (void)constractWithDict:(NSDictionary*)dict;

- (void)getchickenInfo;

- (void)submitChickenInfo;

- (BOOL)checkCompleted;

@end
