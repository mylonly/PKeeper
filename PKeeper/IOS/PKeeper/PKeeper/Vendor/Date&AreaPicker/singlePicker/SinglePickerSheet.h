//
//  GenderPickerSheet.h
//  PKeeper
//
//  Created by 田祥根 on 15/3/16.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPickerSheetDelegate.h"

@interface SinglePickerSheet : UIView

@property (nonatomic,weak) id<UIPickerSheetDelegate> delegate;

@property (nonatomic,strong) NSString* pickerString;

@property (nonatomic,assign) NSInteger pickerIndex;

@property (nonatomic,strong) NSArray* itemArray;

- (id)initWithTitle:(NSString *)title delegate:(id<UIPickerSheetDelegate>)delegate;

- (void)showInView:(UIView *)view;

@end
