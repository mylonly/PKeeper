//
//  PKWebviewBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/14.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKWebviewBoard.h"

@interface PKWebviewBoard ()<UIWebViewDelegate>
{
    UIWebView* m_webView;
}
@end

@implementation PKWebviewBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_webView = [[UIWebView alloc] initWithFrame:self.container.bounds];
    m_webView.delegate = self;
    [self.container addSubview:m_webView];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [m_webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[FKHUDHelper shareInstance] presentLoadingTips:@"加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[FKHUDHelper shareInstance] dismissTips];
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
