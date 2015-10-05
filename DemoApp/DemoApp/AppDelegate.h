//
//  AppDelegate.h
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

