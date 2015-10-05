//
//  RCDHttpTool.m
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDHttpTool.h"
#import "AFHttpTool.h"
#import "RCDGroupInfo.h"
#import "RCDUserInfo.h"
#import "RCDRCIMDataSource.h"
#import "RCDataBaseManager.h"

@implementation RCDHttpTool

+ (RCDHttpTool*)shareInstance
{
    static RCDHttpTool* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        instance.allGroups = [NSMutableArray new];
    });
    return instance;
}

-(void) isMyFriendWithUserInfo:(RCDUserInfo *)userInfo
                    completion:(void(^)(BOOL isFriend)) completion
{
    [self getFriends:^(NSMutableArray *result) {
        for (RCDUserInfo *user in result) {
            if ([user.userId isEqualToString:userInfo.userId] && completion && [@"1" isEqualToString:user.status]) {
                if (completion) {
                    completion(YES);
                }
                return ;
            }
        }
        if(completion){
            completion(NO);
        }
    }];
}
//根据id获取单个群组
-(void) getGroupByID:(NSString *) groupID
   successCompletion:(void (^)(RCGroup *group)) completion
{
    RCGroup *groupInfo=[[RCDataBaseManager shareInstance] getGroupByGroupId:groupID];
    if(groupInfo==nil)
    {
        [AFHttpTool getAllGroupsSuccess:^(id response) {
            NSArray *allGroups = response[@"result"];
            if (allGroups) {
                for (NSDictionary *dic in allGroups) {
                    RCGroup *group = [[RCGroup alloc] init];
                    group.groupId = [dic objectForKey:@"id"];
                    group.groupName = [dic objectForKey:@"name"];
                    group.portraitUri = (NSNull *)[dic objectForKey:@"portrait"] == [NSNull null] ? nil: [dic objectForKey:@"portrait"];
                    if ([group.groupId isEqualToString:groupID] && completion) {
                        completion(group);
                    }
                }
                
            }
            
        } failure:^(NSError* err){
            
        }];
    }else{
        if (completion) {
            completion(groupInfo);
        }
        
    }
}
-(void) getUserInfoByUserID:(NSString *) userID
                 completion:(void (^)(RCUserInfo *user)) completion
{
    
    RCUserInfo *userInfo=[[RCDataBaseManager shareInstance] getUserByUserId:userID];
    if (userInfo==nil) {
        [AFHttpTool getUserById:userID success:^(id response) {
            if (response) {
                NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
                
                if ([code isEqualToString:@"200"]) {
                    
                    NSDictionary *dic = response[@"result"];
                    // NSLog(@"isMainThread > %d", [NSThread isMainThread]);
                    RCUserInfo *user = [RCUserInfo new];
                    NSNumber *idNum = [dic objectForKey:@"id"];
                    user.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                    user.portraitUri = [dic objectForKey:@"portrait"];
                    user.name = [dic objectForKey:@"username"];
                    [[RCDataBaseManager shareInstance] insertUserToDB:user];
                    
                    if (completion) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(user);
                        });
                    }
                    
                    
                }
                else
                {
                    RCUserInfo *user = [RCUserInfo new];
                    
                    user.userId = userID;
                    user.portraitUri = @"";
                    user.name = [NSString stringWithFormat:@"name%@", userID];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(user);
                    });
                }
                
            }
            
        } failure:^(NSError *err) {
            NSLog(@"getUserInfoByUserID error");
            if (completion) {
                @try {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        RCUserInfo *user = [RCUserInfo new];
                        
                        user.userId = userID;
                        user.portraitUri = @"";
                        user.name = [NSString stringWithFormat:@"name%@", userID];
                        
                        completion(user);
                    });
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
            }
        }];
        
    }else
    {
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(userInfo);
            });
        }
        
    }
    //    __block NSArray * regDataArray;
    //    [AFHttpTool getFriendsSuccess:^(id response) {
    //        if (response) {
    //            NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
    //
    //            if ([code isEqualToString:@"200"]) {
    //
    //                regDataArray = response[@"result"];
    //               // NSLog(@"isMainThread > %d", [NSThread isMainThread]);
    //
    //                dispatch_group_leave(groupQueue);
    //
    //            }
    //
    //        }
    //
    //    } failure:^(NSError *err) {
    //        NSLog(@"getUserInfoByUserID error");
    //    }];
    //
    //    dispatch_group_notify(groupQueue, dispatch_get_main_queue(), ^{
    //
    //        dispatch_queue_t queue = dispatch_queue_create("handleResponseData.friends", DISPATCH_QUEUE_SERIAL);
    //
    //        dispatch_async(queue, ^{
    //
    //            for(int i = 0;i < regDataArray.count;i++){
    //                NSDictionary *dic = [regDataArray objectAtIndex:i];
    //                //NSLog(@"userID > %@, id > %@, i > %d", userID, [dic objectForKey:@"id"], i);
    //                if ([userID isEqualToString:[dic objectForKey:@"id"]]) {
    //                   // NSLog(@"Matched i > %d, dic>%@", i, dic);
    //                    RCUserInfo *userInfo = [RCUserInfo new];
    //                    NSNumber *idNum = [dic objectForKey:@"id"];
    //                    userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
    //                    userInfo.portraitUri = [dic objectForKey:@"portrait"];
    //                    userInfo.name = [dic objectForKey:@"username"];
    //                    [[RCDataBaseManager shareInstance] insertUserToDB:userInfo];
    //
    //                    if (completion) {
    //                        dispatch_async(dispatch_get_main_queue(), ^{
    //                            completion(userInfo);
    //                        });
    //                    }
    //
    //                }
    ////                }else{
    ////                    NSLog(@"no matched userid > %d", i);
    ////                }
    //            }
    //        });
    //    });
    //
}


