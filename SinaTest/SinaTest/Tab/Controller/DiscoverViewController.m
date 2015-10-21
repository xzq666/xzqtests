//
//  DiscoverViewController.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "DiscoverViewController.h"
#import "MyEmotionTextView.h"

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    MyEmotionTextView *textView = [[MyEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES ;//垂直方向上有弹簧效果
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    // 2.设置提醒文字
    textView.placeholder = @"发表新微博...";
}

@end