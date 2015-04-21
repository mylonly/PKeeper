//
//  PKAddNewSickReportBoard.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/23.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKAddNewSickReportBoard.h"
#import "BBYAddImageGridCell.h"
#import "GCPlaceholderTextView.h"
#import "QBImagePickerController.h"
#import "PKUploadImage.h"

@interface PKAddNewSickReportBoard ()<UITableViewDataSource,UITableViewDelegate,BBYAddImageGridCellDelegate,QBImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITableView* m_tableView;
    UITextField* m_titleField;
    GCPlaceholderTextView* m_textView;
    
    NSString* m_title;
    NSString* m_content;
    NSMutableArray* m_imageDatas;
}
@end

@implementation PKAddNewSickReportBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建疾病报告";
    m_imageDatas = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    

    m_tableView = [[UITableView alloc] initWithFrame:self.container.bounds style:UITableViewStylePlain];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.container addSubview:m_tableView];
}

- (void)initNavBar
{
    [super initNavBar];
    UIButton* submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, Y_OFFSET, 60, 44)];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = FONT(14);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nav addSubview:submitBtn];
}

#pragma mark action
- (void)submitAction:(UIButton*)sender
{
    [[FKHUDHelper shareInstance] presentLoadingTips:@"上传中..."];
    if (m_imageDatas.count)
    {
        __block int i = 0;
        NSMutableArray* m_imageNames = [[NSMutableArray alloc] init];
        for (NSData* data in m_imageDatas)
        {
            PKUploadImage* image = [[PKUploadImage alloc] init];
            image.imageData = data;
            [image uploadWithSuccessBlock:^(id result) {
                i ++;
                NSLog(@"image:%@ 上传成功",image.imageName);
                [m_imageNames addObject:UPYUNIMAGEPATH(image.savekey)];
                if (i == m_imageDatas.count)
                {
                    [self submitReport:[m_imageNames componentsJoinedByString:@","]];
                }
            } withProgressBlock:nil];
        }
    }
    else
    {
        [self submitReport:nil];
    }
}

- (void)submitReport:(NSString*)pic
{
    NSDictionary* param = @{@"userid":[PKUserModel shareInstance].userID,
                            @"title":m_title?m_title:@"",
                            @"desc":m_content?m_content:@"",
                            @"pic":pic?pic:@""};
    ASIHTTPRequest* request = [JSHttpHelper get:SUBMIT_SICKREPORT withValue:param withDelegate:self withUserInfo:@"SubmitReport"];
    [self addRequest:request];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 60.f;
    }
    else if (indexPath.row == 1)
    {
        return 140.f;
    }
    else
    {
        return 60.f;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        m_titleField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
        m_titleField.placeholder = @"输入疾病标题";
        m_titleField.text = m_title;
        m_titleField.layer.cornerRadius = 5.f;
        m_titleField.layer.borderWidth = 0.5f;
        m_titleField.layer.borderColor = [UIColor grayColor].CGColor;
        [cell.contentView addSubview:m_titleField];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        m_textView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 10, 300, 120)];
        m_textView.placeholder = @"输入疾病的详细情况";
        m_textView.text = m_content;
        m_textView.font = [UIFont systemFontOfSize:18];
        m_textView.layer.cornerRadius = 5.f;
        m_textView.layer.borderWidth = 0.5f;
        m_textView.layer.borderColor = [UIColor grayColor].CGColor;
        [cell.contentView addSubview:m_textView];
        return cell;
    }
    else
    {
        BBYAddImageGridCell* cell = [[BBYAddImageGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.delegate = self;
        [cell setImageArray:m_imageDatas];
        return cell;
    }
}

#pragma mark addImageCellDelegate Delegate
- (void)cellAction:(BBYAddImageGridCell *)cell action:(CELLACTION)action
{
    m_title = m_titleField.text;
    m_content = m_textView.text;
    
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
        if ([userInfo isEqualToString:@"SubmitReport"])
        {
            [[FKHUDHelper shareInstance] dismissTips];
            NSLog(@"%@",message);
            [self.navigationController popViewControllerAnimated:YES];
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