- (void)getAllGroupsWithCompletion:(void (^)(NSMutableArray* result))completion
{
    
    [AFHttpTool getAllGroupsSuccess:^(id response) {
        NSMutableArray *tempArr = [NSMutableArray new];
        NSArray *allGroups = response[@"result"];
        if (allGroups) {
            [[RCDataBaseManager shareInstance] clearGroupsData];
            for (NSDictionary *dic in allGroups) {
                RCDGroupInfo *group = [[RCDGroupInfo alloc] init];
                group.groupId = [dic objectForKey:@"id"];
                group.groupName = [dic objectForKey:@"name"];
                group.portraitUri = [dic objectForKey:@"portrait"];
                if (group.portraitUri) {
                    group.portraitUri=@"";
                }
                group.creatorId = [dic objectForKey:@"create_user_id"];
                group.introduce = [dic objectForKey:@"introduce"];
                if (group.introduce) {
                    group.introduce=@"";
                }
                group.number = [dic objectForKey:@"number"];
                group.maxNumber = [dic objectForKey:@"max_number"];
                group.creatorTime = [dic objectForKey:@"creat_datetime"];
                [[RCDataBaseManager shareInstance] insertGroupToDB:group];
                [tempArr addObject:group];
            }
            
            //获取加入状态
            [self getMyGroupsWithBlock:^(NSMutableArray *result) {
                for (RCDGroupInfo *group in result) {
                    for (RCDGroupInfo *groupInfo in tempArr) {
                        if ([group.groupId isEqualToString:groupInfo.groupId]) {
                            groupInfo.isJoin = YES;
                            [[RCDataBaseManager shareInstance] insertGroupToDB:groupInfo];
                        }
                        
                    }
                }
                if (completion) {
                    [_allGroups removeAllObjects];
                    [_allGroups addObjectsFromArray:tempArr];
                    
                    completion(tempArr);
                }
                
            }];
        }
        
    } failure:^(NSError* err){
        NSMutableArray *cacheGroups=[[NSMutableArray alloc]initWithArray:[[RCDataBaseManager shareInstance] getAllGroup]];
        completion(cacheGroups);
    }];
}


