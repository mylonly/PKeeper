//
//  PKEditBoard.h
//  PKeeper
//
//  Created by mylonly on 15/3/15.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKBaseBoard.h"
typedef enum
{
    EDITTYPE_TEXT = 0, //文本框编辑
    EDITTYPE_AGE = 1, //年龄
    EDITTYPE_GENDER = 2, //性别
    EDITTYPE_TIME = 3 , //时间
    EDITTYPE_MULTISELECT = 4, //多选
    EDITTYPE_ADDRESS = 6 ,// 详细地址
}EDITTYPE;

@protocol PKEditBoardDelegate <NSObject>

- (void)textChangedByItem:(NSString*)itemName changedText:(NSString*)text;

@end


@interface PKEditBoard : PKBaseBoard

@property (nonatomic,strong) NSString* modifyText;

@property (nonatomic,weak) id<PKEditBoardDelegate> delegate;

- (id)initWithType:(EDITTYPE)type withTitle:(NSString*)title;

@end
