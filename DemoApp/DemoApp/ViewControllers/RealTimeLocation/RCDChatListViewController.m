//
//  RCDChatListViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDChatListViewController.h"
#import "KxMenu.h"
#import "RCDAddressBookViewController.h"
#import "RCDSearchFriendViewController.h"
#import "RCDSelectPersonViewController.h"
#import "RCDRCIMDataSource.h"
#import "RCDChatViewController.h"
#import "UIColor+RCColor.h"
#import "RCDChatListCell.h"
#import "RCDHttpTool.h"
#import "UIImageView+WebCache.h"
#import <RongIMKit/RongIMKit.h>
#import "RCDUserInfo.h"
#import "RCDFriendInvitationTableViewController.h"
#import "RCPublicServiceChatViewController.h"

@interface RCDChatListViewController ()

@property (nonatomic,strong) NSMutableArray *myDataSource;
@property (nonatomic,strong) RCConversationModel *tempModel;

- (void) updateBadgeValueForTabBarItem;

@end

@implementation RCDChatListViewController

/**
 *  此处使用storyboard初始化，代码初始化当前类时*****必须要设置会话类型和聚合类型*****
 *
 *  @param aDecoder aDecoder description
 *
 *  @return return value description
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    self =[super initWithCoder:aDecoder];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE), @(ConversationType_PUBLICSERVICE),@(ConversationType_GROUP),@(ConversationType_SYSTEM)]];
        
        //聚合会话类型
        [self setCollectionConversationType:@[@(ConversationType_GROUP),@(ConversationType_DISCUSSION)]];
        
        //设置为不用默认渲染方式
        self.tabBarItem.image = [[UIImage imageNamed:@"icon_chat"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_chat_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // _myDataSource = [NSMutableArray new];
        
        // [self setConversationAvatarStyle:RCUserAvatarCycle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置tableView样式
    self.conversationListTableView.separatorColor = [UIColor colorWithHexString:@"dfdfdf" alpha:1.0f];
    self.conversationListTableView.tableFooterView = [UIView new];
    self.conversationListTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 12)];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavigationItemTitleView];
    
    //自定义rightBarButtonItem
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn setTintColor:[UIColor whiteColor]];
    self.tabBarController.navigationItem.rightBarButtonItem = rightButton;
    [self notifyUpdateUnreadMessageCount];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(receiveNeedRefreshNotification:)
                                                name:@"kRCNeedReloadDiscussionListNotification"
                                              object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //showConnectingStatusOnNavigatorBar设置为YES时，需要重写setNavigationItemTitleView函数来显示已连接时的标题。
    self.showConnectingStatusOnNavigatorBar = YES;
    [super updateConnectionStatusOnNavigatorBar];
}

//由于demo使用了tabbarcontroller，当切换到其它tab时，不能更改tabbarcontroller的标题。
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.showConnectingStatusOnNavigatorBar = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"kRCNeedReloadDiscussionListNotification"
                                                  object:nil];
}

- (void)setNavigationItemTitleView {
    if (self.isEnteredToCollectionViewController) {
        return;
    }
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor whiteColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"会话";
    self.tabBarController.navigationItem.titleView = titleView;
}

- (void)updateBadgeValueForTabBarItem {
    __weak typeof(self) __weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        int count = [[RCIMClient sharedRCIMClient]getUnreadCount:self.displayConversationTypeArray];
        if (count>0) {
            __weakSelf.tabBarItem.badgeValue = [[NSString alloc]initWithFormat:@"%d",count];
        } else {
            __weakSelf.tabBarItem.badgeValue = nil;
        }
    });
}

/**
 *  点击进入会话界面
 *
 *  @param conversationModelType 会话类型
 *  @param model                 会话数据
 *  @param indexPath             indexPath description
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    if (model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_PUBLIC_SERVICE) {
        RCPublicServiceChatViewController *_conversationVC = [[RCPublicServiceChatViewController alloc] init];
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        _conversationVC.userName = model.conversationTitle;
        _conversationVC.title = model.conversationTitle;
        [self.navigationController pushViewController:_conversationVC animated:YES];
    }
    
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_NORMAL) {
        RCDChatViewController *_conversationVC = [[RCDChatViewController alloc]init];
        _conversationVC.conversationType = model.conversationType;
        _conversationVC.targetId = model.targetId;
        _conversationVC.userName = model.conversationTitle;
        _conversationVC.title = model.conversationTitle;
        _conversationVC.conversation = model;
        _conversationVC.unReadMessage = model.unreadMessageCount;
        _conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
        _conversationVC.enableUnreadMessageIcon=YES;
        [self.navigationController pushViewController:_conversationVC animated:YES];
    }
    //聚合会话类型，此处自定设置。
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        RCDChatListViewController *temp = [[RCDChatListViewController alloc] init];
        NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
        [temp setDisplayConversationTypes:array];
        [temp setCollectionConversationType:nil];
        temp.isEnteredToCollectionViewController = YES;
        [self.navigationController pushViewController:temp animated:YES];
    }
    //自定义会话类型
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION) {
        RCConversationModel *model = self.conversationListDataSource[indexPath.row];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RCDFriendInvitationTableViewController *temp = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDFriendInvitationTableViewController"];
        temp.conversationType = model.conversationType;
        temp.targetId = model.targetId;
        temp.userName = model.conversationTitle;
        temp.title = model.conversationTitle;
        temp.conversation = model;
        [self.navigationController pushViewController:temp animated:YES];
    }
}

/**
 *  弹出层
 *
 *  @param sender sender description
 */
