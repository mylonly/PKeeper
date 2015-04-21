//
//  LCSegmentedControl.m
//  LitchiCommunity
//
//  Created by launching on 14-2-13.
//  Copyright (c) 2014年 launching. All rights reserved.
//

#import "LCSegmentedControl.h"

@implementation LCSegmentedControl

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    if ( self = [super initWithFrame:frame items:items iconPosition:IconPositionRight] )
    {
        self.color = RGB(255, 79, 74);
        self.borderWidth = 1.5;
        self.borderColor = [UIColor whiteColor];
        self.selectedColor = [UIColor whiteColor];
        self.textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]};
        self.selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:RGB(255, 79, 74)};
    }
    return self;
}

@end
