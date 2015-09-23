//
//  MyAVStatus.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyAVStatus.h"

@implementation MyAVStatus

@dynamic creator;
@dynamic statusContent;
@dynamic albumPhotos;
@dynamic comments;
@dynamic digUsers;

+ (NSString *)parseClassName {
    return @"Album";
}

@end