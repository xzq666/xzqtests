//
//  HandBookService.m
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "HandBookService.h"
#import "XZQDbManager.h"

@implementation HandBookService

singleton_implementation(HandBookService)

- (void)addHandBook:(HandBook *)handbook {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO HandBook (name,star,imgurl) VALUES('%@','%@','%@')",handbook.name,handbook.star,handbook.imgurl];
    [[XZQDbManager sharedXZQDbManager] executeNonQuery:sql];
}

- (void)removeHandBook:(HandBook *)handbook {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM HandBook WHERE Id='%@'",handbook.Id];
    [[XZQDbManager sharedXZQDbManager] executeNonQuery:sql];
}

- (void)removeHandBookByName:(NSString *)name {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM HandBook WHERE name='%@'",name];
    [[XZQDbManager sharedXZQDbManager] executeNonQuery:sql];
}

- (void)modifyHandBook:(HandBook *)handbook {
    NSString *sql = [NSString stringWithFormat:@"UPDATE HandBook SET name='%@',star='%@',imgurl='%@' WHERE Id='%@'",handbook.name,handbook.star,handbook.imgurl,handbook.Id];
    [[XZQDbManager sharedXZQDbManager] executeNonQuery:sql];
}

- (HandBook *)getHandBookById:(int)Id {
    HandBook *handbook = [[HandBook alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT name,star,imgurl FROM HandBook WHERE Id='%i'",Id];
    NSArray *rows = [[XZQDbManager sharedXZQDbManager] executeQuery:sql];
    if (rows&&rows.count>0) {
        [handbook setValuesForKeysWithDictionary:rows[0]];
    }
    return handbook;
}

- (HandBook *)getHandBookByName:(NSString *)name {
    HandBook *handbook = [[HandBook alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT Id,name,star,imgurl FROM HandBook WHERE name='%@'",name];
    NSArray *rows = [[XZQDbManager sharedXZQDbManager] executeQuery:sql];
    if (rows&&rows.count>0) {
        [handbook setValuesForKeysWithDictionary:rows[0]];
    }
    return handbook;
}

- (NSArray *)getAllHandBook {
    NSString *sql = [NSString stringWithFormat:@"SELECT Id,name,star,imgurl FROM HandBook"];
    NSArray *rows = [[XZQDbManager sharedXZQDbManager] executeQuery:sql];
    return rows;
}

@end