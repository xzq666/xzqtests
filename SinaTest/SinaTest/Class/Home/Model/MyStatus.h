//
//  MyStatus.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyUser.h"

@class MyStatus;

@interface MyStatus : NSObject

//Feed创建时间
@property (nonatomic , copy) NSString *created_at;
//Feed 字符串ID
@property (nonatomic , copy) NSString *idstr;
//Feed 内容
@property (nonatomic ,copy) NSString *text;
//信息中富文本内容
@property (nonatomic , copy) NSAttributedString *attributedText;
//来源
@property (nonatomic , copy) NSString *source;
//Feed 作者
@property (nonatomic , strong) MyUser *user;
//被转发的原Feed信息
@property (nonatomic , strong) MyStatus *retweeted_status;
//评论
@property (nonatomic , strong) NSArray *comments;
//转发数
@property (nonatomic , assign) int reposts_count;
//评论数
@property (nonatomic , assign) int comments_count;
//收藏数
@property (nonatomic , assign) int attitudes_count;
//配图
@property (nonatomic , strong) NSArray *pic_urls;
//是否有转发Feed
@property (nonatomic , getter=isRetweeted) bool retweeted;
//喜欢的用户
@property (nonatomic , strong) NSArray *digusers;

@end