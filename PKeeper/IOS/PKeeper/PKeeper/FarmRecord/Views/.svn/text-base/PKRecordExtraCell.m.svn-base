//
//  PKRecordExtraCell.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/26.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKRecordExtraCell.h"
@interface PKRecordExtraCell()
{
    UIButton* m_isVaccineBtn;    //免疫
    UIButton* m_isHealthcareBtn; //保健
    UIButton* m_isDisinfectBtn;  //消毒
    UIButton* m_isOutinsectBtn;  //保健
}
@end

@implementation PKRecordExtraCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        m_isVaccineBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
        m_isVaccineBtn.layer.masksToBounds = YES;
        m_isVaccineBtn.layer.cornerRadius = 5.f;
        [m_isVaccineBtn setBackgroundImage:[UIImage imageWithColor:RGB(123,181,61) andSize:m_isVaccineBtn.size] forState:UIControlStateSelected];
        [m_isVaccineBtn setBackgroundImage:[UIImage imageWithColor:RGB(240, 239, 245) andSize:m_isVaccineBtn.size] forState:UIControlStateNormal];
        [m_isVaccineBtn setTitle:@"免疫" forState:UIControlStateNormal];
        [m_isVaccineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [m_isVaccineBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:m_isVaccineBtn];
        
        m_isHealthcareBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 10, 60, 30)];
        m_isHealthcareBtn.layer.masksToBounds = YES;
        m_isHealthcareBtn.layer.cornerRadius = 5.f;
        [m_isHealthcareBtn setBackgroundImage:[UIImage imageWithColor:RGB(123,181,61) andSize:m_isVaccineBtn.size] forState:UIControlStateSelected];
        [m_isHealthcareBtn setBackgroundImage:[UIImage imageWithColor:RGB(240, 239, 245) andSize:m_isVaccineBtn.size] forState:UIControlStateNormal];
        [m_isHealthcareBtn setTitle:@"保健" forState:UIControlStateNormal];
        [m_isHealthcareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [m_isHealthcareBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:m_isHealthcareBtn];
        
        m_isDisinfectBtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 10, 60, 30)];
        m_isDisinfectBtn.layer.masksToBounds = YES;
        m_isDisinfectBtn.layer.cornerRadius = 5.f;
        [m_isDisinfectBtn setBackgroundImage:[UIImage imageWithColor:RGB(123,181,61) andSize:m_isVaccineBtn.size] forState:UIControlStateSelected];
        [m_isDisinfectBtn setBackgroundImage:[UIImage imageWithColor:RGB(240, 239, 245) andSize:m_isVaccineBtn.size] forState:UIControlStateNormal];
        [m_isDisinfectBtn setTitle:@"消毒" forState:UIControlStateNormal];
        [m_isDisinfectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [m_isDisinfectBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:m_isDisinfectBtn];
        
        m_isOutinsectBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 10, 60, 30)];
        m_isOutinsectBtn.layer.masksToBounds = YES;
        m_isOutinsectBtn.layer.cornerRadius = 5.f;
        [m_isOutinsectBtn setBackgroundImage:[UIImage imageWithColor:RGB(123,181,61) andSize:m_isVaccineBtn.size] forState:UIControlStateSelected];
        [m_isOutinsectBtn setBackgroundImage:[UIImage imageWithColor:RGB(240, 239, 245) andSize:m_isVaccineBtn.size] forState:UIControlStateNormal];
        [m_isOutinsectBtn setTitle:@"驱虫" forState:UIControlStateNormal];
        [m_isOutinsectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [m_isOutinsectBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:m_isOutinsectBtn];
    }
    return self;
}

- (void)setCellData:(PKRecordModel *)cellData
{
    _cellData = cellData;
    m_isVaccineBtn.selected = cellData.isVaccine;
    m_isHealthcareBtn.selected = cellData.isHealthcare;
    m_isOutinsectBtn.selected = cellData.isOutinsect;
    m_isDisinfectBtn.selected = cellData.isDisinfect;
}

- (void)btnAction:(UIButton*)sender
{
    sender.selected = !sender.selected;
    NSString* title = sender.titleLabel.text;
    if ([title isEqualToString:@"免疫"])
    {
        _cellData.isVaccine = sender.selected;
    }
    else if ([title isEqualToString:@"保健"])
    {
        _cellData.isHealthcare = sender.selected;
    }
    else if ([title isEqualToString:@"消毒"])
    {
        _cellData.isDisinfect = sender.selected;
    }
    else if ([title isEqualToString:@"驱虫"])
    {
        _cellData.isOutinsect = sender.selected;
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
