//
//  PKTodayTaskContentCell.m
//  PKeeper
//
//  Created by mylonly on 15/3/21.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKTodayTaskContentCell.h"

@interface PKTodayTaskContentCell()<UITextViewDelegate>
{
    UITextView *m_textView;
}
@end

@implementation PKTodayTaskContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        tips.text = @"今日工作内容";
        tips.textColor = RGB(249, 127, 36);
        [contanierView addSubview:tips];
        
        m_textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 25, 280, 150)];
        m_textView.delegate = self;
        [contanierView addSubview:m_textView];
    }
    return self;
}

- (void)setTaskContent:(NSString *)taskContent
{
    _taskContent = taskContent;
    m_textView.text = taskContent;
}

- (NSString*)getContent
{
    [m_textView resignFirstResponder];
    _taskContent = m_textView.text;
    return m_textView.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([_delegate respondsToSelector:@selector(taskContentEndEdit:)])
    {
        [_delegate taskContentEndEdit:textView.text];
    }
}




@end
