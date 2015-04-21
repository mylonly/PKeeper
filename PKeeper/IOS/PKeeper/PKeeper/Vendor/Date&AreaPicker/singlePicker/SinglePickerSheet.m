//
//  GenderPickerSheet.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/16.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "SinglePickerSheet.h"
#import "NSDate+Helper.h"

#define kContentViewTag 1990
#define kGenderPickerTag  1991
@interface SinglePickerSheet()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView* genderPicker;
}
@end

@implementation SinglePickerSheet

- (id)initWithTitle:(NSString *)title delegate:(id<UIPickerSheetDelegate>)delegate
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds])
    {
        _delegate = delegate;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4f];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 220.f, 320.f, 260.f)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.tag = kContentViewTag;
        
        
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 44.f)];
        titleImageView.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:titleImageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 11.f, 320.f, 21.f)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        titleLabel.textColor = [UIColor redColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        [contentView addSubview:titleLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.f, 47.f, 320, 0.5f)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [contentView addSubview:line];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(10.f, 8.f, 27.f, 27.f);
        [cancelButton setImage:[UIImage imageNamed:@"btn_back_normal@2x.png"] forState:UIControlStateNormal];
        [cancelButton setImage:[UIImage imageNamed:@"btn_back_normal@2x.png"] forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:cancelButton];
        
        UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseButton.frame = CGRectMake(268.f, 1.f, 42.f, 42.f);
        [chooseButton setImage:[UIImage imageNamed:@"btn_queren_normal@2x.png"] forState:UIControlStateNormal];
        [chooseButton setImage:[UIImage imageNamed:@"btn_queren_normal@2x.png"] forState:UIControlStateHighlighted];
        [chooseButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:chooseButton];
        
        genderPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.f, 44.f, 320.f, 216.f)];
        genderPicker.tag = kGenderPickerTag;
        genderPicker.dataSource = self;
        genderPicker.delegate = self;
        [contentView addSubview:genderPicker];
        
        [self addSubview:contentView];
    }
    return self;
}

- (void)setItemArray:(NSArray*)array
{
    _itemArray = array;
    _pickerString = [array firstObject];
    _pickerIndex = 0;
    [genderPicker reloadAllComponents];
}

- (void)showInView:(UIView *)view
{
    if ([_delegate respondsToSelector:@selector(pickerSheetWillPresent:)]) {
        [_delegate pickerSheetWillPresent:self];
    }
    
    [view addSubview:self];
    
    UIView *contentView = [self viewWithTag:kContentViewTag];
    contentView.frame = CGRectMake(0.f, self.frame.size.height, 320.f, 260.f);
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [contentView.layer addAnimation:animation forKey:@"DatePickerSheet"];
    
    contentView.frame = CGRectMake(0.f, self.frame.size.height-260.f, 320.f, 260.f);
}


- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if ([_delegate respondsToSelector:@selector(pickerSheetWillDismiss:)]) {
        [_delegate pickerSheetWillDismiss:self];
    }
    
    UIView *contentView = [self viewWithTag:kContentViewTag];
    
    if (animated) {
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [contentView setAlpha:0.f];
        [contentView.layer addAnimation:animation forKey:@"DatePickerSheet"];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    } else {
        [contentView setAlpha:0.f];
        [self removeFromSuperview];
    }
    
    if ([_delegate respondsToSelector:@selector(pickerSheet:selectWithButtonIndex:)]) {
        [_delegate pickerSheet:self selectWithButtonIndex:buttonIndex];
    }
}


#pragma mark Action
- (void)cancel:(id)sender {
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)choose:(id)sender {
    [self dismissWithClickedButtonIndex:1 animated:YES];
}


#pragma mark UIPickerView datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _itemArray.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _itemArray[row];
}
#pragma mark pickerView delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _pickerString = _itemArray[row];
    _pickerIndex = row;
}
@end
