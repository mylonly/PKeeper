//
//  PKChickenInfoBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/15.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKChickenInfoBoard.h"
#import "PKEditBoard.h"
#import "SinglePickerSheet.h"
#import "DatePickerSheet.h"
#import "BBYAddImageGridCell.h"
#import "QBImagePickerController.h"

#define PICKSHEET_CHICKENSCALETAG 1001
#define PICKSHEET_CHICKENTAPETAG 1002
#define PICKSHEET_FARMTYPETAG 1003
#define PICKSHEET_CHICKHOUSETYPETAG 1004
#define PICKSHEET_SUPPORTWATERTYPETAG 1005
#define PICKSHEET_SUPPORTFOODTYPETAG 1006
#define PICKSHEET_CLEARSHITTYPETAG 1007
#define PICKSHEET_CHICKENAGETAG 1008
#define PICKSHEET_CHICKENTIMETAG 1009

@interface PKChickenInfoBoard ()<UITableViewDataSource,UITableViewDelegate,UIPickerSheetDelegate,BBYAddImageGridCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,QBImagePickerControllerDelegate>
{
    UITableView* m_tableView;
    NSArray* m_itemArray;
    NSMutableArray* m_imageDatas;
    UIButton* m_submitButton;
}
@end

@implementation PKChickenInfoBoard

