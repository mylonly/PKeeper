//
//  PKUserCenterBoard.m
//  PKeeper
//
//  Created by 田祥根 on 15/4/20.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKUserCenterBoard.h"
#import "LCSegmentedControl.h"

@interface PKUserCenterBoard ()

@end

@implementation PKUserCenterBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initNavBar
{
    [super initNavBar];
    LCSegmentedControl* segment = [[LCSegmentedControl alloc] initWithFrame:CGRectMake(100, 5+Y_OFFSET, 120, 30) items:@[@"个人信息",@"鸡场信息"]];
    [self.nav addSubview:segment];
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
