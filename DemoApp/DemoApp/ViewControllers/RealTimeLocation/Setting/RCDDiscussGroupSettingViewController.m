//
//  RCDDiscussGroupSettingViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDDiscussGroupSettingViewController.h"
#import "RCDUpdateNameViewController.h"
#import "RCDDiscussSettingCell.h"
#import "RCDDiscussSettingSwitchCell.h"
#import "RCDSelectPersonViewController.h"
#import "RCDChatViewController.h"
#import "RCDHttpTool.h"
#import "RCDRCIMDataSource.h"

@interface RCDDiscussGroupSettingViewController ()<UIActionSheetDelegate>

@property (nonatomic, copy) NSString* discussTitle;
@property (nonatomic, strong) NSArray* members;
@property (nonatomic)BOOL isOwner;

@end

@implementation RCDDiscussGroupSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示顶部视图
    self.headerHidden = NO;
    //添加当前聊天用户
    if (self.conversationType == ConversationType_PRIVATE) {
        [RCDHTTPTOOL getUserInfoByUserID:self.targetId
                              completion:^(RCUserInfo* user) {
                                  [self addUsers:@[user]];
                                  _members = @[user];
                                  
                              }];
    }
    
    //添加讨论组成员
    if (self.conversationType == ConversationType_DISCUSSION) {
        
        __weak RCDSettingBaseViewController* weakSelf = self;
        [[RCIMClient sharedRCIMClient] getDiscussion:self.targetId success:^(RCDiscussion* discussion) {
            if (discussion) {
                
                if([[RCIMClient sharedRCIMClient].currentUserInfo.userId isEqualToString:discussion.creatorId])
                {
                    [weakSelf disableDeleteMemberEvent:NO];
                    self.isOwner = YES;
                    
                }else{
                    [weakSelf disableDeleteMemberEvent:YES];
                    self.isOwner = NO;
                    if (discussion.inviteStatus == 1) {
                        [self disableInviteMemberEvent:YES];
                    }
                }
                
                NSMutableArray *users = [NSMutableArray new];
                
                for (NSString *targetId in discussion.memberIdList) {
                    [RCDHTTPTOOL getUserInfoByUserID:targetId
                                          completion:^(RCUserInfo *user) {
                                              [users addObject:user];
                                              _members = users;
                                              [weakSelf addUsers:users];
                                          }];
                    
                }
                
            }
        } error:^(RCErrorCode status){
            
        }];
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45)];
    
    UIImage *image =[UIImage imageNamed:@"group_quit"];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 42, 90/2)];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:@"删除并退出" forState:UIControlStateNormal];
    [button setCenter:CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2)];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    self.tableView.tableFooterView = view;
}

- (void)buttonAction:(UIButton*)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"删除并且退出讨论组" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

#pragma mark-UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([actionSheet isEqual:self.clearMsgHistoryActionSheet]) {
        [self clearHistoryMessage];
    } else {
        if (0 == buttonIndex) {
            __weak typeof(&*self)  weakSelf = self;
            [[RCIMClient sharedRCIMClient] quitDiscussion:self.targetId success:^(RCDiscussion *discussion) {
                NSLog(@"退出讨论组成功");
                UIViewController *temp = nil;
                NSArray *viewControllers = weakSelf.navigationController.viewControllers;
                temp = viewControllers[viewControllers.count -1 -2];
                if (temp) {
                    //切换主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popToViewController:temp animated:YES];
                    });
                }
            } error:^(RCErrorCode status) {
                NSLog(@"quit discussion status is %ld",(long)status);
                
            }];
        }
    }
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isOwner) {
        return self.defaultCells.count + 2;
    } else {
        return self.defaultCells.count + 1;
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44.f;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = nil;
    int offset = 2;
    if (!self.isOwner) {
        offset = 1;
    }
    switch (indexPath.row) {
        case 0:
        {
            RCDDiscussSettingCell *discussCell = [[RCDDiscussSettingCell alloc] initWithFrame:CGRectZero];
            discussCell.lblDiscussName.text = self.conversationTitle;
            discussCell.lblTitle.text = @"讨论组名称";
            cell = discussCell;
            _discussTitle = discussCell.lblDiscussName.text;
        }
            break;
        case 1:
        {
            if (self.isOwner) {
                RCDDiscussSettingSwitchCell *switchCell = [[RCDDiscussSettingSwitchCell alloc] initWithFrame:CGRectZero];
                switchCell.label.text = @"开放成员邀请";
                [[RCIMClient sharedRCIMClient] getDiscussion:self.targetId success:^(RCDiscussion *discussion) {
                    if (discussion.inviteStatus == 0) {
                        switchCell.swich.on = YES;
                    }
                } error:^(RCErrorCode status){
                    
                }];
                [switchCell.swich addTarget:self action:@selector(openMemberInv:) forControlEvents:UIControlEventTouchUpInside];
                cell = switchCell;
            } else {
                cell = self.defaultCells[0];
            }
            
            
        } break;
        case 2: {
            cell = self.defaultCells[indexPath.row - offset];
        } break;
        case 3: {
            cell = self.defaultCells[indexPath.row - offset];
            
        } break;
        case 4: {
            cell = self.defaultCells[indexPath.row - offset];
            
        } break;
    }
    
    return cell;
}

