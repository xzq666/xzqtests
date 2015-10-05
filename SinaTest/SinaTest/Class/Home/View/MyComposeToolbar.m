//
//  MyComposeToolbar.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyComposeToolbar.h"

@interface MyComposeToolbar()

@property (nonatomic ,weak) UIButton *emotionButton;

@end

@implementation MyComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        //添加所有子控件
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        // 添加所有的子控件
        //[self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:MyComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:MyComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:MyComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:MyComposeToolbarButtonTypeTrend];
        UIButton *emotionBtn =  [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:MyComposeToolbarButtonTypeEmotion];
        self.emotionButton = emotionBtn;
    }
    return self;
}

/**
 *  添加一个按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (UIButton *)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(MyComposeToolbarButtonType)tag {
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
    return button;
}

- (void)setShowEmotionButton:(BOOL)showEmotionButton {
    _showEmotionButton = showEmotionButton;
    if (showEmotionButton) { // 显示表情按钮
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else { // 切换为键盘按钮
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithName:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

- (void)buttonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickedButton:)]){
        [self.delegate composeTool:self didClickedButton:(int)button.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    for (int i = 0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}

@end