//
//  Common.h
//  xzqtest
//
//  Created by 许卓权 on 15/9/10.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

//选择照片一次最多选择张数
@property (nonatomic) NSInteger max;

+ (Common *)sharedCommon;

@end