#pragma mark - RCConversationSettingTableViewHeader Delegate
//点击最后一个+号事件
- (void)settingTableViewHeader:(RCConversationSettingTableViewHeader*)settingTableViewHeader indexPathOfSelectedItem:(NSIndexPath*)indexPathOfSelectedItem
            allTheSeletedUsers:(NSArray*)users {
    //点击最后一个+号,调出选择联系人UI
    if (indexPathOfSelectedItem.row == settingTableViewHeader.users.count) {
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RCDSelectPersonViewController* selectPersonVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDSelectPersonViewController"];
        [selectPersonVC setSeletedUsers:users];
        //设置回调
        selectPersonVC.clickDoneCompletion = ^(RCDSelectPersonViewController* selectPersonViewController, NSArray* selectedUsers) {
            
            if (selectedUsers && selectedUsers.count) {
                
                NSString *_currentTargetId = [RCIMClient sharedRCIMClient].currentUserInfo.userId;
                
                [RCDHTTPTOOL getUserInfoByUserID:_currentTargetId completion:^(RCUserInfo *user) {
                    RCUserInfo *userInfo =  user;
                    NSMutableArray *_allUsers = [NSMutableArray new];
                    [_allUsers addObject:userInfo];//add current user info object
                    [_allUsers addObjectsFromArray:selectedUsers];//add the selected users
                    [self addUsers:(NSArray *)_allUsers];
                    
                    [self createDiscussionOrInvokeMemberWithSelectedUsers:selectedUsers];
                    
                }];
            }
            
            [selectPersonViewController.navigationController popViewControllerAnimated:YES];
        };
        [self.navigationController pushViewController:selectPersonVC animated:YES];
    }
}

#pragma mark - private method
- (void)createDiscussionOrInvokeMemberWithSelectedUsers:(NSArray*)selectedUsers {
    //    __weak RCDSettingViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (ConversationType_DISCUSSION == self.conversationType) {
            //invoke new member to current discussion
            
            NSMutableArray *addIdList = [NSMutableArray new];
            for (RCUserInfo *user in selectedUsers) {
                [addIdList addObject:user.userId];
            }
            //加入讨论组
            if(addIdList.count != 0){
                [[RCIMClient sharedRCIMClient] addMemberToDiscussion:self.targetId userIdList:addIdList success:^(RCDiscussion *discussion) {
                    NSLog(@"成功");
                } error:^(RCErrorCode status) {
                }];
            }
        } else if (ConversationType_PRIVATE == self.conversationType) {
            //create new discussion with the new invoked member.
            NSUInteger _count = [selectedUsers count];
            if (_count > 1) {
                
                NSMutableString *discussionTitle = [NSMutableString string];
                NSMutableArray *userIdList = [NSMutableArray new];
                for (int i=0; i<_count; i++) {
                    RCUserInfo *_userInfo = (RCUserInfo *)selectedUsers[i];
                    [discussionTitle appendString:[NSString stringWithFormat:@"%@%@", _userInfo.name,@","]];
                    
                    [userIdList addObject:_userInfo.userId];
                }
                [discussionTitle deleteCharactersInRange:NSMakeRange(discussionTitle.length - 1, 1)];
                self.conversationTitle = discussionTitle;
                
                __weak typeof(&*self)  weakSelf = self;
                [[RCIMClient sharedRCIMClient] createDiscussion:discussionTitle userIdList:userIdList success:^(RCDiscussion *discussion) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        RCDChatViewController *chat =[[RCDChatViewController alloc]init];
                        chat.targetId                      = discussion.discussionId;
                        chat.userName                    = discussion.discussionName;
                        chat.conversationType              = ConversationType_DISCUSSION;
                        chat.title                         = discussionTitle;//[NSString stringWithFormat:@"讨论组(%lu)", (unsigned long)_count];
                        
                        UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
                        [weakSelf.navigationController popToViewController:tabbarVC animated:NO];
                        [tabbarVC.navigationController  pushViewController:chat animated:YES];
                    });
                } error:^(RCErrorCode status) {
                    //            DebugLog(@"create discussion Failed > %ld!", (long)status);
                }];
            }
            
        }
    });
}

