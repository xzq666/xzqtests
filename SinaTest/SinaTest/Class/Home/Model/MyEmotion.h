//
//  MyEmotion.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEmotion : NSObject<NSCoding>

//表情文字描述
@property (nonatomic ,  copy) NSString *chs;
//表情的文字t描述
@property (nonatomic , copy) NSString *cht;
//表情的png文件名
@property (nonatomic , copy) NSString *png;
//emoji表情的编码
@property (nonatomic ,copy) NSString *code;
//emoji 表情的字符
@property (nonatomic , copy) NSString *emoji;

@end