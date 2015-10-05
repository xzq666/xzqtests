//
//  AppDelegate.m
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "AppDelegate.h"
#import "RCDLoginViewController.h"
#import "RCDRCIMDataSource.h"
#import "RCDLoginInfo.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "UIColor+RCColor.h"
#import "RCDCommonDefine.h"
#import "RCDHttpTool.h"
#import "AFHttpTool.h"
#import "RCDataBaseManager.h"

#define RONGCLOUD_IM_APPKEY @"z3v5yqkbv8v30"
#define UMENG_APPKEY @"551ce859fd98c57cdf000678"

#define iPhone6                                                                \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(750, 1334),                              \
[[UIScreen mainScreen] currentMode].size)           \
: NO)
#define iPhone6Plus                                                            \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(1242, 2208),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BOOL debugMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"rongcloud appkey debug"];
    //debugMode是为了切换appkey测试用的，请应用忽略关于debugMode的信息，这里直接调用init。
    if (!debugMode) {
        //初始化融云SDK
        [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    }
    
    //设置会话列表头像和会话界面头像
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    if (iPhone6Plus) {
        [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(56, 56);
    } else {
        NSLog(@"iPhone6 %d", iPhone6);
        [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    }
    //    [RCIM sharedRCIM].portraitImageViewCornerRadius = 10;
    //设置用户信息源和群组信息源
    [RCIM sharedRCIM].userInfoDataSource = RCDDataSource;
    [RCIM sharedRCIM].groupInfoDataSource = RCDDataSource;
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    
    //登录
//    NSString *token =[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
//    NSString *userId=[DEFAULTS objectForKey:@"userId"];
//    NSString *userName = [DEFAULTS objectForKey:@"userName"];
//    NSString *password = [DEFAULTS objectForKey:@"userPwd"];
//    if (token.length && userId.length && password.length && !debugMode) {
//        RCUserInfo *_currentUserInfo =
//        [[RCUserInfo alloc] initWithUserId:userId
//                                      name:userName
//                                  portrait:nil];
//        [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
//        [[RCIM sharedRCIM] connectWithToken:token
//                                    success:^(NSString *userId) {
//                                        [AFHttpTool loginWithEmail:userName
//                                                          password:password
//                                                               env:1
//                                                           success:^(id response) {
//                                                               if ([response[@"code"] intValue] == 200) {
//                                                                   [RCDHTTPTOOL getUserInfoByUserID:userId
//                                                                                         completion:^(RCUserInfo *user) {
//                                                                                             [[RCIM sharedRCIM]
//                                                                                              refreshUserInfoCache:user
//                                                                                              withUserId:userId];
//                                                                                         }];
//                                                                   //登陆demoserver成功之后才能调demo 的接口
//                                                                   [RCDDataSource syncGroups];
//                                                                   [RCDDataSource syncFriendList:^(NSMutableArray * result) {}];
//                                                               }
//                                                           }
//                                                           failure:^(NSError *err){
//                                                           }];
//                                        //设置当前的用户信息
//                                        
//                                        //同步群组
//                                        //调用connectWithToken时数据库会同步打开，不用再等到block返回之后再访问数据库，因此不需要这里刷新
//                                        //这里仅保证之前已经成功登陆过，如果第一次登陆必须等block 返回之后才操作数据
//                                        //          dispatch_async(dispatch_get_main_queue(), ^{
//                                        //            UIStoryboard *storyboard =
//                                        //                [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                                        //            UINavigationController *rootNavi = [storyboard
//                                        //                instantiateViewControllerWithIdentifier:@"rootNavi"];
//                                        //            self.window.rootViewController = rootNavi;
//                                        //          });
//                                    }
//                                      error:^(RCConnectErrorCode status) {
//                                          RCUserInfo *_currentUserInfo =[[RCUserInfo alloc] initWithUserId:userId
//                                                                                                      name:userName
//                                                                                                  portrait:nil];
//                                          [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
//                                          [RCDDataSource syncGroups];
//                                          NSLog(@"connect error %ld", (long)status);
//                                          dispatch_async(dispatch_get_main_queue(), ^{
//                                              UIStoryboard *storyboard =
//                                              [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                                              UINavigationController *rootNavi = [storyboard
//                                                                                  instantiateViewControllerWithIdentifier:@"rootNavi"];
//                                              self.window.rootViewController = rootNavi;
//                                          });
//                                      }
//                             tokenIncorrect:^{
//                                 dispatch_async(dispatch_get_main_queue(), ^{
////                                     RCDLoginViewController *loginVC =
////                                     [[RCDLoginViewController alloc] init];
////                                     UINavigationController *_navi = [[UINavigationController alloc]
////                                                                      initWithRootViewController:loginVC];
////                                     self.window.rootViewController = _navi;
//                                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
//                                                                message:@"Token已过期，请重新登录"
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil, nil];
//                                     ;
//                                     [alertView show];
//                                 });
//                             }];
//        
//    } else { //直接登录
        RCDLoginViewController *loginVC = [[RCDLoginViewController alloc] init];
        UINavigationController *_navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = _navi;
//    }
    
    /**
     * 推送处理1
     */
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    /**
     * 统计Push打开率1
     */
//    [[RCIMClient sharedRCIMClient] recordLaunchOptionsEvent:launchOptions];
    
    //统一导航条样式
    UIFont *font = [UIFont systemFontOfSize:19.f];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : font,
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"0195ff" alpha:1.0f]];
    
    return YES;
}

