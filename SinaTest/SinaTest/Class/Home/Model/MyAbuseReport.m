
//
//  MyAbuseReport.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/29.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyAbuseReport.h"

@implementation MyAbuseReport

@dynamic reason;
@dynamic author;
@dynamic convid;

+(NSString*)parseClassName{
    return @"AbuseReport";
}

@end