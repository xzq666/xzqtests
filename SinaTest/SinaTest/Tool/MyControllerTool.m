//
//  MyControllerTool.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyControllerTool.h"

@implementation MyControllerTool

+ (void)chooseRootViewController {
    
    //比较上次使用的版本情况
//    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    //从沙盒中取出上次存储的软件版本号（取出用户上次的使用记录）
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    //获得当前打开软件的版本号
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if ([currentVersion isEqualToString:lastVersion]){
//        //当前是最新版本
//        [UIApplication sharedApplication].statusBarHidden = NO;
//        window.rootViewController = [[MyTabBarController alloc] init];
//    }else{
//        //当前不是最新版本，显示版本新特性
//        window.rootViewController = [[DSNewfeatureViewController alloc] init];
//        //存储这次使用的版本信息
//        [defaults setObject:currentVersion forKey:versionKey];
//        [defaults synchronize];
//    }
    [UIApplication sharedApplication].statusBarHidden = NO;
    window.rootViewController = [[MyTabBarController alloc] init];
}

@end