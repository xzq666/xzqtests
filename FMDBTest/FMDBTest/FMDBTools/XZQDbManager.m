//
//  XZQDbManager.m
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "XZQDbManager.h"
#import "XZQAppConfig.h"

#ifndef dbName

#define dbName @"myDatabase.db"

#endif

@implementation XZQDbManager

singleton_implementation(XZQDbManager)

- (instancetype)init {
    XZQDbManager *manager;
    if ((manager=[super init])) {
        [manager openDb:dbName];
    }
    return manager;
}

//打开数据库
- (void)openDb:(NSString *)dbname {
    //取得数据库保存路径，通常保存沙盒Documents目录
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath=[directory stringByAppendingPathComponent:dbname];
    //创建FMDatabaseQueue对象
    self.database=[FMDatabaseQueue databaseQueueWithPath:filePath];
}

//执行更新sql语句，用于插入、修改、删除
- (void)executeNonQuery:(NSString *)sql {
    [self.database inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:sql];
        NSLog(@"creare %@",result?@"success":@"fail"); 
    }];
}

//执行查询sql语句
- (NSArray *)executeQuery:(NSString *)sql {
    NSMutableArray *array = [NSMutableArray array];
    [self.database inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while (result.next) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int i=0; i<result.columnCount; i++) {
                dic[[result columnNameForIndex:i]] = [result stringForColumnIndex:i];
            }
            [array addObject:dic];
        }
        [result close];
    }];
    return array;
}

@end