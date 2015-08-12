//
//  KCUserService.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCUser.h"
#import "KCSingleton.h"

/**
 服务类，进行数据的增、删、改、查操作，由于服务类方法同样不需要过多的配置，因此定义为单例，保证程序中只有一个实例即可。服务类中调用前面封装的数据库方法将对数据库的操作转换为对模型的操作。
 */

@interface KCUserService : NSObject

singleton_interface(KCUserService)

/**
 *  添加用户信息
 *
 *  @param user 用户对象
 */
-(void)addUser:(KCUser *)user;

/**
 *  删除用户
 *
 *  @param user 用户对象
 */
-(void)removeUser:(KCUser *)user;

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
-(void)modifyUser:(KCUser *)user;

/**
 *  根据用户编号取得用户
 *
 *  @param Id 用户编号
 *
 *  @return 用户对象
 */
-(KCUser *)getUserById:(int)Id;

/**
 *  根据用户名取得用户
 *
 *  @param name 用户名
 *
 *  @return 用户对象
 */
-(KCUser *)getUserByName:(NSString *)name;

@end