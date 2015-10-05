//
//  MyEmotionGroup.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEmotionGroup : NSObject

// 表情分组身份
@property (nonatomic , copy) NSString *emotion_group_identifier;
// 表情类型
@property (nonatomic , copy) NSString *emotion_group_type;
// 表情
@property (nonatomic , strong) NSArray *emotion_group_emotions;

@end