//
//  PKFarmRecordBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/14.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKFarmRecordBoard.h"
#import "PKRecordModel.h"
#import "PKRecordCell.h"
#import "SinglePickerSheet.h"
#import "PKAddRecordBoard.h"


@interface PKFarmRecordBoard ()<UIPickerSheetDelegate>
{
    UIButton* m_currentStageBtn;
    NSString* m_batchInfo;
    NSInteger m_currentStage;
    NSInteger page;
    
    NSMutableArray* m_itemArray;
}
@end

@implementation PKFarmRecordBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"养殖记录";
    // Do any additional setup after loading the view.
    UIView* headerView = [self createHeaderView];
    [self.container addSubview:headerView];
    self.egoTableView.y = headerView.height;
    self.egoTableView.height = self.container.height - headerView.height;
    self.enableRefreshHeader = YES;
    self.container.backgroundColor = [UIColor whiteColor];
    m_itemArray = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getCurrentBatchInfo];
}

- (void)refreshTableViewDataSource
{
    page = 1;
    [self getRecordList];
}

- (void)getCurrentBatchInfo
{
    m_batchInfo = [[NSUserDefaults standardUserDefaults] valueForKey:BATCHID];
    if (m_batchInfo)
    {
        [self getCurrentStage];
    }
    else
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID};
        ASIHTTPRequest* request = [JSHttpHelper get:CREATE_ONE_BATCH withValue:param withDelegate:self withUserInfo:@"CreateBatch"];
        [self addRequest:request];
    }
}

- (void)getCurrentStage
{
    NSDictionary* param = @{@"batchnum":m_batchInfo};
    ASIHTTPRequest* request = [JSHttpHelper get:GET_CURRENT_STAGE withValue:param withDelegate:self withUserInfo:@"GetCurrentStage"];
    [self addRequest:request];
}

- (void)getRecordList
{
    //第一阶段
    if(m_currentStage == 1)
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"batchnum":m_batchInfo,
                                @"page":[NSNumber numberWithInteger:page],
                                @"pagenum":[NSNumber numberWithInt:15]};
        ASIHTTPRequest* request = [JSHttpHelper get:GET_FIRSTSTAGERECORD_LIST withValue:param withDelegate:self withUserInfo:@"GetFirstStageRecord"];
        [self addRequest:request];
    }
    else if (m_currentStage == 2) //第二阶段
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"batchnum":m_batchInfo,
                                @"page":[NSNumber numberWithInteger:page],
                                @"pagenum":[NSNumber numberWithInt:48]};
        ASIHTTPRequest* request = [JSHttpHelper get:GET_SECONDSTAGERECORD_LIST withValue:param withDelegate:self withUserInfo:@"GetSecondStageRecord"];
        [self addRequest:request];
    }
    else if (m_currentStage == 3) //第三阶段
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"batchnum":m_batchInfo,
                                @"page":[NSNumber numberWithInteger:page],
                                @"pagenum":[NSNumber numberWithInt:20]};
        ASIHTTPRequest* request =[JSHttpHelper get:GET_THIRDSTAGERECORD_LIST withValue:param withDelegate:self withUserInfo:@"GetThirdStageRecord"];
        [self addRequest:request];
    }
    else
    {
        
    }
}

