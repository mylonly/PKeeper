//
//  PKUserInfoBoard.m
//  PKeeper
//
//  Created by mylonly on 15/3/15.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKUserInfoBoard.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "PKUploadImage.h"
#import "PKEditBoard.h"
#import "SinglePickerSheet.h"
#import "TSLocateView.h"

#define PICKERSHEET_AGE_TAG 1001
#define PICKERSHEET_GENDER_TAG 1002
#define PICKERSHEET_ADDRESS_TAG 1003
#define PICKERSHEET_WORKYEAR_TAG 1004

@interface PKUserInfoBoard ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerSheetDelegate>
{
    UIImageView* m_userAvatar;
    UITableView* m_tableView;
    NSArray* m_itemArray;
}
@end

@implementation PKUserInfoBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    m_itemArray = @[@{@"title":@"姓名",@"icon":@"name-icon",@"valueKey":@"realName",@"editType":[NSNumber numberWithInt:EDITTYPE_TEXT]},
                    @{@"title":@"从业年限",@"icon":@"duration-icon",@"valueKey":@"workYear",@"editType":[NSNumber numberWithInt:EDITTYPE_MULTISELECT]},
                    @{@"title":@"性别",@"icon":@"gender-icon",@"valueKey":@"gender",@"editType":[NSNumber numberWithInt:EDITTYPE_GENDER]},
                    @{@"title":@"年龄",@"icon":@"age-icon",@"valueKey":@"age",@"editType":[NSNumber numberWithInt:EDITTYPE_AGE]},
                    @{@"title":@"手机号码",@"icon":@"mobile-icon",@"valueKey":@"mobile",@"editType":[NSNumber numberWithInt:EDITTYPE_TEXT]},
                    @{@"title":@"QQ",@"icon":@"qq-icon",@"valueKey":@"qqNum",@"editType":[NSNumber numberWithInt:EDITTYPE_TEXT]},
                    @{@"title":@"Email",@"icon":@"email-icon",@"valueKey":@"email",@"editType":[NSNumber numberWithInt:EDITTYPE_TEXT]},
                    @{@"title":@"省/市",@"icon":@"address-icon",@"valueKey":@[@"province",@"city"],@"editType":[NSNumber numberWithInt:EDITTYPE_ADDRESS]},
                    @{@"title":@"详细地址",@"icon":@"detail-address-icon",@"valueKey":@"address",@"editType":[NSNumber numberWithInt:EDITTYPE_TEXT]}];
    m_tableView = [[UITableView alloc] initWithFrame:self.container.bounds style:UITableViewStylePlain];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.container addSubview:m_tableView];
    m_tableView.tableHeaderView = [self createHeaderView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [m_tableView reloadData];
}

#pragma overload
- (void)onBackButtonClicked
{
    NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                            @"realName":[PKUserModel shareInstance].realName,
                            @"workyear":[PKUserModel shareInstance].workYear,
                            @"age":[PKUserModel shareInstance].age,
                            @"gender":[PKUserModel shareInstance].gender,
                            @"email":[PKUserModel shareInstance].email,
                            @"mobile":[PKUserModel shareInstance].mobile,
                            @"qq":[PKUserModel shareInstance].qqNum,
                            @"address":[PKUserModel shareInstance].address,
                            @"province":[PKUserModel shareInstance].province,
                            @"city":[PKUserModel shareInstance].city,
                            @"picAddress":[PKUserModel shareInstance].avatarUrl};
    ASIHTTPRequest* request = [JSHttpHelper get:SUBMIT_USERINFO withValue:param withDelegate:self withUserInfo:@"submitUserInfo"];
    [self addRequest:request];
    [[FKHUDHelper shareInstance] presentLoadingTips:@"提交个人信息"];
}

- (void)requestDidFailed:(ASIHTTPRequest *)theRequest
{
    [super requestDidFailed:theRequest];
    [[FKHUDHelper shareInstance] dismissTips];
}

- (void)requestDidFinished:(ASIHTTPRequest *)theRequest
{
    [super requestDidFinished:theRequest];
    [[FKHUDHelper shareInstance] dismissTips];
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
        if ([userInfo isEqualToString:@"submitUserInfo"])
        {
            NSLog(@"提交个人信息成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* mediaType = nil;
    UIImagePickerControllerSourceType sourceType;
    if (actionSheet.tag == 255)
    {
        switch (buttonIndex)
        {
            case 0://相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                mediaType = (NSString*)kUTTypeImage;
                break;
                return;
            case 1://相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                mediaType = (NSString*)kUTTypeImage;
                break;
            case 2:
                return;
        }
    }
    else if (actionSheet.tag == 256)
    {
        switch (buttonIndex)
        {
            case 0:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                mediaType = (NSString*)kUTTypeImage;
                break;
            case 1:
                return;
            default:
                break;
        }
    }
    [self presentSystemCamera:sourceType mediaType:mediaType];
}

- (void)presentSystemCamera:(UIImagePickerControllerSourceType)SourceType mediaType:(NSString*)mediaType
{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = SourceType;
    if (mediaType)
    {
        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:mediaType, nil];
    }
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}


#pragma mark localaction
- (UIView*)createHeaderView
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    m_userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(120, 10, 80, 80)];
    [m_userAvatar sd_setImageWithURL:[NSURL URLWithString:[PKUserModel shareInstance].avatarUrl] placeholderImage:[UIImage imageNamed:@"defaultAvatar"]];
    m_userAvatar.layer.cornerRadius = 40.f;
    m_userAvatar.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarChangeAction:)];
    m_userAvatar.clipsToBounds = YES;
    [m_userAvatar addGestureRecognizer:tap];
    
    UILabel* tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
    tips.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    tips.textColor = [UIColor whiteColor];
    tips.text = @"更换头像";
    tips.font = FONT(12);
    tips.textAlignment = NSTextAlignmentCenter;
    [m_userAvatar addSubview:tips];
    [headerView addSubview:m_userAvatar];
    return headerView;
}

