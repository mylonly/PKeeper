//
//  PKLoginBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/4.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKLoginBoard.h"
#import "PKRegisterBoard.h"
#import "PKHomeBoard.h"

@interface PKLoginBoard ()
{
    UITextField* m_username;
    UITextField* m_password;
}
@end

@implementation PKLoginBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton* closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 20, 60, 44)];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:closeBtn];
    
    UILabel* appName = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, 40)];
    appName.text = @"养禽管家";
    appName.textAlignment = NSTextAlignmentCenter;
    appName.textColor = BASEBOARD_NAVCOLOR;
    appName.font = FONT(44);
    [self.container addSubview:appName];
    
    UILabel* loginTips = [[UILabel alloc] initWithFrame:CGRectMake(0, appName.y+appName.height+10, SCREENWIDTH, 40)];
    loginTips.textAlignment = NSTextAlignmentCenter;
    loginTips.text = @"用户登录";
    loginTips.textColor = BASEBOARD_NAVCOLOR;
    loginTips.font = FONT(14);
    [self.container addSubview:loginTips];
    
    m_username = [[UITextField alloc] initWithFrame:CGRectMake(60, loginTips.y+loginTips.height+20, 200, 40)];
    m_username.borderStyle = UITextBorderStyleRoundedRect;
    m_username.placeholder = @"用户名";
    m_username.clearsOnBeginEditing = YES;
    [self.container addSubview:m_username];
    
    m_password = [[UITextField alloc] initWithFrame:CGRectMake(60, m_username.y+m_username.height+20, 200, 40)];
    m_password.borderStyle = UITextBorderStyleRoundedRect;
    m_password.placeholder = @"密码";
    m_password.secureTextEntry = YES;
    m_password.clearsOnBeginEditing = YES;
    [self.container addSubview:m_password];
    
    UIButton* loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, m_password.y+m_password.height+20, 90, 30)];
    loginBtn.backgroundColor = BASEBOARD_NAVCOLOR;
    loginBtn.layer.cornerRadius = 5.f;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:loginBtn];
    
    UIButton* registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(loginBtn.x+loginBtn.width+20, loginBtn.y, 90, 30)];
    registerBtn.backgroundColor = [UIColor grayColor];
    registerBtn.layer.cornerRadius = 5.f;
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:registerBtn];
    
    //取回沙盒的用户名密码
    NSString* username = [[NSUserDefaults standardUserDefaults] valueForKey:USERNAME];
    NSString* password = [[NSUserDefaults standardUserDefaults] valueForKey:PASSWORD];
    if (username&&password)
    {
        m_username.text = username;
        m_password.text = password;
    }
}

#pragma mark overload
- (BOOL)navigationBarHidden
{
    return YES;
}

- (void)close:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)requestDidFinished:(ASIHTTPRequest *)theRequest
{
    [[FKHUDHelper shareInstance] dismissTips];
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
        if ([userInfo isEqualToString:@"login"])
        {
            NSDictionary* data = [response objectForKey:@"userdata"];
            [[PKUserModel shareInstance] constructWithDict:data];
            //[[FKHUDHelper shareInstance] presentMessageTips:@"登陆成功"];
            [[PKChickenHouseModel shareInstance] getchickenInfo];
            [self performSelector:@selector(jumpHome) withObject:nil afterDelay:1.f];
            [[NSUserDefaults standardUserDefaults] setValue:m_username.text forKey:USERNAME];
            [[NSUserDefaults standardUserDefaults] setValue:m_password.text forKey:PASSWORD];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

- (void)requestDidFailed:(ASIHTTPRequest *)theRequest
{
    [super requestDidFailed:theRequest];
    [[FKHUDHelper shareInstance] dismissTips];
    [[FKHUDHelper shareInstance] presentMessageTips:@"网络出错"];
}

#pragma local action
- (void)loginAction:(UIButton*)sender
{
    NSDictionary* param = @{@"username":m_username.text,
                            @"password":m_password.text};
    ASIHTTPRequest* request = [JSHttpHelper get:LOGIN withValue:param withDelegate:self withUserInfo:@"login"];
    [self addRequest:request];
    [[FKHUDHelper shareInstance] presentLoadingTips:@"登陆中"];
}

- (void)registerAction:(UIButton*)sender
{
    PKRegisterBoard* registerBoard = [[PKRegisterBoard alloc] init];
    [self presentViewController:registerBoard animated:YES completion:^{
        
    }];
}

- (void)jumpHome
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
//    PKHomeBoard* board = [[PKHomeBoard alloc] init];
//    [self.navigationController pushViewController:board animated:YES];
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
