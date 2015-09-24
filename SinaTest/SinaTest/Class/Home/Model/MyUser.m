//
//  MyUser.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyUser.h"

#define DSUserFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arch"]

@implementation MyUser

+ (void)save:(AVUser *)user {
    MyUser *curUser = [[MyUser alloc] init];
    if (user != nil) {
        curUser.username = user.username;
        curUser.avatarUrl = ((AVFile *)[user objectForKey:@"avatar"]).url;
        curUser.userId = user.objectId;
    }
    //[NSKeyedArchiver archiveRootObject:curUser toFile:DSUserFilepath];
}

+ (MyUser *)readLocalUser {
    MyUser *account = [NSKeyedUnarchiver unarchiveObjectWithFile:DSUserFilepath];
    return account;
}

+ (MyUser *)transfer:(AVUser *)user {
    MyUser *curUser = [[MyUser alloc] init];
    if (user != nil) {
        curUser.username = user.username;
        curUser.avatarUrl = ((AVFile *)[user objectForKey:@"avatar"]).url;
        curUser.userId = user.objectId;
    }
    return curUser;
}

@end