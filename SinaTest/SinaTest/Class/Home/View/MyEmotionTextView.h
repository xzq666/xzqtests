//
//  MyEmotionTextView.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyTextView.h"

@class MyEmotion;

@interface MyEmotionTextView : MyTextView

// 拼接表情到最后面
- (void)appendEmotion:(MyEmotion *)emotion;

- (NSString *)realText;

@end