- (IBAction)showMenu:(UIButton *)sender {
    NSLog(@"menu");
    NSArray *menuItems = @[
      [KxMenuItem menuItem:@"发起聊天"
                     image:[UIImage imageNamed:@"chat_icon"]
                    target:self
                    action:@selector(pushChat:)],
      
      [KxMenuItem menuItem:@"添加好友"
                     image:[UIImage imageNamed:@"addfriend_icon"]
                    target:self
                    action:@selector(pushAddFriend:)],
      
      [KxMenuItem menuItem:@"通讯录"
                     image:[UIImage imageNamed:@"contact_icon"]
                    target:self
                    action:@selector(pushAddressBook:)],
      
      [KxMenuItem menuItem:@"公众账号"
                     image:[UIImage imageNamed:@"public_account"]
                    target:self
                    action:@selector(pushPublicService:)],
      
      [KxMenuItem menuItem:@"添加公众号"
                     image:[UIImage imageNamed:@"add_public_account"]
                    target:self
                    action:@selector(pushAddPublicService:)],
      ];
    
    CGRect targetFrame = self.tabBarController.navigationItem.rightBarButtonItem.customView.frame;
    targetFrame.origin.y = targetFrame.origin.y + 15;
    [KxMenu showMenuInView:self.tabBarController.navigationController.navigationBar.superview
                  fromRect:targetFrame
                 menuItems:menuItems];
}

/**
 *  发起聊天
 *
 *  @param sender sender description
 */
- (void) pushChat:(id)sender {
    NSLog(@"发起聊天");
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RCDSelectPersonViewController *selectPersonVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDSelectPersonViewController"];
    
    //设置点击确定之后回传被选择联系人操作
    __weak typeof(&*self)  weakSelf = self;
    selectPersonVC.clickDoneCompletion = ^(RCDSelectPersonViewController *selectPersonViewController,NSArray *selectedUsers){
        if(selectedUsers.count == 1)
        {
            RCUserInfo *user = selectedUsers[0];
            RCDChatViewController *chat =[[RCDChatViewController alloc]init];
            chat.targetId                      = user.userId;
            chat.userName                    = user.name;
            chat.conversationType              = ConversationType_PRIVATE;
            chat.title                         = user.name;
            
            //跳转到会话页面
            dispatch_async(dispatch_get_main_queue(), ^{
                UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
                [weakSelf.navigationController popToViewController:tabbarVC animated:NO];
                [tabbarVC.navigationController  pushViewController:chat animated:YES];
            });
            
        }
        //选择多人则创建讨论组
        else if(selectedUsers.count > 1) {
            NSMutableString *discussionTitle = [NSMutableString string];
            NSMutableArray *userIdList = [NSMutableArray new];
            for (RCUserInfo *user in selectedUsers) {
                [discussionTitle appendString:[NSString stringWithFormat:@"%@%@", user.name,@","]];
                [userIdList addObject:user.userId];
            }
            [discussionTitle deleteCharactersInRange:NSMakeRange(discussionTitle.length - 1, 1)];
            
            [[RCIMClient sharedRCIMClient] createDiscussion:discussionTitle userIdList:userIdList success:^(RCDiscussion *discussion) {
                NSLog(@"create discussion ssucceed!");
                dispatch_async(dispatch_get_main_queue(), ^{
                    RCDChatViewController *chat =[[RCDChatViewController alloc]init];
                    chat.targetId                      = discussion.discussionId;
                    chat.userName                    = discussion.discussionName;
                    chat.conversationType              = ConversationType_DISCUSSION;
                    chat.title                         = @"讨论组";
                    UITabBarController *tabbarVC = weakSelf.navigationController.viewControllers[0];
                    [weakSelf.navigationController popViewControllerAnimated:NO];
                    [tabbarVC.navigationController  pushViewController:chat animated:YES];
                });
            } error:^(RCErrorCode status) {
                NSLog(@"create discussion Failed > %ld!", (long)status);
            }];
            return;
        }
    };
    [self.navigationController pushViewController :selectPersonVC animated:YES];
}

