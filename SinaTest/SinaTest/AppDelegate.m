//
//  AppDelegate.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MyAVStatus.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //启动成功以后不隐藏状态栏
    application.statusBarHidden = NO;
    [MyAVStatus registerSubclass];
    
    [AVOSCloud setApplicationId:ApplicationID clientKey:ClientKey];
    //1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //2.显示窗口成为主窗口
    [self.window makeKeyAndVisible];
    
    //3.设置窗口的根控制器
    AVUser *currentUser = [AVUser currentUser];
    NSLog(@"now:%@",currentUser);
    if (currentUser != nil){
        [MyControllerTool chooseRootViewController];
        NSLog(@"已登录");
    } else {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = (LoginViewController *)[main instantiateInitialViewController];
    }
    
    //4.监控网络
    [MyHttpTool monitoringReachabilityStatus:^(AFNetworkReachabilityStatus status){
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知网络
            case AFNetworkReachabilityStatusNotReachable://没有网络
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://手机自带网络
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
        }
    }];
    //5.增加网络状态激活按钮
    [MyHttpTool showNetworkActivityIndicatior];
    return YES;
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

@end