//
//  MyAddRequest.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/29.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyAddRequest.h"

@implementation MyAddRequest

@dynamic fromUser;
@dynamic toUser;
@dynamic status;

+(NSString *)parseClassName{
    return @"AddRequest";
}

@end