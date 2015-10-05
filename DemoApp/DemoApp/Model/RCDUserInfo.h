//
//  RCDUserInfo.h
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMLib/RCUserInfo.h>

@interface RCDUserInfo : RCUserInfo

/** 全拼*/
@property(nonatomic, strong) NSString* quanPin;
/** email*/
@property(nonatomic, strong) NSString* email;
/**  1 好友, 2 请求添加, 3 请求被添加, 4 请求被拒绝, 5 我被对方删除*/
@property(nonatomic, strong) NSString* status;

@end