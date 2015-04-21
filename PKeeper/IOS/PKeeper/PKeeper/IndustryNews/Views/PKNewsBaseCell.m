//
//  PKNewsBaseCell.m
//  PKeeper
//
//  Created by mylonly on 15/3/13.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKNewsBaseCell.h"
@interface PKNewsBaseCell()
{
    
}
@end


@implementation PKNewsBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = RGB(240, 240, 240);
        _container = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 90)];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.cornerRadius = 5.f;
        [self.contentView addSubview:_container];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
