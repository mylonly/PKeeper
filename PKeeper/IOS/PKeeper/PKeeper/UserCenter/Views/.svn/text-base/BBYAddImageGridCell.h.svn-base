//
//  BBYAddImageGridCell.h
//  PKeeper
//
//  Created by 田祥根 on 15/3/20.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    CELLACTION_CAMERA = 0, //相机
    CELLACTION_THUMB = 1, //相册
}CELLACTION;

@class BBYAddImageGridCell;

@protocol BBYAddImageGridCellDelegate <NSObject>

- (void)cellAction:(BBYAddImageGridCell*)cell action:(CELLACTION)action;

@end


@interface BBYAddImageGridCell : UITableViewCell

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,strong) NSString* cellTitle;

@property (nonatomic,weak) NSMutableArray* imageArray;

@property (nonatomic,weak) id<BBYAddImageGridCellDelegate> delegate;

@end
