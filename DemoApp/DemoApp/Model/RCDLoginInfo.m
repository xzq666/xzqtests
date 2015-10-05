//
//  RCDLoginInfo.m
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDLoginInfo.h"

@implementation RCDLoginInfo

+(id)shareLoginInfo {
    static RCDLoginInfo *loginInfo = nil;
    static dispatch_once_t  predicate;
    dispatch_once(&predicate,^{
        loginInfo = [[self alloc] init];
    });
    return loginInfo;
}

@end