//
//  MyStatusOriginalFrame.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyStatus;
@interface MyStatusOriginalFrame : NSObject

// 1.昵称
@property (nonatomic , assign) CGRect nameFrame;
// 2.正文
@property (nonatomic , assign) CGRect textFrame;
// 3.头像
@property (nonatomic , assign) CGRect iconFrame;
// 4.会员图标
@property (nonatomic , assign) CGRect vipFrame;
// 5.更多图标
@property (nonatomic , assign) CGRect moreFrame;
// 6.自己的frame
@property (nonatomic , assign) CGRect frame;
// 7.配图的frame
@property (nonatomic , assign) CGRect photosFrame;
// 8.数据
@property (nonatomic , strong) MyStatus *status;

@end