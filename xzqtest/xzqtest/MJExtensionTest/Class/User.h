//
//  User.h
//  xzqtest
//
//  Created by 许卓权 on 15/10/20.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface User : NSObject

/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 头像 */
@property (copy, nonatomic) NSString *icon;
/** 年龄 */
@property (assign, nonatomic) unsigned int age;
/** 身高 */
@property (assign, nonatomic) float height;
/** 体重 */
@property (assign, nonatomic) float weight;
/** 财富 */
@property (strong, nonatomic) NSNumber *money;
/** 性别 */
@property (assign, nonatomic) Sex sex;
/** 同性恋 */
@property (assign, nonatomic, getter=isGay) BOOL gay;

@end