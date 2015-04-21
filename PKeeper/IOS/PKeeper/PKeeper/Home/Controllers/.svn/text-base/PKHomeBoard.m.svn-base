//
//  PHHomeBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/8.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKHomeBoard.h"
#import "PKNewsHomeBoard.h"
#import "PKFarmRecordBoard.h"
#import "PKUserInfoBoard.h"
#import "PKChickenInfoBoard.h"
#import "PKBatchList.h"
#import "PKSickReportList.h"
#import "PKLoginBoard.h"
#import "PKUserCenterBoard.h"

@interface PKHomeBoard ()<UIAlertViewDelegate>
{
    UILabel* m_farmRecordTips;
    UILabel* m_sickReportTips;
    UILabel* m_userInfoTips;
    UILabel* m_chickenInfoTips;
    UILabel* m_newsTips;
}
@end

@implementation PKHomeBoard

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"养禽管家";
    [self hideBack];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([PKUserModel shareInstance].userID)
    {
        [self checkStatus];
    }
}

#pragma mark overload
- (void)initContainer
{
    [super initContainer];
    
    //养殖记录
    UIView* farmRecordView = [[UIView alloc] initWithFrame:CGRectMake(20, 160, SCREENWIDTH-40, 100)];
    farmRecordView.backgroundColor = RGB(251, 189, 60);
    [self.container addSubview:farmRecordView];
    UIImageView* farmIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 33, 92, 67)];
    farmIcon.image = [UIImage imageNamed:@"home_farmrecord"];
    [farmRecordView addSubview:farmIcon];
    UILabel* farmTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 170, 30)];
    farmTitle.text = @"养殖记录";
    farmTitle.textAlignment = NSTextAlignmentCenter;
    farmTitle.font = [UIFont boldSystemFontOfSize:20];
    farmTitle.textColor = [UIColor whiteColor];
    [farmRecordView addSubview:farmTitle];
    m_farmRecordTips = [[UILabel alloc] initWithFrame:CGRectMake(80, 60, 170, 20)];
    m_farmRecordTips.text = @"(今天的养殖记录还未提交)";
    m_farmRecordTips.textColor = [UIColor whiteColor];
    m_farmRecordTips.textAlignment = NSTextAlignmentCenter;
    m_farmRecordTips.font = FONT(14);
    [farmRecordView addSubview:m_farmRecordTips];
    
    UIControl* farmRecordBtn = [[UIControl alloc] initWithFrame:farmRecordView.frame];
    [farmRecordBtn addTarget:self action:@selector(farmRecordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:farmRecordBtn];
    
    
    //疾病报告
//    UIView* sickReportView = [[UIView alloc] initWithFrame:CGRectMake(20, farmRecordView.y+farmRecordView.height+10, farmRecordView.width/2-5, 200)];
     UIView* sickReportView = [[UIView alloc] initWithFrame:CGRectMake(20, 270, SCREENWIDTH-40, 100)];
    sickReportView.backgroundColor = RGB(248, 141, 50);
    [self.container addSubview:sickReportView];
//    UIImageView* sickIcon = [[UIImageView alloc] initWithFrame:CGRectMake(sickReportView.width-80, 40, 73, 105)];
    UIImageView* sickIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 33, 92, 67)];

    sickIcon.image = [UIImage imageNamed:@"home_sickreport"];
    [sickReportView addSubview:sickIcon];
//    UILabel* sickTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, sickReportView.width, 30)];
    UILabel* sickTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 170, 30)];
    sickTitle.text = @"疾病报告";
    sickTitle.textAlignment = NSTextAlignmentCenter;
    sickTitle.font = [UIFont boldSystemFontOfSize:20];
    sickTitle.textColor = [UIColor whiteColor];
    [sickReportView addSubview:sickTitle];
