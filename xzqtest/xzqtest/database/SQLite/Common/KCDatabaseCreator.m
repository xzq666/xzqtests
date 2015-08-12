//
//  KCDatabaseCreator.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "KCDatabaseCreator.h"
#import "KCDbManager.h"

@implementation KCDatabaseCreator

//为了避免每次都创建数据库和表出错，这里利用了偏好设置进行保存当前创建状态（其实这也是数据存储的一部分），如果创建过了数据库则不再创建，否则创建数据库和表
+(void)initDatabase{
    NSString *key=@"IsCreatedDb";
    NSUserDefaults *defaults=[[NSUserDefaults alloc]init];
    if ([[defaults valueForKey:key] intValue]!=1) {
        [self createUserTable];
        [self createStatusTable];
        [defaults setValue:@1 forKey:key];
    }
}

+(void)createUserTable{
    NSString *sql=@"CREATE TABLE User (Id integer PRIMARY KEY AUTOINCREMENT,name text,screenName text, profileImageUrl text,mbtype text,city text)";
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

+(void)createStatusTable{
    NSString *sql=@"CREATE TABLE Status (Id integer PRIMARY KEY AUTOINCREMENT,source text,createdAt date,\"text\" text,user integer REFERENCES User (Id))";
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

@end