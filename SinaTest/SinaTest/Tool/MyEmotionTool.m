//
//  MyEmotionTool.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//


#define MyRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.arch"]

#import "MyEmotionTool.h"
#import "MyEmotion.h"
#import "MyEmotionGroup.h"
#import "MJExtension.h"

@implementation MyEmotionTool

// 默认表情
static NSArray *_defaultEmotions;
// emoji表情
static NSArray *_emojiEmotion;
// 浪小花表情
static NSArray *_lxhEmotions;
// 最近表情
static NSMutableArray *_recentEmotions;

+ (NSArray *)defaultEmotions {
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"default.plist" ofType:nil];
        _defaultEmotions = [MyEmotionGroup objectWithFile:plist].emotion_group_emotions;
    }
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions {
    if (!_emojiEmotion) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"emoji.plist" ofType:nil];
        _emojiEmotion = [MyEmotionGroup objectWithFile:plist].emotion_group_emotions;
    }
    return _emojiEmotion;
}

+ (NSArray *)lxhEmotions {
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"lxh.plist" ofType:nil];
        _lxhEmotions = [MyEmotionGroup objectWithFile:plist].emotion_group_emotions;
    }
    return _lxhEmotions;
}

+ (NSArray *)recentEmotions {
    if (!_recentEmotions) {
        // 去沙盒中加载最近使用的表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:MyRecentFilepath];
        if (!_recentEmotions) { // 沙盒中没有任何数据
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}

// Emotion -- 戴口罩 -- Emoji的plist里面加载的表情
+ (void)addRecentEmotion:(MyEmotion *)emotion {
    // 加载最近的表情数据
    [self recentEmotions];
    // 删除之前的表情
    [_recentEmotions removeObject:emotion];
    // 添加最新的表情
    [_recentEmotions insertObject:emotion atIndex:0];
    // 存储到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:MyRecentFilepath];
}

+ (MyEmotion *)emotionWithDesc:(NSString *)desc {
    if (!desc) return nil;
    __block MyEmotion *foundEmotion = nil;
    // 从默认表情中找
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(MyEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    if (foundEmotion) return foundEmotion;
    // 从浪小花表情中查找
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(MyEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    return foundEmotion;
}

@end