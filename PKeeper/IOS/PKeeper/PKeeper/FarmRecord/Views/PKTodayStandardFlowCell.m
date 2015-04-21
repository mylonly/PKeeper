//
//  PKTodayStandardFlowCell.m
//  PKeeper
//
//  Created by mylonly on 15/3/21.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKTodayStandardFlowCell.h"
@interface PKTodayStandardFlowCell()
{
    UITextView* m_standardFlow;
}
@end

@implementation PKTodayStandardFlowCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = RGB(240, 240, 240);
        UIView* contanierView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 170)];
        contanierView.layer.cornerRadius = 5.f;
        contanierView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contanierView];
        
        UIImageView* sepe = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 170)];
        sepe.image = [UIImage imageNamed:@"addrecord_biankuang"];
        [contanierView addSubview:sepe];
        
        UILabel* tips = [[UILabel alloc] initWithFrame:CGRectMake(20, 5 , 200, 20)];
        tips.text = @"今天应该做这些";
        tips.textColor = RGB(249, 127, 36);
        [contanierView addSubview:tips];
    
        m_standardFlow = [[UITextView alloc] initWithFrame:CGRectMake(20, 25, 280, 150)];
        m_standardFlow.editable = NO;
        [contanierView addSubview:m_standardFlow];
    }
    return self;
}

- (void)setStandardFlow:(NSString *)standardFlow
{
    _standardFlow = standardFlow;
    m_standardFlow.text = standardFlow;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
