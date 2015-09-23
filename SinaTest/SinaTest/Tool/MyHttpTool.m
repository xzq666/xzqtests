//
//  MyHttpTool.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyHttpTool.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation MyHttpTool

+ (void)monitoringReachabilityStatus:(void (^)(AFNetworkReachabilityStatus))statusBlock {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //当前网络改变了就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        if (status){
            statusBlock(status);
        }
    }];
    //开始监控
    [mgr startMonitoring];
}

+ (void)showNetworkActivityIndicatior {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

@end