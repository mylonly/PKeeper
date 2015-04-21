//
//  PKSickReportList.m
//  PKeeper
//
//  Created by mylonly on 15/3/22.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKSickReportList.h"
#import "PKSickListCell.h"
#import "PKSickReportModel.h"
#import "PKAddNewSickReportBoard.h"
#import "PKSickReportDetailBoard.h"

@interface PKSickReportList ()
{
    NSMutableArray* m_itemArray;
    NSInteger page;
}
@end

@implementation PKSickReportList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"疾病报告";
    m_itemArray = [[NSMutableArray alloc] init];
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
    [self getData];
}

- (void)loadTableViewDataSource
{
    page++;
}

- (void)getData
{
    NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                            @"page":[NSNumber numberWithInteger:page],
                            @"pagenum":[NSNumber numberWithInteger:20]};
    ASIHTTPRequest* request = [JSHttpHelper get:GET_SICKREPORT_LIST withValue:param withDelegate:self withUserInfo:@"GetSickReportList"];
    [self addRequest:request];
}

- (void)initNavBar
{
    [super initNavBar];
    UIButton* addButton = [[UIButton alloc] initWithFrame:CGRectMake(260, Y_OFFSET, 60, 44)];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    //[addButton setImage:[UIImage imageNamed:@"addPic"] forState:UIControlStateNormal];
    addButton.titleLabel.font = FONT(40);
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nav addSubview:addButton];
}

#pragma mark action
- (void)addAction:(UIButton*)sender
{
    PKAddNewSickReportBoard* addNew = [[PKAddNewSickReportBoard alloc] init];
    [self.navigationController pushViewController:addNew animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* sickCellIdentifier = @"CellIdentifier";
    PKSickListCell* cell = [tableView dequeueReusableCellWithIdentifier:sickCellIdentifier];
    if (!cell)
    {
        cell = [[PKSickListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sickCellIdentifier];
    }
    cell.cellData = m_itemArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PKSickReportModel* model = m_itemArray[indexPath.row];
    PKSickReportDetailBoard* board = [[PKSickReportDetailBoard alloc] init];
    board.model = model;
    [self setAlreadyRead:model.reportID];
    [self.navigationController pushViewController:board animated:YES];
}

- (void)setAlreadyRead:(NSString*)reportID
{
    NSDictionary* param = @{@"illreportid":reportID};
    ASIHTTPRequest* request = [JSHttpHelper get:SETREPORTREAD withValue:param withDelegate:self withUserInfo:@"ReportRead"];
    [self addRequest:request];
}

- (void)requestDidFailed:(ASIHTTPRequest *)theRequest
{
    [super requestDidFinished:theRequest];
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
        if ([userInfo isEqualToString:@"GetSickReportList"])
        {
            NSArray* datas = [[response objectForKey:@"datas"] asNSArray];
            if (!page) {
                [m_itemArray removeAllObjects];
            }
            for (NSDictionary* dict in datas)
            {
                PKSickReportModel* model = [[PKSickReportModel alloc] initWithDict:dict];
                [m_itemArray addObject:model];
            }
            [self reloadDataSucceed:YES];
        }
        else if([userInfo isEqualToString:@"ReportRead"])
        {
            NSLog(@"ReportRead:%@",message);
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
