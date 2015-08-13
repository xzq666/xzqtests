//
//  CDDBManager.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "KCSingleton.h"

@interface CDDBManager : NSObject

singleton_interface(CDDBManager);

#pragma mark - 属性
#pragma mark 数据库引用，使用它进行数据库操作
@property (nonatomic) NSManagedObjectContext *context;

#pragma mark - 共有方法
/**
 *  打开数据库
 *
 *  @param dbname 数据库名称
 */
-(NSManagedObjectContext *)createDbContext;

@end