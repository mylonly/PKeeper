//
//  BBYBaseViewController.h
//  BabyunNew
//
//  Created by 田祥根 on 14/10/23.
//  Copyright (c) 2014年 mylony. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEYBOARDSHOWDURATION  @"UIKeyboardAnimationDurationUserInfoKey"
#define KEYBOARDENDSHOWFRAME  @"UIKeyboardFrameEndUserInfoKey"
#define KEYBOARDENDSHOWCENTER @"UIKeyboardCenterEndUserInfoKey"

#define BASEBOARD_CONTAINERCOLOR  RGB(240, 239, 245)
#define BASEBOARD_NAVCOLOR RGB(123,181,61)

@interface PKBaseBoard : UIViewController

@property (nonatomic,strong) UIView* nav;

@property (nonatomic,strong) UIScrollView* container;



//optional require reload
- (id)initWithTitle:(NSString*)title;

- (void)initNavBar;

- (void)initContainer;

- (void)keyboardWillShow:(NSNotification*)notification;

- (void)keyboardWillHide:(NSNotification*)notification;

- (BOOL)navigationBarHidden;

- (void)requestDidFailed:(ASIHTTPRequest*)theRequest;

- (void)requestDidFinished:(ASIHTTPRequest *)theRequest;

//custom
- (void)hideNavigationBar;

- (void)hideBack;

- (void)onBackButtonClicked;

- (void)addRequest:(id)request;

- (void)removeAllRequest;

- (void)moveKeyTapControlYOffset:(CGFloat)offset;


@end
