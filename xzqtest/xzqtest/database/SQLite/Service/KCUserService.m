//
//  KCUserService.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "KCUserService.h"
#import "KCDbManager.h"

@implementation KCUserService

singleton_implementation(KCUserService)

-(void)addUser:(KCUser *)user{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO User (name,screenName, profileImageUrl,mbtype,city) VALUES('%@','%@','%@','%@','%@')",user.name,user.screenName, user.profileImageUrl,user.mbtype,user.city];
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

-(void)removeUser:(KCUser *)user{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM User WHERE Id='%@'",user.Id];
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

-(void)removeUserByName:(NSString *)name{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM User WHERE name='%@'",name];
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

-(void)modifyUser:(KCUser *)user{
    NSString *sql=[NSString stringWithFormat:@"UPDATE User SET name='%@',screenName='%@',profileImageUrl='%@',mbtype='%@',city='%@' WHERE Id='%@'",user.name,user.screenName,user.profileImageUrl,user.mbtype,user.city,user.Id];
    [[KCDbManager sharedKCDbManager] executeNonQuery:sql];
}

-(KCUser *)getUserById:(int)Id{
    KCUser *user=[[KCUser alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT name,screenName,profileImageUrl,mbtype,city FROM User WHERE Id='%i'", Id];
    NSArray *rows= [[KCDbManager sharedKCDbManager] executeQuery:sql];
    if (rows&&rows.count>0) {
        [user setValuesForKeysWithDictionary:rows[0]];
    }
    return user;
}

-(KCUser *)getUserByName:(NSString *)name{
    KCUser *user=[[KCUser alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT Id, name,screenName,profileImageUrl,mbtype,city FROM User WHERE name='%@'", name];
    NSArray *rows= [[KCDbManager sharedKCDbManager] executeQuery:sql];
    if (rows&&rows.count>0) {
        [user setValuesForKeysWithDictionary:rows[0]];
    }
    return user;
}

@end