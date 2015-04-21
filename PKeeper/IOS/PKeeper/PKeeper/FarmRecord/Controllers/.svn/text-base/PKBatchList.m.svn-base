//
//  PKBatchList.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/20.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKBatchList.h"

@interface PKBatchList ()
{
    NSInteger page;
}
@end

@implementation PKBatchList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所有批次";
    // Do any additional setup after loading the view.
    self.enableRefreshHeader = YES;
    self.enableLoadMoreFooter = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self egoAllRequest];
}

- (void)refreshTableViewDataSource
{
    page = 0;
    NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                            @"page":[NSNumber numberWithInteger:page],
                            @"pagenum":[NSNumber numberWithInteger:20]};
    
    ASIHTTPRequest* request = [JSHttpHelper get:GET_BATCHLIST withValue:param withDelegate:self withUserInfo:@"GetBatchList"];
    [self addRequest:request];
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
        if ([userInfo isEqualToString:@"GetBatchList"])
        {
            
        }
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
