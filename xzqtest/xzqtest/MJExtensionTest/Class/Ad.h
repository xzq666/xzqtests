//
//  Ad.h
//  xzqtest
//
//  Created by 许卓权 on 15/10/21.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface Ad : NSObject

/** 广告图片 */
@property (copy, nonatomic) NSString *image;
/** 广告url */
@property (strong, nonatomic) NSURL *url;

@end