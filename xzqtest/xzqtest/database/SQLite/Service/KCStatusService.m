//
//  KCStatusService.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "KCStatusService.h"
#import "KCDbManager.h"
#import "KCStatus.h"
#import "KCUserService.h"
#import "KCSingleton.h"

@interface KCStatusService(){
    
}

@end

@implementation KCStatusService
singleton_implementation(KCStatusService)


-(void)addStatus:(KCStatus *)status{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Status (source,createdAt,\"text\" ,user) VALUES('%@','%@','%@','%@')",status.source,status.createdAt,status.text,status.user.Id];
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

-(void)removeStatus:(KCStatus *)status{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM Status WHERE Id='%@'",status.Id];
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

-(void)modifyStatus:(KCStatus *)status{
    NSString *sql=[NSString stringWithFormat:@"UPDATE Status SET source='%@',createdAt='%@',\"text\"='%@' ,user='%@' WHERE Id='%@'",status.source,status.createdAt,status.text,status.user, status.Id];
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

-(KCStatus *)getStatusById:(int)Id{
    KCStatus *status=[[KCStatus alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT Id, source,createdAt,\"text\" ,user FROM Status WHERE Id='%i'", Id];
    NSArray *rows= [[KCDbManager sharedKCDbManager] executeQuery:sql];
    if (rows&&rows.count>0) {
        [status setValuesForKeysWithDictionary:rows[0]];
        status.user=[[KCUserService sharedKCUserService] getUserById:[(NSNumber *)rows[0][@"user"] intValue]] ;
    }
    return status;
}

-(NSArray *)getAllStatus{
    NSMutableArray *array=[NSMutableArray array];
    NSString *sql=@"SELECT Id, source,createdAt,\"text\" ,user FROM Status ORDER BY Id";
    NSArray *rows= [[KCDbManager sharedKCDbManager] executeQuery:sql];
    for (NSDictionary *dic in rows) {
        KCStatus *status=[self getStatusById:[(NSNumber *)dic[@"Id"] intValue]];
        [array addObject:status];
    }
    return array;
}

@end