- (UIView*)createHeaderView
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    UILabel* currentStageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 110, 30)];
    [currentStageLabel setBackgroundColor:[UIColor clearColor]];
    currentStageLabel.text = @"当前阶段";
    currentStageLabel.textAlignment = NSTextAlignmentCenter;
    currentStageLabel.font = FONT(18);
    currentStageLabel.textColor = [UIColor whiteColor];
    currentStageLabel.backgroundImage = [UIImage imageNamed:@"farmrecord_stage"];
    [headerView addSubview:currentStageLabel];
    
    m_currentStageBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, 10, 170, 45)];
    [m_currentStageBtn setBackgroundImage:[UIImage imageNamed:@"farmrecord_stageBtn"]];
    [m_currentStageBtn setTitle:@"进鸡前准备" forState:UIControlStateNormal];
    [m_currentStageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_currentStageBtn addTarget:self action:@selector(stageChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    m_currentStageBtn.titleLabel.font = FONT(18);
    [headerView addSubview:m_currentStageBtn];
    return headerView;
}

#pragma mark action
- (void)stageChangeAction:(UIButton*)sender
{
    SinglePickerSheet* picksheet = [[SinglePickerSheet alloc] initWithTitle:@"选择阶段" delegate:self];
    picksheet.itemArray = @[@"进鸡前准备",@"前期养殖",@"中后期养殖"];
    [picksheet showInView:self.view];
}

#pragma picksheet delegate
- (void)pickerSheet:(UIView *)sheet selectWithButtonIndex:(NSInteger)buttonIndex
{
    SinglePickerSheet* picksheet = (SinglePickerSheet*)sheet;
    m_currentStageBtn.titleLabel.text = picksheet.pickerString;
    m_currentStage = picksheet.pickerIndex+1;
    [self getRecordList];
}

#pragma mark action
- (void)addThirdAction:(UIButton*)sender
{
    PKAddRecordBoard* board = [[PKAddRecordBoard alloc] init];
    board.record = [[PKRecordModel alloc] init];
    board.record.recordDayStr = [NSDate stringFromDate:[NSDate date] withFormat:@"MM-dd"];
    board.record.recordDay = m_itemArray.count+1;
    board.record.stage = STAGETYPE_THREE;
    board.record.batchNum = m_batchInfo;

    [self.navigationController pushViewController:board animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (m_currentStage == 3)
    {
        return 40.f;
    }
    return 0.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (m_currentStage == 3)
    {
        UIView* footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        footView.backgroundColor = [UIColor whiteColor];
        UIButton* addRecordBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
        addRecordBtn.backgroundColor = RGB(241, 243, 248);
        addRecordBtn.layer.cornerRadius = 5.f;
        [addRecordBtn setTitle:@"添加记录" forState:UIControlStateNormal];
        [addRecordBtn setTitleColor:RGB(124, 124, 124) forState:UIControlStateNormal];
        [addRecordBtn addTarget:self action:@selector(addThirdAction:) forControlEvents:UIControlEventTouchUpInside];
        [addRecordBtn setImage:[UIImage imageNamed:@"addrecord_image"] forState:UIControlStateNormal];
        [footView addSubview:addRecordBtn];
        return footView;
    }
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CellIdentifier";
    PKRecordCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[PKRecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    PKRecordModel* model = m_itemArray[indexPath.row];
    [cell setCellTitle:model.recordDayStr isRecord:model.isRecord];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PKAddRecordBoard* board = [[PKAddRecordBoard alloc] init];
    board.record = m_itemArray[indexPath.row];
    [self.navigationController pushViewController:board animated:YES];
}

#pragma mark overload

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
        if ([userInfo isEqualToString:@"CreateBatch"])
        {
            NSDictionary* data = [response objectForKey:@"chickenbatchnuminfo"];
            NSString* batchNum = [[data valueForKey:@"batchnum"] asNSString];
            [[NSUserDefaults standardUserDefaults] setValue:batchNum forKey:BATCHID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            m_batchInfo = batchNum;
            [self getCurrentStage];
        }
        else if ([userInfo isEqualToString:@"GetCurrentStage"])
        {
            m_currentStage = [[response valueForKey:@"stage"] integerValue];
            [self getRecordList];
        }
        else if ([userInfo isEqualToString:@"GetFirstStageRecord"])
        {
            [m_itemArray removeAllObjects];
            NSArray* datas = [[response objectForKey:@"datas"] asNSArray];
            for (int i = 0; i < 15; i++)
            {
                PKRecordModel* model = [[PKRecordModel alloc] init];
                model.recordDayStr = [NSString stringWithFormat:@"第%d天",15-i];
                model.recordDay = i+1;
                model.stage = STAGETYPE_ONE;
                model.batchNum = m_batchInfo;
                [m_itemArray addObject:model];
            }
            for (NSDictionary* dict in datas)
            {
                PKRecordModel* model = [[PKRecordModel alloc] initWithDict:dict];
                if (model.recordDay)
                {
                    model.recordDayStr = [NSString stringWithFormat:@"第%d天",(int)(16 - model.recordDay)];
                    model.batchNum = m_batchInfo;
                    model.isRecord = YES;
                    [m_itemArray replaceObjectAtIndex:model.recordDay-1 withObject:model];
                }
            }
            [self reloadDataSucceed:YES];
        }
        else if ([userInfo isEqualToString:@"GetSecondStageRecord"])
        {
            [m_itemArray removeAllObjects];
            NSArray* datas = [[response objectForKey:@"datas"] asNSArray];
            for (int i = 0;i < datas.count ; i++)
            {
                PKRecordModel* model = [[PKRecordModel alloc] initWithDict:datas[i]];
                model.recordDayStr = [NSString stringWithFormat:@"第%d天",i+1];
                model.recordDay = i+1;
                model.stage = STAGETYPE_TWO;
                model.isRecord = YES;
                model.batchNum = m_batchInfo;
                [m_itemArray addObject:model];
            }
            for (int i = datas.count; i < 48; i++)
            {
                PKRecordModel* model = [[PKRecordModel alloc] init];
                model.recordDayStr = [NSString stringWithFormat:@"第%d天",i+1];
                model.recordDay = i+1;
                model.stage = STAGETYPE_TWO;
                model.batchNum = m_batchInfo;
                [m_itemArray addObject:model];
            }
            [self reloadDataSucceed:YES];
        }
        else if([userInfo isEqualToString:@"GetThirdStageRecord"])
        {
            [m_itemArray removeAllObjects];
            NSArray* datas = [[response objectForKey:@"datas"] asNSArray];
            for (int i = 0; i < datas.count; i++)
            {
                PKRecordModel* model = [[PKRecordModel alloc] initWithDict:datas[i]];
                model.stage = STAGETYPE_THREE;
                model.batchNum = m_batchInfo;
                model.isRecord = YES;
                [m_itemArray addObject:model];
            }
            [self reloadDataSucceed:YES];
        }
    }

}

- (void)didReceiveMemoryWarning
{
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
