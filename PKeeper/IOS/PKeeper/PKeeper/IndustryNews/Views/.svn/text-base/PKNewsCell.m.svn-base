//
//  PKNewsCell.m
//  PKeeper
//
//  Created by mylonly on 15/3/13.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKNewsCell.h"
@interface PKNewsCell()
{
    UIImageView* m_newsThumbImage;
    UILabel* m_newsTitle;
    UILabel* m_newsSummary;
    UILabel* m_newsCreatedTime;
}
@end


@implementation PKNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        m_newsThumbImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 70)];
        [self.container addSubview:m_newsThumbImage];
        
        m_newsTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 140, 20)];
        m_newsTitle.font = FONT(18);
        [self.container addSubview:m_newsTitle];
        
        m_newsCreatedTime = [[UILabel alloc] initWithFrame:CGRectMake(240, 10, 60, 20)];
        m_newsCreatedTime.textColor = [UIColor grayColor];
        m_newsCreatedTime.font = FONT(10);
        [self.container addSubview:m_newsCreatedTime];
        
        m_newsSummary = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 200, 60)];
        m_newsSummary.font = FONT(16);
        m_newsSummary.numberOfLines = 2.f;
        m_newsSummary.textColor = [UIColor grayColor];
        [self.container addSubview:m_newsSummary];
    }
    return self;
}

- (void)setCellData:(PKNewsModel *)cellData
{
    _cellData = cellData;
    if(_cellData.newsThumbUrl)
    {
        [m_newsThumbImage sd_setImageWithURL:cellData.newsThumbUrl placeholderImage:DEFAULTIMAGE options:SDWebImageRefreshCached];
        m_newsTitle.x = 100;
        m_newsTitle.width = 140;
        m_newsSummary.x = 100;
        m_newsSummary.width = 200;
    }
    else
    {
        m_newsTitle.x = 10;
        m_newsSummary.x = 10;
        m_newsSummary.width = 280;
        m_newsTitle.width = 230;
    }
    m_newsTitle.text = cellData.newsTitle;
    m_newsSummary.text = cellData.newsSummary;
    m_newsCreatedTime.text = [cellData.newsCreatedTime substringToIndex:11];
}


@end
