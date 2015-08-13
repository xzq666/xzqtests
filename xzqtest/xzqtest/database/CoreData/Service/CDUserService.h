//
//  CDUserService.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDUser.h"
#import "KCSingleton.h"
#import <CoreData/CoreData.h>

@interface CDUserService : NSObject
singleton_interface(CDUserService)

@property (nonatomic,strong) NSManagedObjectContext *context;

/**
 *  添加用户信息
 *
 *  @param user 用户对象
 */
-(void)addUser:(CDUser *)user;

/**
 *  添加用户
 *
 *  @param name            用户名
 *  @param screenName      用户昵称
 *  @param profileImageUrl 用户头像
 *  @param mbtype          会员类型
 *  @param city            用户所在城市
 */
-(void)addUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;

/**
 *  删除用户
 *
 *  @param user 用户对象
 */
-(void)removeUser:(CDUser *)user;

/**
 *  根据用户名删除用户
 *
 *  @param name 用户名
 */
-(void)removeUserByName:(NSString *)name;

/**
 *  修改用户内容
 *
 *  @param user 用户对象
 */
-(void)modifyUser:(CDUser *)user;

/**
 *  修改用户信息
 *
 *  @param name            用户名
 *  @param screenName      用户昵称
 *  @param profileImageUrl 用户头像
 *  @param mbtype          会员类型
 *  @param city            用户所在城市
 */
-(void)modifyUserWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;

/**
 *  根据用户名取得用户
 *
 *  @param name 用户名
 *
 *  @return 用户对象
 */
-(CDUser *)getUserByName:(NSString *)name;

-(NSArray *)getUsersByStatusText:(NSString *)text screenName:(NSString *)screenName;

@end