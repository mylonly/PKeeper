//
//  BBYHeaderView.m
//  PKeeper
//
//  Created by mylonly on 15/3/13.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKHeaderView.h"
@interface PKHeaderView()
{
    NSArray* m_itemArray;
    CGFloat m_eachItemWidth;
    
    UIButton* preSelectedBtn;
}
@end

@implementation PKHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void)setItemArray:(NSArray *)array
{
    m_itemArray = array;
    m_eachItemWidth = (self.width - 50)/array.count;
    
    for (int i = 0; i < array.count ; i++)
    {
        NSString* item = array[i];
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(10+(m_eachItemWidth+10)*i, 0, m_eachItemWidth, 33)];
        btn.tag = 100+i;
        [btn setBackgroundImage:[UIImage imageNamed:STRFORMAT(@"%@_off",item)]];
        [btn setTitle:item forState:UIControlStateNormal];
        btn.titleLabel.font = FONT(14);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0)
        {
            [self itemAction:btn];
            preSelectedBtn = btn;
        }
    }
}

#pragma mark Action
- (void)itemAction:(UIButton*)sender
{
    if (preSelectedBtn == sender)
    {
        return;
    }
    sender.selected = !sender.selected;
    NSString* item = m_itemArray[sender.tag -100];
    [UIView animateWithDuration:0.1f animations:^{
        sender.height = 40;
        [sender setBackgroundImage :[UIImage imageNamed:STRFORMAT(@"%@_on",item)]];
        preSelectedBtn.height = 33;
        [preSelectedBtn setBackgroundImage:[UIImage imageNamed:STRFORMAT(@"%@_off",preSelectedBtn.titleLabel.text)]];
    } completion:^(BOOL finished) {
        preSelectedBtn = sender;
        if ([_delegate respondsToSelector:@selector(headerView:withItem:)])
        {
            [_delegate headerView:self withItem:item];
        }
    }];
}


@end
