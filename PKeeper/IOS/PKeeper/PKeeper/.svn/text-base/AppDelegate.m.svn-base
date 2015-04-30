//
//  AppDelegate.m
//  PKeeper
//
//  Created by mylonly on 15/3/4.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "AppDelegate.h"
#import "PKHomeBoard.h"
#import "PKLoginBoard.h"

@interface AppDelegate ()<CLLocationManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self autoLogin];
    
    PKHomeBoard* home = [[PKHomeBoard alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:home];
    self.window.rootViewController = nav;
    
    return YES;
}

- (void)autoLogin
{
    NSString* username = [[NSUserDefaults standardUserDefaults] valueForKey:USERNAME];
    NSString* password = [[NSUserDefaults standardUserDefaults] valueForKey:PASSWORD];
    if (username && password)
    {
        ASIHTTPRequest* request = [JSHttpHelper get:LOGIN withValue:@{@"username":username,@"password":password} withDelegate:self withUserInfo:@"autologin"];
        [request startAsynchronous];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)navigationBarHidden
{
    return YES;
}

- (void)requestDidFinished:(ASIHTTPRequest *)theRequest
{
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
        if ([userInfo isEqualToString:@"autologin"])
        {
            NSDictionary* data = [response objectForKey:@"userdata"];
            [[PKUserModel shareInstance] constructWithDict:data];
            [[PKChickenHouseModel shareInstance] getchickenInfo];

        }
    }
}

@end
