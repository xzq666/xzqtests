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
#import "MyStatus.h"

@interface MyHttpTool : NSObject

//监控网络状态
+ (void)monitoringReachabilityStatus:(void (^)(AFNetworkReachabilityStatus)) statusBlock;

//是否展示网络激活指示器
+ (void)showNetworkActivityIndicatior;

- (void)createStatusWithText:(NSString*)text error:(NSError**)error;
- (void)createStatusWithImage:(NSString*)text photos:(NSArray*)photos error:(NSError**)error;

- (void)findStatusWithBlock:(AVArrayResultBlock)block;

- (void)commentToUser:(AVObject*)status content:(NSString*)content block:(AVBooleanResultBlock)block;

- (MyHomeStatus *)showHomestatusFromAVObjects:(NSArray *)objects;

- (void)digOrCancelDigOfStatus:(MyStatus *)status sender:(UIButton *)sender block:(AVBooleanResultBlock)block;

- (void)findMoreStatusWithBlock:(NSArray *)loadedStatusIDs block:(AVArrayResultBlock)block;

- (NSArray *)showCommentFromAVObject:(NSArray *)object;

@end