- (void)openMemberInv:(UISwitch*)swch {
    //设置成员邀请权限
    [[RCIMClient sharedRCIMClient] setDiscussionInviteStatus:self.targetId isOpen:swch.on success:^{
        //        DebugLog(@"设置成功");
    } error:^(RCErrorCode status) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.setDiscussTitleCompletion) {
        self.setDiscussTitleCompletion(_discussTitle);
    }
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row == 0) {
        RCDDiscussSettingCell* discussCell = (RCDDiscussSettingCell*)[tableView cellForRowAtIndexPath:indexPath];
        discussCell.lblTitle.text = @"讨论组名称";
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RCDUpdateNameViewController* updateNameViewController = [storyboard instantiateViewControllerWithIdentifier:@"RCDUpdateNameViewController"];
        updateNameViewController.targetId = self.targetId;
        updateNameViewController.displayText = discussCell.lblDiscussName.text;
        updateNameViewController.setDisplayTextCompletion = ^(NSString* text) {
            discussCell.lblDiscussName.text = text;
            _discussTitle = text;
            
        };
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:updateNameViewController];
        [self.navigationController presentViewController:navi animated:YES completion:nil];
    }
}

/**
 *  override
 *
 *  @param 添加顶部视图显示的user,必须继承以调用父类添加user
 */
- (void)addUsers:(NSArray*)users {
    [super addUsers:users];
}

/**
 *  override 左上角删除按钮回调
 *
 *  @param indexPath indexPath description
 */
- (void)deleteTipButtonClicked:(NSIndexPath*)indexPath {
    RCUserInfo* user = self.users[indexPath.row];
    if ([user.userId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
        return;
    }
    [[RCIMClient sharedRCIMClient] removeMemberFromDiscussion:self.targetId
                                                       userId:user.userId
                                                      success:^(RCDiscussion *discussion) {
                                                          NSLog(@"踢人成功");
                                                          [self.users removeObject:user];
                                                      } error:^(RCErrorCode status) {
                                                          NSLog(@"踢人失败");
                                                      }];
}



- (void)didTipHeaderClicked:(NSString*)userId {
    [[RCDRCIMDataSource shareInstance]getUserInfoWithUserId:userId completion:^(RCUserInfo *userInfo) {
         if (userInfo) {
             NSUInteger count = self.navigationController.viewControllers.count;
             if (count > 1) {
                 UIViewController *preVC =
                 self.navigationController.viewControllers[count - 2];
                 if ([preVC isKindOfClass:[RCConversationViewController class]]) {
                     [self.navigationController popViewControllerAnimated:YES];
                     return;
                 } else {
                     RCDChatViewController *_conversationVC = [[RCDChatViewController alloc]init];
                     _conversationVC.conversationType = ConversationType_PRIVATE;
                     _conversationVC.targetId = userId;
                     _conversationVC.userName=userInfo.name;
                     _conversationVC.title=userInfo.name;
                     [self.navigationController pushViewController:_conversationVC animated:YES];
                 }
             }else{
                 RCDChatViewController *_conversationVC = [[RCDChatViewController alloc]init];
                 _conversationVC.conversationType = ConversationType_PRIVATE;
                 _conversationVC.targetId = userId;
                 _conversationVC.userName=userInfo.name;
                 _conversationVC.title=userInfo.name;
                 [self.navigationController pushViewController:_conversationVC animated:YES];
             }
             
         }
         else
         {
             NSLog(@"无效的userInfo");
         }
     }];
}

@end