//
//  RCDChatRoomInfo.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCDChatRoomInfo : NSObject

/** ID */
@property(nonatomic, strong) NSString* chatRoomId;
/** 名称 */
@property(nonatomic, strong) NSString* chatRoomName;
/** 头像 */
@property(nonatomic, strong) NSString* portrait;
/** 人数 */
@property(nonatomic, strong) NSString* number;
/** 最大人数 */
@property(nonatomic, strong) NSString* maxNumber;
/** 简介 */
@property(nonatomic, strong) NSString* introduce;
/** 类别 */
@property(nonatomic, strong) NSString* category;
/** 创建者Id */
//@property(nonatomic, strong) NSString* creatorId;
/** 创建日期 */
//@property(nonatomic, strong) NSString* creatorTime;
/** 是否加入 */
//@property(nonatomic, assign) bool  isJoin;

@end