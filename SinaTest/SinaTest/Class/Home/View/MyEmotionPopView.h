//
//  MyEmotionPopView.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyEmotionView;

@interface MyEmotionPopView : UIView

+ (instancetype)popView;

// 显示表情弹出控件，emotionVIEW从哪个表情上面弹出
- (void)showFromEmotionView:(MyEmotionView *)fromEmotionView;
// 隐藏
- (void)dismiss;

@end