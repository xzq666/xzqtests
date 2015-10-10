//
//  MyComment.h
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyUser;

@interface MyComment : NSObject

//commetn id
@property (nonatomic , copy) NSString *idstr;
//评论内容
@property (nonatomic , copy) NSString *commentContent;
//评论发布人
@property (nonatomic , strong) MyUser *user;
//关联的status
@property (nonatomic , strong) AVObject *status;
//touser
@property (nonatomic , strong) MyUser *toUser;
//穿件时间
@property (nonatomic , copy) NSString *created_at;
//信息中富文本内容
@property (nonatomic , copy) NSAttributedString *attributedText;
//配图
@property (nonatomic , strong) NSArray *pic_urls;

@end