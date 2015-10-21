//
//  StatusResult.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/21.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "StatusResult.h"

@implementation StatusResult

+ (NSDictionary *)objectClassInArray {
    return @{
             @"statuses" : @"Status",
             @"ads" : @"Ad"
             };
}

@end