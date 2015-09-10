//
//  Common.m
//  xzqtest
//
//  Created by 许卓权 on 15/9/10.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "Common.h"

@implementation Common

static Common *common;

- (id)init{
    self = [super init];
    if (self) {
        //用户id
        _max = -1;
    }
    return self;
}

+ (Common *)sharedCommon {
    @synchronized([Common class]){//加一个互斥锁，保证没有其他修改
        if (common == nil) {
            common = [[self alloc]init];
        }
        return common;
    }
}

@end