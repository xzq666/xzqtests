//
//  PaoMaView.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEXTCOLOR [UIColor whiteColor]
#define TEXTFONTSIZE 14

@interface PaoMaView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;

- (void)start;//开始跑马
- (void)stop;//停止跑马

@end