//
//  PKCourseCell.m
//  PKeeper
//
//  Created by mylonly on 15/3/13.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKCourseCell.h"
@interface PKCourseCell()
{
    UIImageView* m_courseThumb;
    UILabel* m_courseName;
    UILabel* m_courseDuration;
    UILabel* m_courseBrief;
}
@end

@implementation PKCourseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        m_courseThumb = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 70)];
        [self.container addSubview:m_courseThumb];
        
        UIButton* playBtn = [[UIButton alloc] initWithFrame:m_courseThumb.bounds];
        [playBtn setImage:[UIImage imageNamed:@"playIcon"] forState:UIControlStateNormal];
        [m_courseThumb addSubview:playBtn];
        
        m_courseName = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 140, 20)];
        [self.container addSubview:m_courseName];
        
        m_courseDuration = [[UILabel alloc] initWithFrame:CGRectMake(240, 10, 60, 20)];
        m_courseDuration.textColor = [UIColor grayColor];
        m_courseDuration.font = FONT(10);
        [self.container addSubview:m_courseDuration];
        
        m_courseBrief = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 200, 60)];
        m_courseBrief.textColor = [UIColor grayColor];
        m_courseBrief.numberOfLines = 3;
        [self.container addSubview:m_courseBrief];
        
    }
    return self;
}

- (void)setCellData:(PKNewsModel *)cellData
{
    _cellData = cellData;
    [m_courseThumb sd_setImageWithURL:cellData.newsThumbUrl placeholderImage:DEFAULTIMAGE];
    m_courseName.text = cellData.newsTitle;
//    m_courseDuration.text = [NSString stringWithFormat:@"%d:%d:%d",cellData.courseDuration/60/60,cellData.courseDuration/60%60,cellData.courseDuration%60%60];
    m_courseBrief.text = cellData.newsSummary;
}

@end
