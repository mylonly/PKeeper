//
//  PKTodayTaskCollectCell.h
//  PKeeper
//
//  Created by mylonly on 15/3/22.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PKTodayTaskCollectCellDelegate <NSObject>

- (void)itemCellSelected:(NSString*)itemName;

@end

@interface PKTodayTaskCollectCell : UITableViewCell


@property (nonatomic,strong) NSArray* itemDictArray;

@property (nonatomic,weak) id<PKTodayTaskCollectCellDelegate> delegate;

@end
