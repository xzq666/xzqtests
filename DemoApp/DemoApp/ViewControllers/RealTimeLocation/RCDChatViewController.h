//
//  RCDChatViewController.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface RCDChatViewController : RCConversationViewController

/**
 *  会话数据模型
 */
@property (strong,nonatomic) RCConversationModel *conversation;

@end