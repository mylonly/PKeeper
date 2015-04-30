//
//  PKUserCenterBoard.m
//  PKeeper
//
//  Created by 田祥根 on 15/4/20.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKUserCenterBoard.h"
#import "LCSegmentedControl.h"
#import "PKUserInfoBoard.h"
#import "PKChickenInfoBoard.h"

@interface PKUserCenterBoard ()
{
    PKUserInfoBoard* m_userInfo;
    PKChickenInfoBoard* m_chickenInfo;
    UIView* m_contentView;
    UIButton* m_submitButton;
}
@end

@implementation PKUserCenterBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    m_contentView = [[UIView alloc] initWithFrame:self.view.bounds];
//    m_contentView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:m_contentView];
    
    m_userInfo = [[PKUserInfoBoard alloc] init];
    m_chickenInfo = [[PKChickenInfoBoard alloc] init];
    [self addChildViewController:m_userInfo];
    [self addChildViewController:m_chickenInfo];
    [m_userInfo.view setNeedsDisplay];
    [m_chickenInfo.view setNeedsDisplay];
    [self.view addSubview:m_userInfo.container];
}

- (void)viewWillAppear:(BOOL)animated
{
    [m_userInfo reloadData];
    [m_chickenInfo reloadData];
}


- (void)submitAction:(UIButton*)sender
{
    [m_userInfo submit];
    [m_chickenInfo submit];
}

- (void)onBackButtonClicked
{
    [super onBackButtonClicked];
}

- (void)initNavBar
{
    [super initNavBar];
    LCSegmentedControl* segment = [[LCSegmentedControl alloc] initWithFrame:CGRectMake(80, 5+Y_OFFSET, 160, 30) items:@[@{@"text":@"个人信息"},@{@"text":@"鸡场信息"}]];
    [segment segmentDidSelectBlock:^(NSUInteger segmentIndex) {
        [self loadViewWithIndex:segmentIndex];
    }];
    [self.nav addSubview:segment];
    
    m_submitButton = [[UIButton alloc] initWithFrame:CGRectMake(260, Y_OFFSET, 60, 44)];
    [m_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [m_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    m_submitButton.titleLabel.font = FONT(14);
    [m_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nav addSubview:m_submitButton];
}

- (void)loadViewWithIndex:(NSInteger)segmentIndex
{
    if (segmentIndex)
    {
        [m_userInfo.container removeFromSuperview];
        [self.view addSubview:m_chickenInfo.container];
    }
    else
    {
        [m_chickenInfo.container removeFromSuperview];
        [self.view addSubview:m_userInfo.container];
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