- (id)init
{
    self = [super init];
    if (self)
    {
        m_imageDatas = [[NSMutableArray alloc] initWithArray:[PKChickenHouseModel shareInstance].imageUrlArray];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"鸡场信息";
    // Do any additional setup after loading the view.
    
    m_itemArray = @[@{@"title":@"鸡场名称",@"valueKey":@"houseName",@"editType":[NSNumber numberWithInt:EDITTYPE_TEXT]},
                    @{@"title":@"鸡场地址",@"valueKey":@"houseAddress",@"editType":[NSNumber numberWithInt:EDITTYPE_TEXT]},
                    @{@"title":@"鸡场规模",@"valueKey":@"houseScaleTypeStr",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]},
                    @{@"title":@"建厂时间",@"valueKey":@"houseCreatedTime",@"editType":[NSNumber numberWithInt:EDITTYPE_TIME]},
                    @{@"title":@"肉鸡类型",@"valueKey":@"chickenTypeStr",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]},
                    @{@"title":@"养殖方式",@"valueKey":@"farmTypeStr",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]},
                    @{@"title":@"鸡舍类型",@"valueKey":@"chickenHouseTypeStr",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]},
                    @{@"title":@"供水方式",@"valueKey":@"supportWaterTypeStr",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]},
                    @{@"title":@"供料方式",@"valueKey":@"supportFoodTypeStr",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]},
                    @{@"title":@"清粪方式",@"valueKey":@"clearShitTypeStr",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]},
                    @{@"title":@"鸡群组成",@"valueKey":@"chickenAgeTypeStr",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]}];
    
    m_tableView = [[UITableView alloc] initWithFrame:self.container.bounds style:UITableViewStylePlain];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.container addSubview:m_tableView];
    //[self getData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_tableView reloadData];
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
    for (id data in m_imageDatas)
    {
        if ([data isKindOfClass:[NSData class]])
        {
            [[PKChickenHouseModel shareInstance].imageDataArray addObject:data];
        }
    }
    [[PKChickenHouseModel shareInstance] submitChickenInfo];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return m_itemArray.count;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 60.f;
    }
    else
    {
        BBYAddImageGridCell* cell =(BBYAddImageGridCell*)[self tableView:m_tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString* cellIdentifier = @"CellIdentifier";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSDictionary* item = [m_itemArray objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[item valueForKey:@"icon"]];
        cell.textLabel.text = [item valueForKey:@"title"];
        NSString* value = [[PKChickenHouseModel shareInstance] valueForKey:[item valueForKey:@"valueKey"]];
        cell.detailTextLabel.text = value;
        return cell;
    }
    else
    {
        static NSString* addImageCellIdentifier = @"AddImageCellIdentifier";
        BBYAddImageGridCell* cell = [tableView dequeueReusableCellWithIdentifier:addImageCellIdentifier];
        if (!cell)
        {
            cell = [[BBYAddImageGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addImageCellIdentifier];
            cell.cellTitle = @"鸡场布局照片";
            cell.delegate = self;
        }
        [cell setImageArray:m_imageDatas];
        return cell;
    }
}

#pragma mark delegaet
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* item = [m_itemArray objectAtIndex:indexPath.row];
    
    EDITTYPE itemType = (EDITTYPE)[[item valueForKey:@"editType"] integerValue];
    if (itemType == EDITTYPE_TEXT)
    {
        PKEditBoard* editBoard = [[PKEditBoard alloc] initWithType:EDITTYPE_TEXT withTitle:[item valueForKey:@"title"]];
        editBoard.modifyText = [[PKChickenHouseModel shareInstance] valueForKey:[item valueForKey:@"valueKey"]];
        [self.navigationController pushViewController:editBoard  animated:YES];
    }
    else if (itemType == EDITTYPE_TIME)
    {
        DatePickerSheet* datePicker = [[DatePickerSheet alloc] initWithTitle:@"选择建厂时间" delegate:self];
        datePicker.tag = PICKSHEET_CHICKENTIMETAG;
        [datePicker showInView:self.view];
    }
    else if (itemType == EDITTYPE_MULTISELECT)
    {
        NSString* title = [item valueForKey:@"title"];
        if ([title isEqualToString:@"鸡场规模"])
        {
            SinglePickerSheet* picker = [[SinglePickerSheet alloc] initWithTitle:@"选择规模" delegate:self];
            picker.tag = PICKSHEET_CHICKENSCALETAG;
            picker.itemArray = [PKChickenHouseModel shareInstance].houseScaleTypeAry;
            [picker showInView:self.view];
        }
        else if([title isEqualToString:@"肉鸡类型"])
        {
            SinglePickerSheet* picker = [[SinglePickerSheet alloc] initWithTitle:@"选择肉鸡类型" delegate:self];
            picker.tag = PICKSHEET_CHICKENTAPETAG;
            picker.itemArray = [PKChickenHouseModel shareInstance].chickenTypeAry;
            [picker showInView:self.view];
        }
        else if ([title isEqualToString:@"养殖方式"])
        {
            SinglePickerSheet* picker = [[SinglePickerSheet alloc] initWithTitle:@"选择养殖方式" delegate:self];
            picker.tag = PICKSHEET_FARMTYPETAG;
            picker.itemArray = [PKChickenHouseModel shareInstance].farmTypeAry;
            [picker showInView:self.view];
        }
        else if ([title isEqualToString:@"鸡舍类型"])
        {
            SinglePickerSheet* picker = [[SinglePickerSheet alloc] initWithTitle:@"选择鸡舍类型" delegate:self];
            picker.tag = PICKSHEET_CHICKHOUSETYPETAG;
            picker.itemArray = [PKChickenHouseModel shareInstance].chickenHouseTypeAry;
            [picker showInView:self.view];
        }
        else if ([title isEqualToString:@"供水方式"])
        {
            SinglePickerSheet* picker = [[SinglePickerSheet alloc] initWithTitle:@"选择供水方式" delegate:self];
            picker.tag = PICKSHEET_SUPPORTWATERTYPETAG;
            picker.itemArray = [PKChickenHouseModel shareInstance].supportWaterTypeAry;
            [picker showInView:self.view];
        }
        else if ([title isEqualToString:@"供料方式"])
        {
            SinglePickerSheet* picker = [[SinglePickerSheet alloc] initWithTitle:@"选择供料方式" delegate:self];
            picker.tag = PICKSHEET_SUPPORTFOODTYPETAG;
            picker.itemArray = [PKChickenHouseModel shareInstance].supportFoodTypeAry;
            [picker showInView:self.view];
        }
        else if ([title isEqualToString:@"清粪方式"])
        {
            SinglePickerSheet* picker = [[SinglePickerSheet alloc] initWithTitle:@"选择清粪方式" delegate:self];
            picker.tag = PICKSHEET_CLEARSHITTYPETAG;
            picker.itemArray = [PKChickenHouseModel shareInstance].clearShitTypeAry;
            [picker showInView:self.view];
        }
        else if ([title isEqualToString:@"鸡群组成"])
        {
            SinglePickerSheet* picker = [[SinglePickerSheet alloc] initWithTitle:@"选择鸡群方式" delegate:self];
            picker.tag = PICKSHEET_CHICKENAGETAG;
            picker.itemArray = [PKChickenHouseModel shareInstance].chickenAgeTypeAry;
            [picker showInView:self.view];
        }
    }
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


#pragma mark picker sheet delegate
- (void)pickerSheet:(UIView *)sheet selectWithButtonIndex:(NSInteger)buttonIndex
{
    SinglePickerSheet* pickerSheet = (SinglePickerSheet*)sheet;
    if (sheet.tag == PICKSHEET_CHICKENSCALETAG)
    {
        [PKChickenHouseModel shareInstance].houseScaleType = pickerSheet.pickerIndex + 1;
    }
    else if (sheet.tag == PICKSHEET_CHICKENTAPETAG)
    {
        [PKChickenHouseModel shareInstance].chickenType = pickerSheet.pickerIndex + 1;
    }
    else if (sheet.tag == PICKSHEET_FARMTYPETAG)
    {
        [PKChickenHouseModel shareInstance].farmType = pickerSheet.pickerIndex + 1;
    }
    else if (sheet.tag == PICKSHEET_CHICKHOUSETYPETAG)
    {
        [PKChickenHouseModel shareInstance].chickenHouseType = pickerSheet.pickerIndex + 1;
    }
    else if (sheet.tag == PICKSHEET_SUPPORTWATERTYPETAG)
    {
        [PKChickenHouseModel shareInstance].supportWaterType = pickerSheet.pickerIndex + 1;
    }
    else if (sheet.tag == PICKSHEET_SUPPORTFOODTYPETAG)
    {
        [PKChickenHouseModel shareInstance].supportFoodType = pickerSheet.pickerIndex + 1;
    }
    else if (sheet.tag == PICKSHEET_CLEARSHITTYPETAG)
    {
        [PKChickenHouseModel shareInstance].clearShitType = pickerSheet.pickerIndex + 1;
    }
    else if (sheet.tag == PICKSHEET_CHICKENAGETAG)
    {
        [PKChickenHouseModel shareInstance].chickenAgeType = pickerSheet.pickerIndex + 1;
    }
    else if (sheet.tag == PICKSHEET_CHICKENTIMETAG)
    {
        DatePickerSheet* datePicker = (DatePickerSheet*)sheet;
        [PKChickenHouseModel shareInstance].houseCreatedTime = datePicker.dateString;
    }
    [m_tableView reloadData];
}

#pragma mark overload
- (void)requestDidFailed:(ASIHTTPRequest *)theRequest
{
    [super requestDidFailed:theRequest];
    [[FKHUDHelper shareInstance] dismissTips];
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
        if ([userInfo isEqualToString:@"GetChickenInfo"])
        {
            NSDictionary* data = [response objectForKey:@"data"];
            
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