/**
 *  公众号会话
 *
 *  @param sender sender description
 */
- (void) pushPublicService:(id) sender {
    RCPublicServiceListViewController *publicServiceVC = [[RCPublicServiceListViewController alloc] init];
    [self.navigationController pushViewController:publicServiceVC  animated:YES];
}

/**
 *  添加好友
 *
 *  @param sender sender description
 */
- (void) pushAddFriend:(id) sender {
    RCDSearchFriendViewController *searchFirendVC = [RCDSearchFriendViewController searchFriendViewController];
    [self.navigationController pushViewController:searchFirendVC  animated:YES];
}

/**
 *  通讯录
 *
 *  @param sender sender description
 */
-(void) pushAddressBook:(id) sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RCDAddressBookViewController *addressBookVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDAddressBookViewController"];
    [self.navigationController pushViewController:addressBookVC animated:YES];
}

/**
 *  添加公众号
 *
 *  @param sender sender description
 */
- (void) pushAddPublicService:(id) sender {
    RCPublicServiceSearchViewController *searchFirendVC = [[RCPublicServiceSearchViewController alloc] init];
    [self.navigationController pushViewController:searchFirendVC  animated:YES];
}

//*********************插入自定义Cell*********************//
//插入自定义会话model
-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource {
    for (int i=0; i<dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        //筛选请求添加好友的系统消息，用于生成自定义会话类型的cell
        if(model.conversationType == ConversationType_SYSTEM && [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]]) {
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
    }
    return dataSource;
}

//左滑删除
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}

//高度
-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67.0f;
}

