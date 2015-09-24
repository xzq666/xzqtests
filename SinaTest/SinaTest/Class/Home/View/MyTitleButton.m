//
//  MyTitleButton.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyTitleButton.h"

@implementation MyTitleButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 字体大小
        self.titleLabel.font = MyNavigationFont;
        // 高亮的时候不需要调整内部的图片灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

// 设置内部图标的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageY = 0;
    CGFloat imageW = self.height;
    CGFloat imageH = self.height;
    CGFloat imageX = self.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

// 设置内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleH = self.height;
    CGFloat titleW = self.width - self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

/**
 *  重写title，自动计算按钮的宽度
 *
 *  @param title 标题
 *  @param state 按钮状态
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    // 1.计算文字的尺寸
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    // 2.计算按钮的宽度
    self.width = titleSize.width + self.height +MyNavigationItemMargin;
}

@end