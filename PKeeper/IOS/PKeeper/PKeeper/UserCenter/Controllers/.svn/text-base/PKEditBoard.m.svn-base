//
//  PKEditBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/15.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKEditBoard.h"

@interface PKEditBoard ()<UITextFieldDelegate>
{
    UITextField* m_textField;
    EDITTYPE m_type;
    NSString* m_editText;
}
@end

@implementation PKEditBoard

- (id)initWithType:(EDITTYPE)type withTitle:(NSString*)title
{
    self = [super init];
    if (self)
    {
        m_type = type;
        self.title = title;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    m_editText = m_textField.text;
}

- (void)initNavBar
{
    [super initNavBar];
    
    UIButton* doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, Y_OFFSET, 60, 44)];
    [doneBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = FONT(14);
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nav addSubview:doneBtn];
}

- (void)initContainer
{
    [super initContainer];
    switch (m_type)
    {
        case EDITTYPE_TEXT:
        {
            m_textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
            m_textField.borderStyle = UITextBorderStyleRoundedRect;
            m_textField.text = _modifyText;
            m_textField.delegate = self;
            [self.container addSubview:m_textField];
        }
            break;
        default:
            break;
    }
}

#pragma mark localAction
- (void)submitAction:(UIButton*)sender
{
    [m_textField resignFirstResponder];
    if ([self.title isEqualToString:@"手机号码"])
    {
        if (![_modifyText isTelephone]) {
            [[FKHUDHelper shareInstance] presentMessageTips:@"请输入正确的手机号码"];
            return;
        }
    }
    else if ([self.title isEqualToString:@"Email"])
    {
        if (![_modifyText isEmail]) {
            [[FKHUDHelper shareInstance] presentMessageTips:@"请输入正确的邮箱地址"];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([_delegate respondsToSelector:@selector(textChangedByItem:changedText:)])
    {
        [_delegate textChangedByItem:self.title changedText:m_textField.text];
    }
}

#pragma mark textField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _modifyText = textField.text;
    if([self.title isEqualToString:@"姓名"])
    {
        [PKUserModel shareInstance].realName = _modifyText;
    }
    else if ([self.title isEqualToString:@"手机号码"])
    {
        [PKUserModel shareInstance].mobile = _modifyText;
    }
    else if ([self.title isEqualToString:@"QQ"])
    {
        [PKUserModel shareInstance].qqNum = _modifyText;
    }
    else if ([self.title isEqualToString:@"Email"])
    {
        [PKUserModel shareInstance].email = _modifyText;
    }
    else if([self.title isEqualToString:@"详细地址"])
    {
        [PKUserModel shareInstance].address = _modifyText;
    }
    else if ([self.title isEqualToString:@"鸡场名称"])
    {
        [PKChickenHouseModel shareInstance].houseName = _modifyText;
    }
    else if ([self.title isEqualToString:@"鸡场地址"])
    {
        [PKChickenHouseModel shareInstance].houseAddress = _modifyText;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
