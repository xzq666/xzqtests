//
//  MyStatusRetweetedFrame.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyStatus;

@interface MyStatusRetweetedFrame : NSObject
/** 昵称 */
//@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 转发微博模型 */
@property (nonatomic, strong) MyStatus *retweetedStatus;
/** 相册的frame */
@property (nonatomic, assign) CGRect photosFrame;
/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

@end