//
//  MyCommentDetailFrame.h
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyComment;

@interface MyCommentDetailFrame : NSObject

// 1.昵称
@property (nonatomic , assign) CGRect nameFrame;
// 2.正文
@property (nonatomic , assign) CGRect textFrame;
// 3.头像
@property (nonatomic , assign) CGRect iconFrame;
// 4.会员图标
@property (nonatomic , assign) CGRect vipFrame;
// 5.自己的frame
@property (nonatomic , assign) CGRect frame;
// 6.配图的frame
@property (nonatomic , assign) CGRect photosFrame;
// 7.数据
@property (nonatomic ,strong) MyComment *commentData;

@end