/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     * 统计Push打开率2
     */
//    [[RCIMClient sharedRCIMClient] recordLocalNotificationEvent:notification];
    
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
}

/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计Push打开率3
     */
//    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down
    // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate
    // timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE),
                                                                         @(ConversationType_DISCUSSION),
                                                                         @(ConversationType_APPSERVICE),
                                                                         @(ConversationType_PUBLICSERVICE),
                                                                         @(ConversationType_GROUP)
                                                                         ]];
    application.applicationIconBadgeNumber = unreadMsgCount;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state;
    // here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the
    // application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if
    // appropriate. See also applicationDidEnterBackground:.
}

- (void)redirectNSlogToDocumentFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMddHHmmss"];
    NSString *formattedDate = [dateformatter stringFromDate:currentDate];
    
    NSString *fileName = [NSString stringWithFormat:@"rc%@.log", formattedDate];
    NSString *logFilePath =
    [documentDirectory stringByAppendingPathComponent:fileName];
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",
            stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+",
            stderr);
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}

#pragma mark - RCWKAppInfoProvider
- (NSString *)getAppName {
    return @"融云";
}

- (NSString *)getAppGroups {
    return @"group.com.RCloud.UIComponent.WKShare";
}

- (void)openParentApp {
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"rongcloud://connect"]];
}

- (BOOL)getNewMessageNotificationSound {
    return ![RCIM sharedRCIM].disableMessageAlertSound;
}

- (void)setNewMessageNotificationSound:(BOOL)on {
    [RCIM sharedRCIM].disableMessageAlertSound = !on;
}

- (void)logout {
    [DEFAULTS removeObjectForKey:@"userName"];
    [DEFAULTS removeObjectForKey:@"userPwd"];
    [DEFAULTS removeObjectForKey:@"userToken"];
    [DEFAULTS removeObjectForKey:@"userCookie"];
    if (self.window.rootViewController != nil) {
        UIStoryboard *storyboard =
        [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RCDLoginViewController *loginVC =
        [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        UINavigationController *navi =
        [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = navi;
    }
    [[RCIMClient sharedRCIMClient] disconnect:NO];
}

- (BOOL)getLoginStatus {
    NSString *token = [DEFAULTS stringForKey:@"userToken"];
    if (token.length) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - RCIMConnectionStatusDelegate
/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        RCDLoginViewController *loginVC = [[RCDLoginViewController alloc] init];
        // [loginVC defaultLogin];
        // RCDLoginViewController* loginVC = [storyboard
        // instantiateViewControllerWithIdentifier:@"loginVC"];
        UINavigationController *_navi =
        [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = _navi;
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RCDLoginViewController *loginVC =
            [[RCDLoginViewController alloc] init];
            UINavigationController *_navi = [[UINavigationController alloc]
                                             initWithRootViewController:loginVC];
            self.window.rootViewController = _navi;
            UIAlertView *alertView =
            [[UIAlertView alloc] initWithTitle:nil
                                       message:@"Token已过期，请重新登录"
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil, nil];
            ;
            [alertView show];
        });
    }
}

-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    if ([message.content isMemberOfClass:[RCInformationNotificationMessage class]]) {
        RCInformationNotificationMessage *msg=(RCInformationNotificationMessage *)message.content;
        //NSString *str = [NSString stringWithFormat:@"%@",msg.message];
        if ([msg.message rangeOfString:@"你已添加了"].location!=NSNotFound) {
            [RCDDataSource syncFriendList:^(NSMutableArray *friends) {
            }];
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RCKitDispatchMessageNotification object:nil];
}

@end