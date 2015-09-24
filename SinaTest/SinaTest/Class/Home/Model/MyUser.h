//
//  MyUser.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyUser;
@interface MyUser : NSObject

//用户名字
@property (nonatomic , copy) NSString *username;
//用户id
@property (nonatomic , copy) NSString *userId;
//用户头像
@property (nonatomic , copy) NSString *avatarUrl;
//用户等级
@property (nonatomic , assign) int mbrank;
//性别
@property (nonatomic , copy) NSString *gender;

+ (void)save:(AVUser *)user;
+ (MyUser *)readLocalUser;
+ (MyUser *)transfer:(AVUser *)user;

@end