//    m_sickReportTips = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, sickReportView.width, 20)];
    m_sickReportTips = [[UILabel alloc] initWithFrame:CGRectMake(80, 60, 170, 20)];
    m_sickReportTips.text = @"(收到新的疾病反馈)";
    m_sickReportTips.textColor = [UIColor whiteColor];
    m_sickReportTips.textAlignment = NSTextAlignmentCenter;
    m_sickReportTips.font = FONT(14);
    [sickReportView addSubview:m_sickReportTips];
    UIControl* sickReportBtn = [[UIControl alloc] initWithFrame:sickReportView.frame];
    [sickReportBtn addTarget:self action:@selector(sickReportAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:sickReportBtn];

    
//    //个人信息
//    UIView* userInfoView = [[UIView alloc] initWithFrame:CGRectMake(sickReportBtn.x+sickReportBtn.width+10, sickReportBtn.y, sickReportBtn.width, sickReportBtn.height/2-5)];
//    userInfoView.backgroundColor = RGB(80, 161, 252);
//    [self.container addSubview:userInfoView];
//    UIImageView* userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 90, 68)];
//    userIcon.image = [UIImage imageNamed:@"home_userinfo"];
//    [userInfoView addSubview:userIcon];
//    UILabel* userTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 120, 30)];
//    userTitle.text = @"个人信息";
//    userTitle.textAlignment = NSTextAlignmentCenter;
//    userTitle.font = [UIFont boldSystemFontOfSize:20];
//    userTitle.textColor = [UIColor whiteColor];
//    [userInfoView addSubview:userTitle];
//    m_userInfoTips = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, userInfoView.width, 20)];
//    m_userInfoTips.text = @"(个人信息还未完善)";
//    m_userInfoTips.textColor = [UIColor whiteColor];
//    m_userInfoTips.textAlignment = NSTextAlignmentCenter;
//    m_userInfoTips.font = FONT(14);
//    [userInfoView addSubview:m_userInfoTips];
//    UIControl* userInfoBtn = [[UIControl alloc] initWithFrame:userInfoView.frame];
//    [userInfoBtn addTarget:self action:@selector(userInfoAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.container addSubview:userInfoBtn];

//    //鸡场信息
//    UIView* chickenHouseInfoView = [[UIView alloc] initWithFrame:CGRectMake(userInfoBtn.x, userInfoBtn.y+userInfoBtn.height+10, userInfoBtn.width, userInfoBtn.height)];
//    chickenHouseInfoView.backgroundColor = RGB(235, 188, 44);
//    [self.container addSubview:chickenHouseInfoView];
//    UIImageView* chickenIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 90, 68)];
//    chickenIcon.image = [UIImage imageNamed:@"home_chickenInfo"];
//    [chickenHouseInfoView addSubview:chickenIcon];
//    UILabel* chickenTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 120, 30)];
//    chickenTitle.text = @"鸡场信息";
//    chickenTitle.textAlignment = NSTextAlignmentCenter;
//    chickenTitle.font = [UIFont boldSystemFontOfSize:20];
//    chickenTitle.textColor = [UIColor whiteColor];
//    [chickenHouseInfoView addSubview:chickenTitle];
//    m_chickenInfoTips = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, userInfoBtn.width, 20)];
//    m_chickenInfoTips.text = @"(鸡场信息还未完善)";
//    m_chickenInfoTips.textColor = [UIColor whiteColor];
//    m_chickenInfoTips.textAlignment = NSTextAlignmentCenter;
//    m_chickenInfoTips.font = FONT(14);
//    [chickenHouseInfoView addSubview:m_chickenInfoTips];
//    UIControl* chickenHouseInfoBtn = [[UIControl alloc] initWithFrame:chickenHouseInfoView.frame];
//    [chickenHouseInfoBtn addTarget:self action:@selector(chickenHouseAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.container addSubview:chickenHouseInfoBtn];

    
    //最新行业知识
//    UIView* newsView = [[UIView alloc] initWithFrame:CGRectMake(sickReportBtn.x, sickReportBtn.y+sickReportBtn.height+10, farmRecordBtn.width, 100)];
    UIView* newsView = [[UIView alloc] initWithFrame:CGRectMake(sickReportBtn.x, 380, farmRecordBtn.width, 100)];
    newsView.backgroundColor = RGB(105, 180, 36);
    [self.container addSubview:newsView];
    UIImageView* newsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 33, 92, 67)];
    newsIcon.image = [UIImage imageNamed:@"home_newsinfo"];
    [newsView addSubview:newsIcon];
    UILabel* newsTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 170, 30)];
    newsTitle.text = @"最新行业知识";
    newsTitle.textAlignment = NSTextAlignmentCenter;
    newsTitle.font = [UIFont boldSystemFontOfSize:20];
    newsTitle.textColor = [UIColor whiteColor];
    [newsView addSubview:newsTitle];
    m_newsTips = [[UILabel alloc] initWithFrame:CGRectMake(80, 60, 170, 20)];
    m_newsTips.text = @"(有新的内容更新)";
    m_newsTips.textColor = [UIColor whiteColor];
    m_newsTips.textAlignment = NSTextAlignmentCenter;
    m_newsTips.font = FONT(14);
    //[newsView addSubview:m_newsTips];

    UIControl* newsBtn = [[UIControl alloc] initWithFrame:newsView.frame];
    [newsBtn addTarget:self action:@selector(newsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:newsBtn];

    
    self.container.contentSize = CGSizeMake(self.container.width, newsBtn.y+newsBtn.height+30);
}

