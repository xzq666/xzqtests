//
//  MyHttpTool.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AVConstants.h"
#import "MyHomeStatus.h"

@interface MyHttpTool : NSObject

//监控网络状态
+ (void)monitoringReachabilityStatus:(void (^)(AFNetworkReachabilityStatus)) statusBlock;

//是否展示网络激活指示器
+ (void)showNetworkActivityIndicatior;

- (void)findStatusWithBlock:(AVArrayResultBlock)block;

- (MyHomeStatus *)showHomestatusFromAVObjects:(NSArray *)objects;

@end