//
//  PKRecordCell.m
//  PKeeper
//
//  Created by mylonly on 15/3/21.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKRecordCell.h"
@interface PKRecordCell()
{
    UILabel* m_title;
    UIImageView* m_recordTag;
    UILabel* m_recordText;
    UIView* m_container;
}
@end


@implementation PKRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        m_container = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
        m_container.backgroundColor = RGB(253, 251, 243);
        [self.contentView addSubview:m_container];
    
        m_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        m_title.backgroundColor = RGB(203, 239, 16);
        m_title.textAlignment = NSTextAlignmentCenter;
        [m_container addSubview:m_title];
        
        m_recordTag = [[UIImageView alloc] initWithFrame:CGRectMake(170,12.5, 15, 15)];
        [m_container addSubview:m_recordTag];
        
        m_recordText = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 100, 40)];
        m_recordText.textAlignment = NSTextAlignmentCenter;
        [m_container addSubview:m_recordText];
        
        UIImageView* indicator = [[UIImageView alloc] initWithFrame:CGRectMake(280, 10, 10, 20)];
        indicator.image = [UIImage imageNamed:@"recordlist_right"];
        [m_container addSubview:indicator];
    }
    return self;
}

- (void)setCellTitle:(NSString*)title isRecord:(BOOL)isRecord
{
    m_title.text = title;
    if (isRecord)
    {
        m_recordTag.image = [UIImage imageNamed:@"recordlist_gou"];
        m_recordText.text = @"已记录";
    }
    else
    {
        m_recordText.text = @"未记录";
        m_recordTag.image = [UIImage imageNamed:@"recordlist_cha"];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
