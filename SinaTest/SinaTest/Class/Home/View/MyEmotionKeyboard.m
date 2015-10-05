//
//  MyEmotionKeyboard.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyEmotionKeyboard.h"
#import "MyEmotionListView.h"
#import "MyEmotionToolbar.h"
#import "MyEmotion.h"
#import "MyEmotionTool.h"

@interface MyEmotionKeyboard()<MyEmotionToolbarDelegate>

@property (nonatomic,weak) MyEmotionListView *listView;
@property (nonatomic,weak) MyEmotionToolbar *toolbar;

@end

@implementation MyEmotionKeyboard

+ (instancetype)keyboard {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"emotion_keyboard_background"]];
        // 1.添加表情列表
        MyEmotionListView *listView = [[MyEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        // 2.添加表情工具条
        MyEmotionToolbar *toolbar = [[MyEmotionToolbar alloc] init];
        toolbar.currentButtonType = [MyEmotionTool recentEmotions].count > 0 ? MyEmotionTypeRecent : MyEmotionTypeDefault;
        toolbar.delegate = self;
        [self addSubview:toolbar];
        self.toolbar = toolbar;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 1.设置工具条的frame
    self.toolbar.width = self.width;
    self.toolbar.height = 35;
    self.toolbar.y = self.height - self.toolbar.height;
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toolbar.y;
}

- (void)emotionToolbar:(MyEmotionToolbar *)toolbar didSelectedButton:(MyEmotionTYype)emotionType {
    switch (emotionType) {
        case MyEmotionTypeDefault:
            self.listView.emotions = [MyEmotionTool defaultEmotions];
            break;
        case MyEmotionTypeEmoji:
            self.listView.emotions = [MyEmotionTool emojiEmotions];
            break;
        case MyEmotionTypeLxh:
            self.listView.emotions = [MyEmotionTool lxhEmotions];
            break;
        case MyEmotionTypeRecent:
            self.listView.emotions = [MyEmotionTool recentEmotions];
            break;
        default:
            break;
    }
}

@end