//
//  MyEmotionAttachment.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyEmotionAttachment.h"
#import "MyEmotion.h"

@implementation MyEmotionAttachment

- (void)setEmotion:(MyEmotion *)emotion {
    _emotion = emotion;
    self.image = [UIImage imageWithName:emotion.png];
}

@end