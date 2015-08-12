//
//  KCStatus.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCUser.h"

@interface KCStatus : NSObject

#pragma mark - 属性
@property (nonatomic,strong) NSNumber *Id;//微博id
@property (nonatomic,strong) KCUser *user;//发送用户
@property (nonatomic,copy) NSString *createdAt;//创建时间
@property (nonatomic,copy) NSString *source;//设备来源
@property (nonatomic,copy) NSString *text;//微博内容

#pragma mark - 动态方法

/**
 *  初始化微博数据
 *
 *  @param createAt        创建日期
 *  @param source          来源
 *  @param text            微博内容
 *  @param user            发送用户
 *
 *  @return 微博对象
 */
-(KCStatus *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(KCUser *)user;

/**
 *  初始化微博数据
 *
 *  @param profileImageUrl 用户头像
 *  @param mbtype          会员类型
 *  @param createAt        创建日期
 *  @param source          来源
 *  @param text            微博内容
 *  @param userId          用户编号
 *
 *  @return 微博对象
 */
-(KCStatus *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId;
/**
 *  使用字典初始化微博对象
 *
 *  @param dic 字典数据
 *
 *  @return 微博对象
 */
-(KCStatus *)initWithDictionary:(NSDictionary *)dic;

#pragma mark - 静态方法
/**
 *  初始化微博数据
 *
 *  @param createAt        创建日期
 *  @param source          来源
 *  @param text            微博内容
 *  @param user            发送用户
 *
 *  @return 微博对象
 */
+(KCStatus *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(KCUser *)user;

/**
 *  初始化微博数据
 *
 *  @param profileImageUrl 用户头像
 *  @param mbtype          会员类型
 *  @param createAt        创建日期
 *  @param source          来源
 *  @param text            微博内容
 *  @param userId          用户编号
 *
 *  @return 微博对象
 */
+(KCStatus *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId;

@end