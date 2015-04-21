//
//  PKNewsHomeBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/13.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKNewsHomeBoard.h"
#import "PKHeaderView.h"
#import "PKNewsModel.h"
#import "PKNewsCell.h"
#import "PKCourseCell.h"
#import "PKWebviewBoard.h"
#import "PKBookCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PKNewsHomeBoard ()<PKHeaderViewDelegate>
{
    NSMutableArray* m_itemArray;
    NSString* currentItem;
    NSInteger page;
}
@end

@implementation PKNewsHomeBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新行业知识";
    m_itemArray = [[NSMutableArray alloc] init];
    page = 0;
    currentItem = @"行情信息";
    // Do any additional setup after loading the view.
    
    PKHeaderView* headerView = [[PKHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    [headerView setItemArray:@[@"行情信息",@"技术指导",@"培训课程",@"参考资料"]];
    headerView.delegate = self;
    [self.container addSubview:headerView];
    
    self.egoTableView.y = 40;
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
    [self getData];
}

- (void)loadTableViewDataSource
{

}

- (void)getData
{
    NSInteger type;
    if ([currentItem isEqualToString:@"行情信息"])
    {
        type = 4;
    }
    else if ([currentItem isEqualToString:@"技术指导"])
    {
        type = 2;
    }
    else if ([currentItem isEqualToString:@"培训课程"])
    {
        type = 3;
    }
    else if ([currentItem isEqualToString:@"参考资料"])
    {
        type = 1;
    }
    NSDictionary* param = @{@"type":[NSNumber numberWithInteger:type],
                            @"page":[NSNumber numberWithInteger:page],
                            @"pagenum":[NSNumber numberWithInteger:20]};
    ASIHTTPRequest* request = [JSHttpHelper get:GET_NEWS_LIST withValue:param withDelegate:self withUserInfo:@"GetNewsList"];
    [self addRequest:request];
}

#pragma mark PKHeaderView delegate
- (void)headerView:(PKHeaderView *)headerView withItem:(NSString *)item
{
    currentItem = item;
    [self egoAllRequest];
}

#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([currentItem isEqualToString:@"行情信息"] || [currentItem isEqualToString:@"技术指导"])
    {
        static NSString* newsCellIdentifier = @"CellIdentifier";
        PKNewsCell* cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
        if (!cell) {
            cell = [[PKNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsCellIdentifier];
        }
        [cell setCellData:m_itemArray[indexPath.row]];
        return cell;
    }
    else if ([currentItem isEqualToString:@"培训课程"])
    {
        static NSString* courseCellIdentifier = @"CourseCellIdentifier";
        PKCourseCell* cell = [tableView dequeueReusableCellWithIdentifier:courseCellIdentifier];
        if (!cell)
        {
            cell = [[PKCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCellIdentifier];
        }
        [cell setCellData:m_itemArray[indexPath.row]];
        return cell;
    }
    else
    {
        static NSString* bookCellIdentifier = @"BookCellIdentifier";
        PKBookCell* cell = [tableView dequeueReusableCellWithIdentifier:bookCellIdentifier];
        if (!cell)
        {
            cell = [[PKBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bookCellIdentifier];
        }
        [cell setCellData:m_itemArray[indexPath.row]];
        return cell;
    }
}

#pragma mark tableVide delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([currentItem isEqualToString:@"培训课程"])
    {
        PKNewsModel* model = [m_itemArray objectAtIndex:indexPath.row];
        MPMoviePlayerViewController* player = [[MPMoviePlayerViewController alloc] initWithContentURL:model.newsVideoUrl];
        [self presentMoviePlayerViewControllerAnimated:player];
    }
    else if ([currentItem isEqualToString:@"行情信息"] || [currentItem isEqualToString:@"技术指导"] || [currentItem isEqualToString:@"参考资料"])
    {
        PKNewsModel* model = [m_itemArray objectAtIndex:indexPath.row];
        PKWebviewBoard* webView = [[PKWebviewBoard alloc] initWithTitle:model.newsTitle];
        webView.url = model.newsWebUrl;
        [self.navigationController pushViewController:webView animated:YES];
    }
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
        if ([userInfo isEqualToString:@"GetNewsList"])
        {
            if (!page)
            {
                [m_itemArray removeAllObjects];
            }
            NSArray* data = [[response objectForKey:@"datas"] asNSArray];
            for (NSDictionary* dict in data)
            {
                PKNewsModel* news = [[PKNewsModel alloc] initWithDict:dict];
                [m_itemArray addObject:news];
            }
        }
        [self reloadDataSucceed:YES];
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
