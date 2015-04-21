//
//  PKRecordModel.h
//  PKeeper
//
//  Created by mylonly on 15/3/21.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    STAGETYPE_ONE = 1 ,//第一阶段
    STAGETYPE_TWO = 2 , //第二阶段
    STAGETYPE_THREE = 3 , //第三阶段
}STAGETYPE;

@interface PKRecordModel : NSObject

@property (nonatomic,assign) NSInteger recordID;

@property (nonatomic,assign) NSInteger recordDay;

@property (nonatomic,strong) NSString* recordDayStr;

@property (nonatomic,assign) BOOL isRecord;

@property (nonatomic,strong) NSString* houseID;

@property (nonatomic,assign) STAGETYPE stage;

@property (nonatomic,strong) NSString* batchNum;

@property (nonatomic,strong) NSString* recordContent;

@property (nonatomic,strong) NSMutableArray* picArray;

//第二阶段属性
@property (nonatomic,assign) BOOL isVaccine;  //是否免疫

@property (nonatomic,assign) BOOL isHealthcare; //是否保健

@property (nonatomic,assign) BOOL isDisinfect; //是否消毒

@property (nonatomic,assign) BOOL isOutinsect; //是否驱虫

@property (nonatomic,assign) CGFloat drinkWater; //饮水量

@property (nonatomic,strong) NSString* vaccineName; //疫苗名称

@property (nonatomic,strong) NSString* veterinaryDrugName; //兽药名称

@property (nonatomic,strong) NSString* disinfectCase; //消毒驱虫情况

@property (nonatomic,assign) CGFloat eatFood; //食物消耗

@property (nonatomic,assign) CGFloat eachWeight; //平均体重

@property (nonatomic,assign) NSInteger deadCount;  //死亡数量

@property (nonatomic,assign) NSInteger weedOut; //淘汰数量

@property (nonatomic,assign) CGFloat temperature; //温度

@property (nonatomic,assign) CGFloat humidity; //湿度

@property (nonatomic,assign) CGFloat sunning; //光照

- (id)initWithDict:(NSDictionary*)dict;

@end
