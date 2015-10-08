//
//  RCDFriendInvitationTableViewController.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@interface RCDFriendInvitationTableViewController : UITableViewController

/**
 *  targetId
 */
@property(nonatomic, strong) NSString *targetId;
/**
 *  targetName
 */
@property(nonatomic, strong) NSString *userName;
/**
 *  conversationType
 */
@property(nonatomic) RCConversationType conversationType;
/**
 * model
 */
@property (strong,nonatomic) RCConversationModel *conversation;

@end