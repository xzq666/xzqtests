//
//  KCStatus.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "KCStatus.h"

@implementation KCStatus

-(KCStatus *)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
        self.user=[[KCUser alloc]init];
        self.user.Id=dic[@"user"];
    }
    return self;
}

-(KCStatus *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(KCUser *)user{
    if (self=[super init]) {
        self.createdAt=createAt;
        self.source=source;
        self.text=text;
        self.user=user;
    }
    return self;
}

-(KCStatus *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId{
    if (self=[super init]) {
        self.createdAt=createAt;
        self.source=source;
        self.text=text;
        KCUser *user=[[KCUser alloc]init];
        user.Id=[NSNumber numberWithInt:userId];
        self.user=user;
    }
    return self;
}

-(NSString *)source{
    return [NSString stringWithFormat:@"来自 %@",_source];
}

+(KCStatus *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(KCUser *)user{
    KCStatus *status=[[KCStatus alloc]initWithCreateAt:createAt source:source text:text user:user];
    return status;
}

+(KCStatus *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId{
    KCStatus *status=[[KCStatus alloc]initWithCreateAt:createAt source:source text:text userId:userId];
    return status;
}

@end