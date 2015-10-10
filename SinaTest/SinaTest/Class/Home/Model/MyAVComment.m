//
//  MyAVComment.m
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyAVComment.h"

@implementation MyAVComment

@dynamic status;
@dynamic commentContent;
@dynamic commentUsername;
@dynamic commentUser;
@dynamic toUser;

+ (NSString*)parseClassName{
    return @"Comment";
}

@end