//
//  RCDServiceViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDServiceViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCDChatViewController.h"

@implementation RCDServiceViewController

- (IBAction)acService:(UIButton *)sender {
#define SERVICE_ID @"kefu114"
    RCDChatViewController *chatService = [[RCDChatViewController alloc] init];
    chatService.userName = @"客服";
    chatService.targetId = SERVICE_ID;
    chatService.conversationType = ConversationType_CUSTOMERSERVICE;
    chatService.title = chatService.userName;
    //    RCHandShakeMessage* textMsg = [[RCHandShakeMessage alloc] init];
    //    [[RongUIKit sharedKit] sendMessage:ConversationType_CUSTOMERSERVICE targetId:SERVICE_ID content:textMsg delegate:nil];
    //
    [self.navigationController pushViewController :chatService animated:YES];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //设置为不用默认渲染方式
        self.tabBarItem.image = [[UIImage imageNamed:@"icon_server"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_server_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMessageNotification:)
                                                     name:RCKitDispatchMessageNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor whiteColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"客服";
    self.tabBarController.navigationItem.titleView = titleView;
    // self.tabBarController.navigationItem.title = @"客服";
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    self.tabBarItem.badgeValue = nil;
}

-(void)didReceiveMessageNotification:(NSNotification *)notification {
    __weak typeof(&*self) __weakSelf = self;
    RCMessage *message = notification.object;
    if (message.conversationType == ConversationType_CUSTOMERSERVICE) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            int count = [[RCIMClient sharedRCIMClient]getUnreadCount:@[@(ConversationType_CUSTOMERSERVICE)]];
            //            if (count>0) {
            __weakSelf.tabBarItem.badgeValue = nil;
            //            }
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RCKitDispatchMessageNotification object:nil];
}

@end