- (void)avatarChangeAction:(UITapGestureRecognizer*)gesture
{
    // 判断是否支持相机
    UIActionSheet* sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        sheet.tag = 255;
        [sheet showInView:self.container];
    }
    else
    {
        sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
        [sheet showInView:self.container];
        sheet.tag = 256;
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    NSString* mediaType = [info valueForKey:@"UIImagePickerControllerMediaType"];
    if ( [mediaType  isEqualToString: @"public.image"])
    {
        UIImage* image = [info valueForKey:@"UIImagePickerControllerEditedImage"];
        PKUploadImage* uploadImage = [[PKUploadImage alloc] init];
        uploadImage.image = image;
        m_userAvatar.image = image;
        [uploadImage uploadWithSuccessBlock:^(id result) {
            NSLog(@"%@",result);
            [PKUserModel shareInstance].avatarUrl = UPYUNIMAGEPATH(uploadImage.savekey);
        } withProgressBlock:^(CGFloat percent, long long requestDidSendBytes, long long totalBytes) {
            NSLog(@"%d%%",(int)(percent*100));
        }];
    }
}

#pragma mark table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifer = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary* item = [m_itemArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[item valueForKey:@"icon"]];
    cell.textLabel.text = [item valueForKey:@"title"];
    if ([cell.textLabel.text isEqualToString:@"省/市"])
    {
        NSString* province = [[PKUserModel shareInstance] valueForKey:[[item valueForKey:@"valueKey"] firstObject]];
        NSString* city =  [[PKUserModel shareInstance] valueForKey:[[item valueForKey:@"valueKey"] lastObject]];
        NSString* value = [NSString stringWithFormat:@"%@%@",province,city];
        cell.detailTextLabel.text = value;
    }
    else
    {
        NSString* value = [[PKUserModel shareInstance] valueForKey:[item valueForKey:@"valueKey"]];
        cell.detailTextLabel.text = value;
    }
    return cell;
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* item = [m_itemArray objectAtIndex:indexPath.row];
    
    EDITTYPE itemType = (EDITTYPE)[[item valueForKey:@"editType"] integerValue];
    if (itemType == EDITTYPE_TEXT)
    {
        PKEditBoard* editBoard = [[PKEditBoard alloc] initWithType:EDITTYPE_TEXT withTitle:[item valueForKey:@"title"]];
        editBoard.modifyText = [[PKUserModel shareInstance] valueForKey:[item valueForKey:@"valueKey"]];
        [self.navigationController pushViewController:editBoard  animated:YES];
    }
    else if(itemType ==EDITTYPE_GENDER)
    {
        SinglePickerSheet* genderPicker = [[SinglePickerSheet alloc] initWithTitle:@"选择性别" delegate:self];
        genderPicker.tag = PICKERSHEET_GENDER_TAG;
        genderPicker.itemArray = @[@"男",@"女"];
        [genderPicker showInView:self.view];
    }
    else if (itemType == EDITTYPE_AGE)
    {
        SinglePickerSheet* agePicker = [[SinglePickerSheet alloc] initWithTitle:@"选择年龄" delegate:self];
        agePicker.tag = PICKERSHEET_AGE_TAG;
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for (int i = 20; i < 80; i++)
        {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [agePicker setItemArray:array];
        [agePicker showInView:self.view];
    }
    else if (itemType == EDITTYPE_ADDRESS)
    {
        TSLocateView* locate = [[TSLocateView alloc] initWithTitle:@"选择城市" delegate:self];
        locate.tag = PICKERSHEET_ADDRESS_TAG;
        [locate showInView:self.view];
    }
    else if (itemType == EDITTYPE_MULTISELECT)
    {
        if ([[item valueForKey:@"title"] isEqualToString:@"从业年限"])
        {
            SinglePickerSheet* agePicker = [[SinglePickerSheet alloc] initWithTitle:@"选择年龄" delegate:self];
            agePicker.tag = PICKERSHEET_WORKYEAR_TAG;
            NSMutableArray* array = [[NSMutableArray alloc] init];
            for (int i = 1; i < 30; i++)
            {
                [array addObject:[NSString stringWithFormat:@"%d",i]];
            }
            [agePicker setItemArray:array];
            [agePicker showInView:self.view];
        }
    }
}

#pragma mark pickSheet
- (void)pickerSheet:(UIView *)sheet selectWithButtonIndex:(NSInteger)buttonIndex
{
    SinglePickerSheet* picker = (SinglePickerSheet*)sheet;
    if (picker.tag == PICKERSHEET_AGE_TAG)
    {
        [PKUserModel shareInstance].age = picker.pickerString;
    }
    else if(picker.tag == PICKERSHEET_GENDER_TAG)
    {
        [PKUserModel shareInstance].gender = picker.pickerString;
    }
    else if (picker.tag == PICKERSHEET_WORKYEAR_TAG)
    {
        [PKUserModel shareInstance].workYear = picker.pickerString;
    }
    else
    {
        TSLocateView* locate = (TSLocateView*)sheet;
        [PKUserModel shareInstance].province = locate.locate.state;
        [PKUserModel shareInstance].city = locate.locate.city;
    }
    [m_tableView reloadData];
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
