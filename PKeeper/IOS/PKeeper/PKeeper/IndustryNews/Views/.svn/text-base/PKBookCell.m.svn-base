//
//  PKDataCell.m
//  PKeeper
//
//  Created by mylonly on 15/3/13.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKBookCell.h"

@interface PKBookCell()
{
    UIImageView* m_bookCover;
    UILabel* m_bookName;
    UILabel* m_bookPrivce;
    UILabel* m_bookBrief;
}
@end


@implementation PKBookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        m_bookCover = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 70)];
        [self.container addSubview:m_bookCover];
        
        m_bookName = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 140, 20)];
        m_bookName.font = [UIFont boldSystemFontOfSize:18];
        [self.container addSubview:m_bookName];
        
        m_bookPrivce = [[UILabel alloc] initWithFrame:CGRectMake(240, 10, 60, 20)];
        m_bookPrivce.textColor = [UIColor grayColor];
        m_bookPrivce.font = FONT(10);
        [self.container addSubview:m_bookPrivce];
        
        m_bookBrief = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 200, 60)];
        m_bookBrief.font = FONT(16);
        m_bookBrief.numberOfLines = 2.f;
        m_bookBrief.textColor = [UIColor grayColor];
        [self.container addSubview:m_bookBrief];
    }
    return self;
}

- (void)setCellData:(PKNewsModel *)cellData
{
    [m_bookCover sd_setImageWithURL:cellData.newsThumbUrl placeholderImage:DEFAULTIMAGE];
    m_bookName.text = cellData.newsTitle;
    m_bookPrivce.text = [cellData.newsCreatedTime substringToIndex:11];
    m_bookBrief.text = cellData.newsSummary;
}

@end
