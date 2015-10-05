//
//  DSPopMenu.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MyPopMenuArrowPositionCenter = 0,
    MyPopMenuArrowPositionLeft = 1,
    MyPopMenuArrowPositionRight = 2
} MyPopMenuArrowPosition;

@class MyPopMenu;

@interface MyPopMenu : UIView

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;

@property (nonatomic, assign) MyPopMenuArrowPosition arrowPosition;

/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;

@end