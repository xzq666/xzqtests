//
//  MyEmotionTool.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyEmotion;

@interface MyEmotionTool : NSObject

/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;
/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(MyEmotion *)emotion;
/**
 *  根据表情描述返回表情模型
 */
+ (MyEmotion *)emotionWithDesc:(NSString *)desc;

@end