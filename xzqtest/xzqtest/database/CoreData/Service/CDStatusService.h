//
//  CDUserService.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCSingleton.h"
#import <CoreData/CoreData.h>

@class CDStatus;
@class CDUser;

@interface CDStatusService : NSObject
singleton_interface(CDStatusService)

@property (nonatomic,strong) NSManagedObjectContext *context;

/**
 *  添加微博信息
 *
 *  @param status 微博对象
 */
-(void)addStatus:(CDStatus *)status;

/**
 *  添加微博信息
 *
 *  @param date   创建日期
 *  @param source 设备来源
 *  @param text   微博内容
 *  @param user   发送用户
 */
-(void)addStatusWithCreatedAt:(NSDate *)createdAt source:(NSString *)source text:(NSString *)text user:(CDUser *)user;

/**
 *  删除微博
 *
 *  @param status 微博对象
 */
-(void)removeStatus:(CDStatus *)status;

/**
 *  取得所有微博对象
 *
 *  @return 所有微博对象
 */
-(NSArray *)getAllStatus;

-(NSArray *)getStatusesByUserName:(NSString *)name;

@end