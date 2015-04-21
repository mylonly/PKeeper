//
//  BBYBaseViewController.m
//  BabyunNew
//
//  Created by 田祥根 on 14/10/23.
//  Copyright (c) 2014年 mylony. All rights reserved.
//

#import "PKBaseBoard.h"
#import "JSHttpHelper.h"
#import "ASINetworkQueue.h"
#import "UIView+Background.h"



@interface PKBaseBoard ()
{
    UIButton* backBtn;
    UILabel* titleLabel;
    NSOperationQueue* operationQueue;
    
    CGFloat containerHeight;
    
    UIControl* keyboardTapControl; //keyboard的tap响应
}
@end

@implementation PKBaseBoard
- (id)init
{
    self = [super init];
    if (self)
    {
        operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)dealloc
{
}

- (id)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self)
    {
        self.title = title;
        operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.

    [self initNavBar];
    [self initContainer];
    
    containerHeight = self.container.height;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addNotifactionOfKeyBoard];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeAllRequest];
    [self removeNotifactionOfKeyBoard];
}

- (BOOL)navigationBarHidden
{
    return NO;
}

- (void)initNavBar
{
    //不需要导航栏
    if ([self navigationBarHidden])
    {
        self.nav.frame = CGRectMake(0, 0, 0, 0);
        return;
    }
    
    self.nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44+Y_OFFSET)];
    [self.nav setBackgroundColor:BASEBOARD_NAVCOLOR];
    [self.view addSubview:self.nav];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, Y_OFFSET, 240, 44)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:self.title];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.textColor = [UIColor whiteColor];
    [self.nav addSubview:titleLabel];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 7.f+Y_OFFSET, 60.f, 30.f)];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setImage:[UIImage imageNamed:@"nav_back_up.png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"nav_back_down.png"] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(onBackButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.nav  addSubview:backBtn];
}

- (void)initContainer
{
    self.container = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.nav.height, 320, self.view.bounds.size.height-self.nav.height)];
    self.container.backgroundColor = BASEBOARD_CONTAINERCOLOR;
    self.container.bounces = NO;
    [self.view addSubview:self.container];
}

- (void)addNotifactionOfKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)removeNotifactionOfKeyBoard
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)moveKeyTapControlYOffset:(CGFloat)offset
{
    if (keyboardTapControl)
    {
        keyboardTapControl.y = keyboardTapControl.y - offset;
    }
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    self.container.height = containerHeight - height;
    
    if(!keyboardTapControl)
    {
        keyboardTapControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.container.width, self.container.height)];
        [keyboardTapControl addTarget:self action:@selector(keyboardHideAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.container addSubview:keyboardTapControl];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    self.container.height = containerHeight;
    if (keyboardTapControl)
    {
        [keyboardTapControl removeFromSuperview];
        keyboardTapControl = nil;
    }
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    titleLabel.text = title;
}

- (void)hideNavigationBar
{
    self.nav.frame = CGRectMake(0, 0, 0, 0);
    self.container.frame = self.view.bounds;
}

- (void)hideBack
{
    backBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"memeoy->>>>>>>");
}

#pragma mark action
- (void)keyboardHideAction:(UIButton*)sender
{
    [self viewResignFirstResponder:self.container];
}

- (void)viewResignFirstResponder:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        
        if (![subview isKindOfClass:[UITextField class]] && ![subview isKindOfClass:[UITextView class]]) {
            [self viewResignFirstResponder:subview];
        }
        else
        {
            [subview resignFirstResponder];
        }
    }
}


- (void)onBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- NETWORK

- (void)addRequest:(id)request
{
    if ([request isKindOfClass:[ASIHTTPRequest class]]) {
        [operationQueue addOperation:request];
    }
}

- (void)removeAllRequest
{
    for (ASIHTTPRequest *request in [operationQueue operations]) {
        [request clearDelegatesAndCancel];
    }
    [operationQueue cancelAllOperations];
}


#pragma mark ASIHttpRequest
- (void)requestDidFailed:(ASIHTTPRequest*)theRequest
{
#ifdef DEBUG
    NSLog(@"Base:%@",theRequest.error);
#endif
    
}
- (void)requestDidFinished:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Base:%@",theRequest.responseString);
    NSString* userInfo =  [theRequest.userInfo objectForKey:@"userInfo"];
    NSDictionary* response = [[CJSONDeserializer deserializer]deserialize:theRequest.responseData error:nil];
    NSInteger code = [[response objectForKey:@"code"] integerValue];
    NSString* message = [response objectForKey:@"message"];
    NSArray* data = [response objectForKey:@"data"];
    if (code)
    {
#ifdef DEBUG
        NSLog(@"Base:%@",message);
#endif
        if (code == 1000)
        {
            
        }
    }
    else
    {
    }
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
