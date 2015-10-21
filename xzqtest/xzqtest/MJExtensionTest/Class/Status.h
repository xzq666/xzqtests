//
//  Status.h
//  xzqtest
//
//  Created by 许卓权 on 15/10/21.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class User;

@interface Status : NSObject

/** 微博文本内容 */
@property (copy, nonatomic) NSString *text;
/** 微博作者 */
@property (strong, nonatomic) User *user;
/** 转发的微博 */
@property (strong, nonatomic) Status *retweetedStatus;

@end