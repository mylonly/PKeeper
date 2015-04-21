//
//  PKSickReportDetailBoard.m
//  PKeeper
//
//  Created by 田祥根 on 15/3/23.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKSickReportDetailBoard.h"
#import "BBYGridImagesView.h"

@interface PKSickReportDetailBoard ()
{
    UIView* reportContainer;
    UIView* responseContainer;
}
@end

@implementation PKSickReportDetailBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"疾病详情";
    // Do any additional setup after loading the view.
    
    [self createMyReportView];
    if(![_model.responseUserID isEqualToString:@"0"])
    {
        [self createResponseView];
    }
}

- (void)createMyReportView
{
    reportContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 0)];
    reportContainer.layer.cornerRadius = 5.f;
    reportContainer.backgroundColor = [UIColor whiteColor];
    [self.container addSubview:reportContainer];
    
    CGSize size = CGSizeZero;
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280, 20)];
    title.text = _model.reportTitle;
    size = [title.text sizeWithFont:title.font byWidth:title.width];
    title.height = size.height;
    [reportContainer addSubview:title];
    
    UILabel* content = [[UILabel alloc] initWithFrame:CGRectMake(10, title.y+title.height+5, 280, 0)];
    content.numberOfLines = 0;
    content.text = _model.reportContent;
    size = [content.text sizeWithFont:content.font byWidth:content.width];
    content.height = size.height;
    [reportContainer addSubview:content];
    BBYGridImagesView* gridImages = [[BBYGridImagesView alloc] initWithFrame:CGRectMake(10, content.y+content.height+5, 280, 0)];
    [gridImages setImages:_model.picArray];
    [reportContainer addSubview:gridImages];
    
    reportContainer.height = gridImages.y+gridImages.height+10;
    
    self.container.contentSize = CGSizeMake(SCREENWIDTH, reportContainer.y+reportContainer.height);
}

- (void)createResponseView
{
    responseContainer = [[UIView alloc] initWithFrame:CGRectMake(10, reportContainer.y+reportContainer.height+10, 300, 0)];
    responseContainer.backgroundColor = [UIColor whiteColor];
    responseContainer.layer.cornerRadius = 5.f;
    [self.container addSubview:responseContainer];
    
    UIImageView* avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    avatar.layer.masksToBounds = YES;
    avatar.layer.cornerRadius = 40.f;
    avatar.image = [UIImage imageNamed:@"defaultAvatar"];
    [responseContainer addSubview:avatar];
    
    UILabel* name = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 100, 20)];
    name.text = _model.responseCreator;
    [responseContainer addSubview:name];
    
    UILabel* time = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 80, 20)];
    time.font = FONT(14);
    time.textAlignment = NSTextAlignmentRight;
    time.text = [_model.responseCreatorTime substringToIndex:11];
    time.textColor = [UIColor grayColor];
    [responseContainer addSubview:time];
    
    UILabel* content = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 200, 60)];
    content.numberOfLines = 0;
    content.text = _model.responseContent;
    
    CGSize size = [content.text sizeWithFont:content.font byWidth:content.width];
    if (size.height > 60)
    {
        content.height = size.height;
    }
    [responseContainer addSubview:content];
    responseContainer.height = content.y+content.height+10;
    self.container.contentSize = CGSizeMake(SCREENWIDTH, responseContainer.y+responseContainer.height);
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
