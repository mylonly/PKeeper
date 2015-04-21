//
//  PKAddRecordBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/21.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKAddRecordBoard.h"

#import "PKTodayStandardFlowCell.h"

#import "PKTodayTaskContentCell.h"

#import "BBYAddImageGridCell.h"

#import "QBImagePickerController.h"
#import "PKUploadImage.h"
#import "PKTodayTaskCollectCell.h"
#import "PKEditBoard.h"
#import "PKRecordExtraCell.h"

@interface PKAddRecordBoard ()<UITableViewDataSource,UITableViewDelegate,BBYAddImageGridCellDelegate,QBImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PKTodayTaskContentCellDelegate,PKTodayTaskCollectCellDelegate,PKEditBoardDelegate>
{
    UITableView* m_tableView;
    NSMutableArray* m_imageDatas;
    UIButton* m_submitButton;
    NSString* m_standardFlow;
}
@end

@implementation PKAddRecordBoard

- (id)init
{
    self = [super init];
    if (self)
    {
        m_imageDatas = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加记录";
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)setRecord:(PKRecordModel *)record
{
    _record = record;
    [m_imageDatas addObjectsFromArray:record.picArray];
}

- (void)initNavBar
{
    [super initNavBar];
    m_submitButton = [[UIButton alloc] initWithFrame:CGRectMake(260, Y_OFFSET, 60, 44)];
    [m_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [m_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    m_submitButton.titleLabel.font = FONT(14);
    [m_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nav addSubview:m_submitButton];
}

- (void)submitAction:(UIButton*)sender
{
    [[FKHUDHelper shareInstance] presentLoadingTips:@"上传中..."];
    NSMutableArray* uploadImageDatas = [[NSMutableArray alloc] init];
    for (id data in m_imageDatas)
    {
        if ([data isKindOfClass:[NSData class]])
        {
            [uploadImageDatas addObject:data];
        }
    }
    if (uploadImageDatas.count)
    {
        __block int i = 0;
        NSMutableArray* uploadImages = [[NSMutableArray alloc] init];
        for (NSData* data in uploadImageDatas)
        {
            PKUploadImage* image = [[PKUploadImage alloc] init];
            image.imageData = data;
            [image uploadWithSuccessBlock:^(id result) {
                i ++;
                NSLog(@"image:%@ 上传成功",image.imageName);
                [uploadImages addObject:UPYUNIMAGEPATH(image.savekey)];
                if (i == uploadImageDatas.count)
                {
                    [self submitRecord:[uploadImages componentsJoinedByString:@","]];
                }
            } withProgressBlock:nil];
        }
    }
    else
    {
        [self submitRecord:nil];
    }
}

- (void)submitRecord:(NSString*)uploadPic
{
    if(_record.stage == STAGETYPE_ONE)
    {
        PKTodayTaskContentCell* cell =(PKTodayTaskContentCell*)[m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        _record.recordContent = [cell getContent];
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"cid":[PKChickenHouseModel shareInstance].houseID,
                                @"day":[NSNumber numberWithInteger:_record.recordDay],
                                @"batchnum":_record.batchNum,
                                @"daycontent":_record.recordContent,
                                @"pic":uploadPic?uploadPic:@""};
        ASIHTTPRequest* request = [JSHttpHelper get:SUBMIT_FIRSTSTAGERECOD withValue:param withDelegate:self withUserInfo:@"SubmitFirstRecord"];
        [self addRequest:request];
    }
    else if (_record.stage == STAGETYPE_TWO)
    {
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"cid":[PKChickenHouseModel shareInstance].houseID,
                                @"day":[NSNumber numberWithInteger:_record.recordDay],
                                @"batchnum":_record.batchNum,
                                @"vaccine":[NSNumber numberWithBool:_record.isVaccine],
                                @"healthcare":[NSNumber numberWithBool:_record.isHealthcare],
                                @"disinfect":[NSNumber numberWithBool:_record.isDisinfect],
                                @"outinsect":[NSNumber numberWithBool:_record.isOutinsect],
                                @"eatfood":[NSNumber numberWithFloat:_record.eatFood],
                                @"eachweight":[NSNumber numberWithFloat:_record.eachWeight],
                                @"deadcount":[NSNumber numberWithInteger:_record.deadCount],
                                @"weedout":[NSNumber numberWithInteger:_record.weedOut],
                                @"temperature":[NSNumber numberWithFloat:_record.temperature],
                                @"humidity":[NSNumber numberWithFloat:_record.humidity],
                                @"sunning":[NSNumber numberWithFloat:_record.sunning],
                                @"age":[NSNumber numberWithInteger:_record.recordDay],
                                @"vacname":_record.vaccineName?_record.vaccineName:@"",
                                @"vetdrug":_record.veterinaryDrugName?_record.veterinaryDrugName:@"",
                                @"disoutectdesc":_record.disinfectCase?_record.disinfectCase:@"",
                                @"eatwater":[NSNumber numberWithFloat:_record.drinkWater],
                                @"pic":uploadPic?uploadPic:@""};
        ASIHTTPRequest* request = [JSHttpHelper get:SUBMIT_SECONDSTAGERECOD withValue:param withDelegate:self withUserInfo:@"SubmitSecondRecord"];
        [self addRequest:request];
    }
    else
    {
        PKTodayTaskContentCell* cell =(PKTodayTaskContentCell*)[m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        _record.recordContent = [cell getContent];
        NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                                @"cid":[PKChickenHouseModel shareInstance].houseID,
                                @"batchnum":_record.batchNum,
                                @"vaccine":[NSNumber numberWithBool:_record.isVaccine],
                                @"healthcare":[NSNumber numberWithBool:_record.isHealthcare],
                                @"disinfect":[NSNumber numberWithBool:_record.isDisinfect],
                                @"outinsect":[NSNumber numberWithBool:_record.isOutinsect],
                                @"daycontent":_record.recordContent,
                                @"recordtime":[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"],
                                @"pic":uploadPic?uploadPic:@""};
        ASIHTTPRequest* request = [JSHttpHelper get:SUBMIT_THIRDSTAGERECOD withValue:param withDelegate:self withUserInfo:@"SubmitThirdRecord"];
        [self addRequest:request];
    }
}

- (void)taskContentEndEdit:(NSString *)content
{
    _record.recordContent = content;
}

- (void)initContainer
{
    [super initContainer];
    m_tableView = [[UITableView alloc] initWithFrame:self.container.bounds style:UITableViewStylePlain];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    [self.container addSubview:m_tableView];
    if(_record.stage != STAGETYPE_THREE)
    {
        [self getStandardFlow];
    }
}

#pragma mark Action
- (void)getStandardFlow
{
    NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                            @"stage":[NSNumber numberWithInt:_record.stage],
                            @"day":[NSNumber numberWithInteger:_record.recordDay]};
    ASIHTTPRequest* request = [JSHttpHelper get:GET_STANDARDFLOW withValue:param withDelegate:self withUserInfo:@"get_standardflow"];
    [self addRequest:request];
}

- (void) requestDidFinished:(ASIHTTPRequest *)theRequest
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
        if ([userInfo isEqualToString:@"get_standardflow"])
        {
            NSDictionary* data = [response objectForKey:@"data"];
            m_standardFlow = [data valueForKey:@"standarddesc"];
        }
        else if([userInfo isEqualToString:@"SubmitFirstRecord"])
        {
            [[FKHUDHelper shareInstance] dismissTips];
            NSLog(@"%@",message);
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if ([userInfo isEqualToString:@"SubmitSecondRecord"])
        {
            [[FKHUDHelper shareInstance] dismissTips];
            NSLog(@"%@",message);
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if ([userInfo isEqualToString:@"SubmitThirdRecord"])
        {
            [[FKHUDHelper shareInstance] dismissTips];
            [self.navigationController popViewControllerAnimated:YES];
        }
        [m_tableView reloadData];
    }
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_record.stage == STAGETYPE_ONE)
    {
        return 3;
    }
    else if (_record.stage == STAGETYPE_TWO)
    {
        return 4;
    }
    else
    {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_record.stage == STAGETYPE_ONE)
    {
        if (indexPath.row == 1 || indexPath.row == 0)
        {
            return 190.f;
        }
        else
        {
            BBYAddImageGridCell* cell =(BBYAddImageGridCell*)[self tableView:m_tableView cellForRowAtIndexPath:indexPath];
            return cell.cellHeight;
        }
    }
    else if (_record.stage == STAGETYPE_TWO)
    {
        if (indexPath.row == 1 || indexPath.row == 0)
        {
            return 190.f;
        }
        else if(indexPath.row == 2)
        {
            BBYAddImageGridCell* cell =(BBYAddImageGridCell*)[self tableView:m_tableView cellForRowAtIndexPath:indexPath];
            return cell.cellHeight;
        }
        else
        {
            return 50.f;
        }

    }
    else
    {
        if (indexPath.row == 0)
        {
            return 190.f;
        }
        else if(indexPath.row == 1)
        {
            BBYAddImageGridCell* cell =(BBYAddImageGridCell*)[self tableView:m_tableView cellForRowAtIndexPath:indexPath];
            return cell.cellHeight;
        }
        else
        {
            return 50.f;
        }
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_record.stage != STAGETYPE_THREE)
    {
        if (indexPath.row == 0)
        {
            static NSString* cellIdentifier = @"CellIdentifier";
            PKTodayStandardFlowCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell)
            {
                cell = [[PKTodayStandardFlowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.standardFlow = m_standardFlow;
            return cell;
        }
        else if (indexPath.row == 1)
        {
            if(_record.stage == STAGETYPE_ONE)
            {
                static NSString* cellIdentifierText = @"CellIdentifierText";
                PKTodayTaskContentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierText];
                if (!cell)
                {
                    cell = [[PKTodayTaskContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierText];
                    cell.delegate = self;
                }
                cell.taskContent = _record.recordContent;
                return cell;
            }
            else
            {
                NSArray* itemDictArray = @[@{@"name":@"耗料",@"value":[NSNumber numberWithInteger:_record.eatFood],@"unit":@"千克"},
                                           @{@"name":@"重量",@"value":[NSNumber numberWithFloat:_record.eachWeight],@"unit":@"千克"},
                                           @{@"name":@"死亡数",@"value":[NSNumber numberWithInteger:_record.deadCount],@"unit":@"只"},
                                    @{@"name":@"淘汰数",@"value":[NSNumber numberWithInteger:_record.weedOut],@"unit":@"只"},
                                           @{@"name":@"温度",@"value":[NSNumber numberWithFloat:_record.temperature],@"unit":@"℃"},
                                           @{@"name":@"湿度",@"value":[NSNumber numberWithFloat:_record.humidity],@"unit":@"%"},
                                    @{@"name":@"饮水量",@"value":[NSNumber numberWithFloat:_record.drinkWater],@"unit":@"升"},
                                    @{@"name":@"光照",@"value":[NSNumber numberWithFloat:_record.sunning],@"unit":@"小时"},
                                           @{@"name":@"疫苗名称",@"value":_record.vaccineName?_record.vaccineName:@"",@"unit":@""},
                                    @{@"name":@"兽药名称",@"value":_record.veterinaryDrugName?_record.veterinaryDrugName:@"",@"unit":@""},
                                    @{@"name":@"消毒/驱虫情况",@"value":_record.disinfectCase?_record.disinfectCase:@"",@"unit":@""}];
                PKTodayTaskCollectCell* cell = [[PKTodayTaskCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
                cell.delegate = self;
                cell.itemDictArray = itemDictArray;
                return cell;
            }
        }
        else if(indexPath.row == 2)
        {
            static NSString* addImageCellIdentifier = @"AddImageCellIdentifier";
            BBYAddImageGridCell* cell = [tableView dequeueReusableCellWithIdentifier:addImageCellIdentifier];
            if (!cell)
            {
                cell = [[BBYAddImageGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addImageCellIdentifier];
                cell.delegate = self;
            }
            [cell setImageArray:m_imageDatas];
            return cell;
        }
        else
        {
            static NSString* recordExtraCell = @"RecordExtraCell";
            PKRecordExtraCell* cell = [tableView dequeueReusableCellWithIdentifier:recordExtraCell];
            if (!cell)
            {
                cell = [[PKRecordExtraCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recordExtraCell];
            }
            [cell setCellData:_record];
            return cell;
        }
        
        return nil;
    }
    else
    {
        if (indexPath.row == 0)
        {
            static NSString* cellIdentifierText = @"CellIdentifierText";
            PKTodayTaskContentCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierText];
            if (!cell)
            {
                cell = [[PKTodayTaskContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierText];
                cell.delegate = self;
            }
            cell.taskContent = _record.recordContent;
            return cell;
        }
        else if(indexPath.row == 1)
        {
            static NSString* addImageCellIdentifier = @"AddImageCellIdentifier";
            BBYAddImageGridCell* cell = [tableView dequeueReusableCellWithIdentifier:addImageCellIdentifier];
            if (!cell)
            {
                cell = [[BBYAddImageGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addImageCellIdentifier];
                cell.delegate = self;
            }
            [cell setImageArray:m_imageDatas];
            return cell;
        }
        else
        {
            static NSString* recordExtraCell = @"RecordExtraCell";
            PKRecordExtraCell* cell = [tableView dequeueReusableCellWithIdentifier:recordExtraCell];
            if (!cell)
            {
                cell = [[PKRecordExtraCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recordExtraCell];
            }
            [cell setCellData:_record];
            return cell;

        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark taskCollect delegate
- (void)itemCellSelected:(NSString *)itemName
{
    PKEditBoard* editBoard = [[PKEditBoard alloc] initWithType:EDITTYPE_TEXT withTitle:itemName];
    editBoard.delegate = self;
    [self.navigationController pushViewController:editBoard animated:YES];
}

#pragma mark editBoadr delegate
- (void)textChangedByItem:(NSString *)itemName changedText:(NSString *)text
{
    if ([itemName isEqualToString:@"耗料"])
    {
        _record.eatFood = [text floatValue];
    }
    else if ([itemName isEqualToString:@"重量"])
    {
        _record.eachWeight = [text floatValue];
    }
    else if ([itemName isEqualToString:@"死亡数"])
    {
        _record.deadCount = [text integerValue];
    }
    else if ([itemName isEqualToString:@"淘汰数"])
    {
        _record.weedOut = [text integerValue];
    }
    else if ([itemName isEqualToString:@"温度"])
    {
        _record.temperature = [text floatValue];
    }
    else if ([itemName isEqualToString:@"湿度"])
    {
        _record.humidity = [text floatValue];
    }
    else if ([itemName isEqualToString:@"饮水量"])
    {
        _record.drinkWater = [text floatValue];
    }
    else if ([itemName isEqualToString:@"光照"])
    {
        _record.sunning = [text floatValue];
    }
    else if ([itemName isEqualToString:@"疫苗名称"])
    {
        _record.vaccineName = text;
    }
    else if ([itemName isEqualToString:@"兽药名称"])
    {
        _record.veterinaryDrugName = text;
    }
    else if ([itemName isEqualToString:@"消毒/驱虫情况"])
    {
        _record.disinfectCase = text;
    }
    [m_tableView reloadData];
}

#pragma mark addImageCellDelegate Delegate
- (void)cellAction:(BBYAddImageGridCell *)cell action:(CELLACTION)action
{
    if (action == CELLACTION_CAMERA)
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
    else if(action == CELLACTION_THUMB)
    {
        QBImagePickerController* imagePicker = [[QBImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsMultipleSelection = YES;
        imagePicker.maximumNumberOfSelection = 9-m_imageDatas.count;
        UINavigationController* imageNav = [[UINavigationController alloc] initWithRootViewController:imagePicker];
        [self presentViewController:imageNav animated:YES completion:nil];
    }
}

#pragma mark QBImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
    [m_imageDatas addObject:data];
    [m_tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark QBImagePicker
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    for (ALAsset* asset in assets)
    {
        UIImage *image=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        NSData* data = UIImageJPEGRepresentation(image, 1.0);
        [m_imageDatas addObject:data];
    }
    [m_tableView reloadData];
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
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
