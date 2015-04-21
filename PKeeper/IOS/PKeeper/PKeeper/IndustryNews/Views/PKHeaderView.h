//
//  BBYHeaderView.h
//  PKeeper
//
//  Created by mylonly on 15/3/13.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKHeaderView;

@protocol PKHeaderViewDelegate <NSObject>

- (void)headerView:(PKHeaderView*)headerView withItem:(NSString*)item;

@end


@interface PKHeaderView : UIView

- (void)setItemArray:(NSArray*)array;

@property (nonatomic,weak) id<PKHeaderViewDelegate> delegate;

@end
