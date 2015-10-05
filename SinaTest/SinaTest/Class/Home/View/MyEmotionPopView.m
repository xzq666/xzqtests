//
//  MyEmotionPopView.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyEmotionPopView.h"
#import "MyEmotionView.h"

@interface MyEmotionPopView()

@property (weak, nonatomic) IBOutlet MyEmotionView *emotionView;

@end

@implementation MyEmotionPopView

+ (instancetype)popView {
    return [[[NSBundle mainBundle] loadNibNamed:@"MyEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromEmotionView:(MyEmotionView *)fromEmotionView {
    if (fromEmotionView == nil) return;
    // 1.显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    // 2.添加到窗口上（防止键盘遮挡）
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    // 3.设置位置
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5 + fromEmotionView.height*0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

- (void)dismiss {
    [self removeFromSuperview];
}

/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect {
    [[UIImage imageWithName:@"emotion_keyboard_magnifier"] drawInRect:rect];
}

@end