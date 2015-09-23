//
//  MasonryViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/9/22.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "MasonryViewController.h"
#import "Masonry.h"

@interface MasonryViewController ()

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Masonry自动布局";
    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"status height - %f", rectStatus.size.height);   // 高度
    
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    NSLog(@"nav height - %f", rectNav.size.height);   // 高度
    
    UIView *superview = self.view;
    
    UIView *view1 = [[UIView alloc] init];
//    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view1.backgroundColor = [UIColor greenColor];
    [superview addSubview:view1];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10+rectStatus.size.height+rectNav.size.height, 10, 10, 10);
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(superview.mas_top).with.offset(padding.top); //with is an optional semantic filler
//        make.left.equalTo(superview.mas_left).with.offset(padding.left);
//        make.bottom.equalTo(superview.mas_bottom).with.offset(-padding.bottom);
//        make.right.equalTo(superview.mas_right).with.offset(-padding.right);
        make.edges.equalTo(superview).with.insets(padding);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end