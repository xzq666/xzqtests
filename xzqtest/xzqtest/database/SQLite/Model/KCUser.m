//
//  KCUser.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "KCUser.h"

@implementation KCUser

-(KCUser *)initWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city{
    if (self=[super init]) {
        self.name=name;
        self.screenName=screenName;
        self.profileImageUrl=profileImageUrl;
        self.mbtype=mbtype;
        self.city=city;
    }
    return self;
}


-(KCUser *)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(KCUser *)userWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city{
    KCUser *user=[[KCUser alloc]initWithName:name screenName:screenName profileImageUrl:profileImageUrl mbtype:mbtype city:city];
    return user;
}

@end