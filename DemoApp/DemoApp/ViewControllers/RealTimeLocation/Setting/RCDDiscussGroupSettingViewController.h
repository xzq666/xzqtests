//
//  RCDDiscussGroupSettingViewController.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "RCDSettingBaseViewController.h"

typedef void(^setDiscussTitle)(NSString *discussTitle);

@interface RCDDiscussGroupSettingViewController : RCDSettingBaseViewController

//设置讨论组名称后，回传值
@property (nonatomic,copy)  setDiscussTitle setDiscussTitleCompletion;

@property (nonatomic,copy) NSString *conversationTitle;

@end