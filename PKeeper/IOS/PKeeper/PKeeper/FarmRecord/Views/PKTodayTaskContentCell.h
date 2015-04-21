//
//  PKTodayTaskContentCell.h
//  PKeeper
//
//  Created by mylonly on 15/3/21.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PKTodayTaskContentCell;

@protocol PKTodayTaskContentCellDelegate <NSObject>

- (void)taskContentEndEdit:(NSString*)content;

@end

@interface PKTodayTaskContentCell : UITableViewCell

@property (nonatomic,strong) NSString* taskContent;

- (NSString*)getContent;

@property (nonatomic,weak) id<PKTodayTaskContentCellDelegate> delegate;

@end
