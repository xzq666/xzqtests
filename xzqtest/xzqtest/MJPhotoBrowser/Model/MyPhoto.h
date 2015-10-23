//
//  MyPhoto.h
//  xzqtest
//
//  Created by 许卓权 on 15/10/22.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPhoto : NSObject

//缩略图
@property (nonatomic , copy) NSString *thumbnail_pic;
//中等尺寸图片地址，没有时返回此字段
@property (nonatomic , copy) NSString *bmiddle_pic;
//原图地址，没有时不返回此字段
@property (nonatomic , copy) NSString *original_pic;

@end