-(void) getMyGroupsWithBlock:(void(^)(NSMutableArray* result)) block
{
    [AFHttpTool getMyGroupsSuccess:^(id response) {
        NSArray *allGroups = response[@"result"];
        NSMutableArray *tempArr = [NSMutableArray new];
        if (allGroups) {
            for (NSDictionary *dic in allGroups) {
                RCDGroupInfo *group = [[RCDGroupInfo alloc] init];
                group.groupId = [dic objectForKey:@"id"];
                group.groupName = [dic objectForKey:@"name"];
                group.portraitUri = [dic objectForKey:@"portrait"];
                if (group.portraitUri) {
                    group.portraitUri=@"";
                }
                group.creatorId = [dic objectForKey:@"create_user_id"];
                group.introduce = [dic objectForKey:@"introduce"];
                if (group.introduce) {
                    group.introduce=@"";
                }
                group.number = [dic objectForKey:@"number"];
                group.maxNumber = [dic objectForKey:@"max_number"];
                group.creatorTime = [dic objectForKey:@"creat_datetime"];
                [tempArr addObject:group];
                //[_allGroups addObject:group];
            }
            
            if (block) {
                block(tempArr);
            }
        }
        
    } failure:^(NSError *err) {
        
    }];
}

- (void)joinGroup:(int)groupID complete:(void (^)(BOOL))joinResult
{
    [AFHttpTool joinGroupByID:groupID success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if (joinResult) {
            if ([code isEqualToString:@"200"]) {
                //                [[RCIMClient sharedRCIMClient]joinGroup:[NSString stringWithFormat:@"%d",groupID] groupName:@"" success:^{
                for (RCDGroupInfo *group in _allGroups) {
                    if ([group.groupId isEqualToString:[NSString stringWithFormat:@"%d",groupID]]) {
                        group.isJoin=YES;
                        [[RCDataBaseManager shareInstance] insertGroupToDB:group];
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    joinResult(YES);
                });
                
                //                } error:^(RCErrorCode status) {
                //                    joinResult(NO);
                //                }];
                
            }else{
                joinResult(NO);
            }
            
        }
    } failure:^(id response) {
        if (joinResult) {
            joinResult(NO);
        }
    }];
}

- (void)quitGroup:(int)groupID complete:(void (^)(BOOL))result
{
    [AFHttpTool quitGroupByID:groupID success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                //                [[RCIMClient sharedRCIMClient] quitGroup:[NSString stringWithFormat:@"%d",groupID] success:^{
                result(YES);
                for (RCDGroupInfo *group in _allGroups) {
                    if ([group.groupId isEqualToString:[NSString stringWithFormat:@"%d",groupID]]) {
                        group.isJoin=NO;
                        [[RCDataBaseManager shareInstance] insertGroupToDB:group];
                    }
                }
                //                } error:^(RCErrorCode status) {
                //                    result(NO);
                //                }];
            }else{
                result(NO);
            }
            
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}

- (void)updateGroupById:(int)groupID withGroupName:(NSString*)groupName andintroduce:(NSString*)introduce complete:(void (^)(BOOL))result

{
    __block typeof(id) weakGroupId = [NSString stringWithFormat:@"%d", groupID];
    [AFHttpTool updateGroupByID:groupID withGroupName:groupName andGroupIntroduce:introduce success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                
                for (RCDGroupInfo *group in _allGroups) {
                    if ([group.groupId isEqualToString:weakGroupId]) {
                        group.groupName=groupName;
                        group.introduce=introduce;
                    }
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    result(YES);
                });
                
            }else{
                result(NO);
            }
            
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}

- (void)getFriends:(void (^)(NSMutableArray*))friendList
{
    NSMutableArray* list = [NSMutableArray new];
    
    [AFHttpTool getFriendListFromServerSuccess:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        if (friendList) {
            if ([code isEqualToString:@"200"]) {
                [_allFriends removeAllObjects];
                NSArray * regDataArray = response[@"result"];
                [[RCDataBaseManager shareInstance] clearFriendsData];
                for(int i = 0;i < regDataArray.count;i++){
                    NSDictionary *dic = [regDataArray objectAtIndex:i];
                    if([[dic objectForKey:@"status"] intValue] != 1)
                        continue;
                    
                    RCDUserInfo*userInfo = [RCDUserInfo new];
                    NSNumber *idNum = [dic objectForKey:@"id"];
                    userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                    userInfo.portraitUri = [dic objectForKey:@"portrait"];
                    userInfo.name = [dic objectForKey:@"username"];
                    userInfo.email = [dic objectForKey:@"email"];
                    userInfo.status = [dic objectForKey:@"status"];
                    [list addObject:userInfo];
                    [_allFriends addObject:userInfo];
                    RCUserInfo *user = [RCUserInfo new];
                    user.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                    user.portraitUri = [dic objectForKey:@"portrait"];
                    user.name = [dic objectForKey:@"username"];
                    [[RCDataBaseManager shareInstance] insertUserToDB:user];
                    [[RCDataBaseManager shareInstance] insertFriendToDB:user];
                }
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    friendList(list);
                });
                
            }else{
                friendList(list);
            }
            
        }
    } failure:^(id response) {
        if (friendList) {
            NSMutableArray *cacheList=[[NSMutableArray alloc]initWithArray:[[RCDataBaseManager shareInstance] getAllFriends]];
            friendList(cacheList);
        }
    }];
}

