//
//  MyEmotionView.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyEmotionView.h"
#import "MyEmotion.h"

@implementation MyEmotionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(MyEmotion *)emotion {
    _emotion = emotion;
    if (emotion.code) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageWithName:emotion.png] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end