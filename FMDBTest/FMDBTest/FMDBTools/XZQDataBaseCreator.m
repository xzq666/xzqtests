//
//  XZQDataBaseCreator.m
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "XZQDataBaseCreator.h"
#import "XZQDbManager.h"

@implementation XZQDataBaseCreator

+ (void)initDatabase {
    NSString *key = @"IsCreateDb";
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if ([[defaults valueForKey:key] intValue] != 1) { //如果数据库无表
        //创建表
        [self createHandBookTable];
        //标志位置为1
        [defaults setValue:@1 forKey:key];
    }
}

+ (void)createHandBookTable {
    NSString *sql = @"CREATE TABLE HandBook (Id integer PRIMARY KEY AUTOINCREMENT,name text,star text,imgurl text)";
    [[XZQDbManager sharedXZQDbManager] executeNonQuery:sql];
}

@end