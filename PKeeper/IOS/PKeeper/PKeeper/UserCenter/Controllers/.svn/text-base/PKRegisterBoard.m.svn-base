//
//  PKRegisterBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/5.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKRegisterBoard.h"

@interface PKRegisterBoard ()
{
    UITextField* m_username;
    UITextField* m_password;
    UITextField* m_confirmPassword;
}
@end

@implementation PKRegisterBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel* appName = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, 40)];
    appName.text = @"养禽管家";
    appName.textAlignment = NSTextAlignmentCenter;
    appName.textColor = BASEBOARD_NAVCOLOR;
    appName.font = FONT(44);
    [self.container addSubview:appName];
    
    UILabel* loginTips = [[UILabel alloc] initWithFrame:CGRectMake(0, appName.y+appName.height+10, SCREENWIDTH, 40)];
    loginTips.textAlignment = NSTextAlignmentCenter;
    loginTips.text = @"用户注册";
    loginTips.textColor = BASEBOARD_NAVCOLOR;
    loginTips.font = FONT(14);
    [self.container addSubview:loginTips];
    
    m_username = [[UITextField alloc] initWithFrame:CGRectMake(60, loginTips.y+loginTips.height+20, 200, 40)];
    m_username.borderStyle = UITextBorderStyleRoundedRect;
    m_username.placeholder = @"用户名";
    m_username.clearsOnBeginEditing = YES;
    [self.container addSubview:m_username];
    
    m_password = [[UITextField alloc] initWithFrame:CGRectMake(60, m_username.y+m_username.height+10, 200, 40)];
    m_password.borderStyle = UITextBorderStyleRoundedRect;
    m_password.secureTextEntry = YES;
    m_confirmPassword.clearsOnBeginEditing = YES;
    m_password.placeholder = @"密码";
    [self.container addSubview:m_password];
    
    m_confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(60, m_password.y+m_password.height+10, 200, 40)];
    m_confirmPassword.borderStyle = UITextBorderStyleRoundedRect;
    m_confirmPassword.secureTextEntry = YES;
    m_confirmPassword.clearsOnBeginEditing = YES;
    m_confirmPassword.placeholder = @"确认密码";
    [self.container addSubview:m_confirmPassword];
    
    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, m_confirmPassword.y+m_confirmPassword.height+10, 90, 30)];
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.layer.cornerRadius = 5.f;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:cancelBtn];
    
    UIButton* registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(cancelBtn.x+cancelBtn.width+20, cancelBtn.y, 90, 30)];
    registerBtn.backgroundColor = BASEBOARD_NAVCOLOR;
    registerBtn.layer.cornerRadius = 5.f;
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:registerBtn];
}

#pragma mark overload
- (BOOL)navigationBarHidden
{
    return YES;
}

- (void)requestDidFailed:(ASIHTTPRequest *)theRequest
{
    [super requestDidFailed:theRequest];
}

- (void)requestDidFinished:(ASIHTTPRequest *)theRequest
{
    [super requestDidFinished:theRequest];
    NSString* userInfo =  [theRequest.userInfo objectForKey:@"userInfo"];
    NSDictionary* response = [[CJSONDeserializer deserializer]deserialize:theRequest.responseData error:nil];
    NSString* message = [[response objectForKey:@"info"] asNSString];
    BOOL success = [[response objectForKey:@"result"] boolValue];
    if (!success)
    {
        [[FKHUDHelper shareInstance] presentMessageTips:message];
        return;
    }
    else
    {
        if ([userInfo isEqualToString:@"register"])
        {
            [[FKHUDHelper shareInstance] presentMessageTips:@"注册成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark local action
- (void)cancelAction:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerAction:(UIButton*)sender
{
    if (![m_password.text isEqualToString:m_confirmPassword.text]) {
        [[FKHUDHelper shareInstance] presentMessageTips:@"密码不一致"];
        return;
    }
    NSDictionary* param = @{@"username":m_username.text,
                            @"password":m_password.text};
    ASIHTTPRequest* request = [JSHttpHelper post:REGISTER withValue:param withDelegate:self withUserInfo:@"register"];
    [self addRequest:request];
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
