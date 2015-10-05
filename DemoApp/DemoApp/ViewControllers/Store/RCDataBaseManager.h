//
//  RCDataBaseManager.h
//  RCloudMessage
//
//  Created by 杜立召 on 15/6/3.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>


@interface RCDataBaseManager : NSObject

+ (RCDataBaseManager*)shareInstance;

//存储用户信息
-(void)insertUserToDB:(RCUserInfo*)user;

//插入黑名单列表
-(void)insertBlackListToDB:(RCUserInfo*)user;

//获取黑名单列表
- (NSArray *)getBlackList;

//移除黑名单
- (void)removeBlackList:(NSString *)userId;

//清空黑名单缓存信息
-(void)clearBlackListData;

//从表中获取用户信息
-(RCUserInfo*) getUserByUserId:(NSString*)userId;

//从表中获取所有用户信息
-(NSArray *) getAllUserInfo;

//存储群组信息
-(void)insertGroupToDB:(RCGroup *)group;

//从表中获取群组信息
-(RCGroup*) getGroupByGroupId:(NSString*)groupId;

//从表中获取所有群组信息
-(NSArray *) getAllGroup;

//存储好友信息
-(void)insertFriendToDB:(RCUserInfo *)friend;


//清空群组缓存数据
-(void)clearGroupsData;

//清空好友缓存数据
-(void)clearFriendsData;

//从表中获取所有好友信息 //RCUserInfo
-(NSArray *) getAllFriends;

//删除好友信息
-(void)deleteFriendFromDB:(NSString *)userId;

@end