- (void)initNavBar
{
    [super initNavBar];
    
    UIButton* userCenter = [[UIButton alloc] initWithFrame:CGRectMake(260, Y_OFFSET, 60, 44)];
    [userCenter setImage:[UIImage imageNamed:@"usercenter.png"] forState:UIControlStateNormal];
    [userCenter addTarget:self action:@selector(userCenterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.nav addSubview:userCenter];
//    UIButton* logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, Y_OFFSET, 60, 44)];
//    [logoutBtn setImage:[UIImage imageNamed:@"logout_up"] forState:UIControlStateNormal];
//    [logoutBtn setImage:[UIImage imageNamed:@"logout_down"] forState:UIControlStateHighlighted];
//    [logoutBtn addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.nav addSubview:logoutBtn];
}

#pragma mark local action

- (void)userCenterAction:(UIButton*)button
{
    if (![self checkUserLogin]) {
        return;
    }
    PKUserCenterBoard* userCenter = [[PKUserCenterBoard alloc] init];
    [self.navigationController pushViewController:userCenter animated:YES];
}


- (void)farmRecordAction:(UIButton*)sender
{
    if (![self checkUserLogin])
    {
        return;
    }
    if([[PKChickenHouseModel shareInstance].houseID notEmpty])
    {
        PKFarmRecordBoard* board = [[PKFarmRecordBoard alloc] init];
        [self.navigationController pushViewController:board animated:YES];
    }
    else
    {
        [[FKHUDHelper shareInstance] presentMessageTips:@"请先完善鸡场信息"];
    }
}

- (void)logoutAction:(UIButton*)sender
{
    UIAlertView* alertView =[[UIAlertView alloc] initWithTitle:@"退出登录" message:@"确定退出当前账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (BOOL)checkUserLogin
{
    if (![PKUserModel shareInstance].userID)
    {
        PKLoginBoard* login  = [[PKLoginBoard alloc] init];
        [self presentViewController:login animated:YES completion:^{
            
        }];
        return NO;
    }
    return YES;
}


- (void)checkStatus
{
    NSString* m_batchInfo = [[NSUserDefaults standardUserDefaults] valueForKey:BATCHID];
    if (m_batchInfo)
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"batchnum":m_batchInfo};
        ASIHTTPRequest* request = [JSHttpHelper get:CHECKFARMRECORD withValue:param withDelegate:self withUserInfo:@"CheckFarmRecord"];
        [self addRequest:request];
    }
    
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID};
        ASIHTTPRequest* request = [JSHttpHelper get:GETNUMOFREPORTBYREPLY withValue:param withDelegate:self withUserInfo:@"GetNumOfReport"];
        [self addRequest:request];
    }
    
    m_userInfoTips.hidden = [[PKUserModel shareInstance] checkCompleted];
    m_chickenInfoTips.hidden = [[PKChickenHouseModel shareInstance] checkCompleted];
}

- (void)sickReportAction:(UIButton*)sender
{
    if (![self checkUserLogin])
    {
        return;
    }
    PKSickReportList* board = [[PKSickReportList alloc] init];
    [self.navigationController pushViewController:board animated:YES];
}

- (void)userInfoAction:(UIButton*)sender
{
    if (![self checkUserLogin])
    {
        return;
    }
    PKUserInfoBoard* board = [[PKUserInfoBoard alloc] init];
    [self.navigationController pushViewController:board animated:YES];
}

- (void)chickenHouseAction:(UIButton*)sender
{
    if (![self checkUserLogin])
    {
        return;
    }
    PKChickenInfoBoard* board = [[PKChickenInfoBoard alloc] init];
    [self.navigationController pushViewController:board animated:YES];
}

- (void)newsAction:(UIButton*)sender
{
    PKNewsHomeBoard* news= [[PKNewsHomeBoard alloc] init];
    [self.navigationController pushViewController:news animated:YES];
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
        if ([userInfo isEqualToString:@"CheckFarmRecord"])
        {
            BOOL isSubmit = [[response objectForKey:@"isSubmit"] boolValue];
            m_farmRecordTips.hidden = isSubmit;
        }
        else if ([userInfo isEqualToString:@"GetNumOfReport"])
        {
            NSInteger num = [[response objectForKey:@"total"] integerValue];
            m_sickReportTips.hidden = !num;
        }
    }
}


#pragma mark alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
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