//自定义cell
-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    __block NSString *userName    = nil;
    __block NSString *portraitUri = nil;
    __weak RCDChatListViewController *weakSelf = self;
    //此处需要添加根据userid来获取用户信息的逻辑，extend字段不存在于DB中，当数据来自db时没有extend字段内容，只有userid
    if (nil == model.extend) {
        // Not finished yet, To Be Continue...
        if(model.conversationType == ConversationType_SYSTEM && [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]])
        {
            RCContactNotificationMessage *_contactNotificationMsg = (RCContactNotificationMessage *)model.lastestMessage;
            if (_contactNotificationMsg.sourceUserId == nil) {
                RCDChatListCell *cell = [[RCDChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
                cell.lblDetail.text = @"好友请求";
                [cell.ivAva sd_setImageWithURL:[NSURL URLWithString:portraitUri] placeholderImage:[UIImage imageNamed:@"system_notice"]];
                return cell;
                
            }
            NSDictionary *_cache_userinfo = [[NSUserDefaults standardUserDefaults]objectForKey:_contactNotificationMsg.sourceUserId];
            if (_cache_userinfo) {
                userName = _cache_userinfo[@"username"];
                portraitUri = _cache_userinfo[@"portraitUri"];
            } else {
                NSDictionary *emptyDic = @{};
                [[NSUserDefaults standardUserDefaults]setObject:emptyDic forKey:_contactNotificationMsg.sourceUserId];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [RCDHTTPTOOL getUserInfoByUserID:_contactNotificationMsg.sourceUserId
                                      completion:^(RCUserInfo *user) {
                                          if (user == nil) {
                                              return;
                                          }
                                          RCDUserInfo *rcduserinfo_ = [RCDUserInfo new];
                                          rcduserinfo_.name = user.name;
                                          rcduserinfo_.userId = user.userId;
                                          rcduserinfo_.portraitUri = user.portraitUri;
                                          
                                          model.extend = rcduserinfo_;
                                          
                                          //local cache for userInfo
                                          NSDictionary *userinfoDic = @{@"username": rcduserinfo_.name,
                                                                        @"portraitUri":rcduserinfo_.portraitUri
                                                                        };
                                          [[NSUserDefaults standardUserDefaults]setObject:userinfoDic forKey:_contactNotificationMsg.sourceUserId];
                                          [[NSUserDefaults standardUserDefaults]synchronize];
                                          
                                          [weakSelf.conversationListTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                      }];
            }
        }
    } else {
        RCDUserInfo *user = (RCDUserInfo *)model.extend;
        userName    = user.name;
        portraitUri = user.portraitUri;
    }
    RCDChatListCell *cell = [[RCDChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.lblDetail.text =[NSString stringWithFormat:@"来自%@的好友请求",userName];
    [cell.ivAva sd_setImageWithURL:[NSURL URLWithString:portraitUri] placeholderImage:[UIImage imageNamed:@"system_notice"]];
    cell.labelTime.text = [self ConvertMessageTime:model.sentTime / 1000];
    return cell;
}

#pragma mark - private
- (NSString *)ConvertMessageTime:(long long)secs {
    NSString *timeText = nil;
    NSDate *messageDate = [NSDate dateWithTimeIntervalSince1970:secs];
    //    DebugLog(@"messageDate==>%@",messageDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strMsgDay = [formatter stringFromDate:messageDate];
    NSDate *now = [NSDate date];
    NSString *strToday = [formatter stringFromDate:now];
    NSDate *yesterday = [[NSDate alloc] initWithTimeIntervalSinceNow:-(24 * 60 * 60)];
    NSString *strYesterday = [formatter stringFromDate:yesterday];
    NSString *_yesterday = nil;
    if ([strMsgDay isEqualToString:strToday]) {
        [formatter setDateFormat:@"HH':'mm"];
    } else if ([strMsgDay isEqualToString:strYesterday]) {
        _yesterday = NSLocalizedStringFromTable(@"Yesterday", @"RongCloudKit", nil);
        //[formatter setDateFormat:@"HH:mm"];
    }
    if (nil != _yesterday) {
        timeText = _yesterday; //[_yesterday stringByAppendingFormat:@" %@", timeText];
    } else {
        timeText = [formatter stringFromDate:messageDate];
    }
    return timeText;
}

//*********************插入自定义Cell*********************//
#pragma mark - 收到消息监听
-(void)didReceiveMessageNotification:(NSNotification *)notification {
    __weak typeof(&*self) blockSelf_ = self;
    //处理好友请求
    RCMessage *message = notification.object;
    if ([message.content isMemberOfClass:[RCContactNotificationMessage class]]) {
        
        if (message.conversationType != ConversationType_SYSTEM) {
            NSLog(@"好友消息要发系统消息！！！");
#if DEBUG
            @throw  [[NSException alloc] initWithName:@"error" reason:@"好友消息要发系统消息！！！" userInfo:nil];
#endif
        }
        RCContactNotificationMessage *_contactNotificationMsg = (RCContactNotificationMessage *)message.content;
        if (_contactNotificationMsg.sourceUserId == nil || _contactNotificationMsg.sourceUserId .length ==0) {
            return;
        }
        //该接口需要替换为从消息体获取好友请求的用户信息
        [RCDHTTPTOOL getUserInfoByUserID:_contactNotificationMsg.sourceUserId
                              completion:^(RCUserInfo *user) {
                                  RCDUserInfo *rcduserinfo_ = [RCDUserInfo new];
                                  rcduserinfo_.name = user.name;
                                  rcduserinfo_.userId = user.userId;
                                  rcduserinfo_.portraitUri = user.portraitUri;
                                  
                                  RCConversationModel *customModel = [RCConversationModel new];
                                  customModel.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
                                  customModel.extend = rcduserinfo_;
                                  customModel.senderUserId = message.senderUserId;
                                  customModel.lastestMessage = _contactNotificationMsg;
                                  //[_myDataSource insertObject:customModel atIndex:0];
                                  
                                  //local cache for userInfo
                                  NSDictionary *userinfoDic = @{@"username": rcduserinfo_.name,
                                                                @"portraitUri":rcduserinfo_.portraitUri
                                                                };
                                  [[NSUserDefaults standardUserDefaults]setObject:userinfoDic forKey:_contactNotificationMsg.sourceUserId];
                                  [[NSUserDefaults standardUserDefaults]synchronize];
                                  
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      //调用父类刷新未读消息数
                                      [blockSelf_ refreshConversationTableViewWithConversationModel:customModel];
                                      //[super didReceiveMessageNotification:notification];
                                      [blockSelf_ resetConversationListBackgroundViewIfNeeded];
                                      [self notifyUpdateUnreadMessageCount];
                                      
                                      //当消息为RCContactNotificationMessage时，没有调用super，如果是最后一条消息，可能需要刷新一下整个列表。
                                      //原因请查看super didReceiveMessageNotification的注释。
                                      NSNumber *left = [notification.userInfo objectForKey:@"left"];
                                      if (0 == left.integerValue) {
                                          [super refreshConversationTableViewIfNeeded];
                                      }
                                  });
                              }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用父类刷新未读消息数
            [super didReceiveMessageNotification:notification];
            [blockSelf_ resetConversationListBackgroundViewIfNeeded];
            //            [self notifyUpdateUnreadMessageCount]; super会调用notifyUpdateUnreadMessageCount
        });
    }
}

-(void)didTapCellPortrait:(RCConversationModel *)model {
    
}

- (void)notifyUpdateUnreadMessageCount {
    [self updateBadgeValueForTabBarItem];
}

- (void)receiveNeedRefreshNotification:(NSNotification *)status {
    __weak typeof(&*self) __blockSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (__blockSelf.displayConversationTypeArray.count == 1 && [self.displayConversationTypeArray[0] integerValue]== ConversationType_DISCUSSION) {
            [__blockSelf refreshConversationTableViewIfNeeded];
        }
        
    });
}

@end