- (void)searchFriendListByEmail:(NSString*)email complete:(void (^)(NSMutableArray*))friendList
{
    NSMutableArray* list = [NSMutableArray new];
    [AFHttpTool searchFriendListByEmail:email success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (friendList) {
            if ([code isEqualToString:@"200"]) {
                
                id result = response[@"result"];
                if([result respondsToSelector:@selector(intValue)]) return ;
                if([result respondsToSelector:@selector(objectForKey:)])
                {
                    RCDUserInfo*userInfo = [RCDUserInfo new];
                    NSNumber *idNum = [result objectForKey:@"id"];
                    userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                    userInfo.portraitUri = [result objectForKey:@"portrait"];
                    userInfo.name = [result objectForKey:@"username"];
                    [list addObject:userInfo];
                    
                }
                else
                {
                    NSArray * regDataArray = response[@"result"];
                    
                    for(int i = 0;i < regDataArray.count;i++){
                        
                        NSDictionary *dic = [regDataArray objectAtIndex:i];
                        RCDUserInfo*userInfo = [RCDUserInfo new];
                        NSNumber *idNum = [dic objectForKey:@"id"];
                        userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                        userInfo.portraitUri = [dic objectForKey:@"portrait"];
                        userInfo.name = [dic objectForKey:@"username"];
                        [list addObject:userInfo];
                    }
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    friendList(list);
                });
                
            }else{
                friendList(list);
            }
            
        }
    } failure:^(id response) {
        if (friendList) {
            friendList(list);
        }
    }];
}

- (void)searchFriendListByName:(NSString*)name complete:(void (^)(NSMutableArray*))friendList
{
    NSMutableArray* list = [NSMutableArray new];
    [AFHttpTool searchFriendListByName:name success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (friendList) {
            if ([code isEqualToString:@"200"]) {
                
                NSArray * regDataArray = response[@"result"];
                for(int i = 0;i < regDataArray.count;i++){
                    
                    NSDictionary *dic = [regDataArray objectAtIndex:i];
                    RCDUserInfo*userInfo = [RCDUserInfo new];
                    NSNumber *idNum = [dic objectForKey:@"id"];
                    userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                    userInfo.portraitUri = [dic objectForKey:@"portrait"];
                    userInfo.name = [dic objectForKey:@"username"];
                    [list addObject:userInfo];
                }
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    friendList(list);
                });
                
            }else{
                friendList(list);
            }
            
        }
    } failure:^(id response) {
        if (friendList) {
            friendList(list);
        }
    }];
}
- (void)requestFriend:(NSString*)userId complete:(void (^)(BOOL))result
{
    [AFHttpTool requestFriend:userId success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    result(YES);
                });
                
            }else{
                result(NO);
            }
            
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}
- (void)processRequestFriend:(NSString*)userId withIsAccess:(BOOL)isAccess complete:(void (^)(BOOL))result
{
    [AFHttpTool processRequestFriend:userId withIsAccess:isAccess success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    result(YES);
                });
                
            }else{
                result(NO);
            }
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}

- (void)deleteFriend:(NSString*)userId complete:(void (^)(BOOL))result
{
    [AFHttpTool deleteFriend:userId success:^(id response) {
        NSString *code = [NSString stringWithFormat:@"%@",response[@"code"]];
        
        if (result) {
            if ([code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    result(YES);
                });
                [[RCDataBaseManager shareInstance]deleteFriendFromDB:userId];
                
            }else{
                result(NO);
            }
            
        }
    } failure:^(id response) {
        if (result) {
            result(NO);
        }
    }];
}

@end