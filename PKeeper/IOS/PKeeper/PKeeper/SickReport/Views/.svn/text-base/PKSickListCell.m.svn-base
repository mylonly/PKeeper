//
//  PKSickListCell.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/23.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKSickListCell.h"
@interface PKSickListCell()
{
    UIImageView* m_preImageView;
    UILabel* m_sickContent;
    UILabel* m_sickTitle;
    UILabel* m_replayState;
}
@end

@implementation PKSickListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = RGB(240, 240, 240);
        
        UIView* container = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 100)];
        container.layer.cornerRadius = 5.f;
        container.backgroundColor = [UIColor whiteColor];
        container.layer.borderWidth = 0.5f;
        container.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:container];
        
        m_sickTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        [container addSubview:m_sickTitle];
        
        m_sickContent = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 200, 40)];
        m_sickContent.textColor = [UIColor grayColor];
        [container addSubview:m_sickContent];
        
        m_preImageView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 10, 70, 70)];
        [container addSubview:m_preImageView];
        
        m_replayState = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 100, 20)];
        m_replayState.font = [UIFont systemFontOfSize:14];
        m_replayState.layer.cornerRadius = 4.f;
        m_replayState.textAlignment = NSTextAlignmentCenter;
        [container addSubview:m_replayState];
    }
    return self;
}

- (void)setCellData:(PKSickReportModel *)cellData
{
    _cellData = cellData;
    m_sickTitle.text = cellData.reportTitle;
    m_sickContent.text = cellData.reportContent;
    if (_cellData.picArray.count)
    {
        m_preImageView.hidden = NO;
        m_sickContent.width = 200;
        m_preImageView.x = 200;
        [m_preImageView sd_setImageWithURL:[NSURL URLWithString:_cellData.picArray[0]] placeholderImage:DEFAULTIMAGE];
    }
    else
    {
        m_preImageView.hidden = YES;
        m_sickContent.width = 300;
    }
    
    if ([cellData.responseUserID isEqualToString:@"0"])
    {
        m_replayState.text = @"等待回复";
        m_replayState.textColor = RGB(255, 175, 89);
        m_replayState.layer.borderColor = RGB(255, 175, 89).CGColor;
        m_replayState.layer.borderWidth = 1.0f;
    }
    else
    {
        m_replayState.text = @"收到回复";
        m_replayState.textColor = RGB(111, 185, 255);
        m_replayState.layer.borderColor = RGB(111, 185, 255).CGColor;
        m_replayState.layer.borderWidth = 1.0f;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
