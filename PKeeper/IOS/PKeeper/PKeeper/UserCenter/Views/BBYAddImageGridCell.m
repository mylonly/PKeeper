//
//  BBYAddImageGridCell.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/20.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "BBYAddImageGridCell.h"
#import "BBYGridImagesView.h"
@interface BBYAddImageGridCell()
{
    UILabel* m_cellTitle;
    BBYGridImagesView* m_gridImageView;
    UIView* m_bottomView;
}
@end


@implementation BBYAddImageGridCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        m_cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 20)];
        m_cellTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:m_cellTitle];
        
        m_gridImageView = [[BBYGridImagesView alloc] initWithFrame:CGRectMake(20, 30, SCREENWIDTH-40, 0)];
        [self.contentView addSubview:m_gridImageView];
        
        m_bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];
        [self.contentView addSubview:m_bottomView];
        
        UIButton* addPicFromCameraBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 45, 45)];
        [addPicFromCameraBtn addTarget:self action:@selector(cameraAction:) forControlEvents:UIControlEventTouchUpInside];
        [addPicFromCameraBtn setImage:[UIImage imageNamed:@"addPicFromCamera"] forState:UIControlStateNormal];
        [m_bottomView addSubview:addPicFromCameraBtn];
        
        UIButton* addPicFromThumbBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 10, 45, 45)];
        [addPicFromThumbBtn addTarget:self action:@selector(thumbAction:) forControlEvents:UIControlEventTouchUpInside];
        [addPicFromThumbBtn setImage:[UIImage imageNamed:@"addPicFromThumb"] forState:UIControlStateNormal];
        [m_bottomView addSubview:addPicFromThumbBtn];
        _cellHeight = 110;
    }
    return self;
}


#pragma mark ACTION
- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    m_cellTitle.text = cellTitle;
}

- (void)setImageArray:(NSMutableArray *)imageArray
{
    [m_gridImageView setImages:imageArray];
    m_bottomView.y = m_gridImageView.y+m_gridImageView.height;
    _cellHeight = m_bottomView.y+m_bottomView.height;
}

- (void)cameraAction:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(cellAction:action:)])
    {
        [_delegate cellAction:self action:CELLACTION_CAMERA];
    }
}

- (void)thumbAction:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(cellAction:action:)])
    {
        [_delegate cellAction:self action:CELLACTION_THUMB];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
