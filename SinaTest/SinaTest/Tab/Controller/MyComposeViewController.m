//
//  MyComposeViewController.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyComposeViewController.h"

#define SourceCompose @"compose"
#define SourceComment @"comment"

@implementation MyComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航标题
    [self setupNavigationItem];
}

//设置导航标题
- (void)setupNavigationItem {
    NSString *name = [AVUser currentUser].username;
    if (name) {
        NSString *prefix = @"";
        if ([self.source isEqual:SourceCompose]){
            prefix = @"发微博";
        }
        if ([self.source isEqual:SourceComment]){
            prefix = @"发评论";
        }
        NSString *text = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[text rangeOfString:prefix]];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:[text rangeOfString:name]];
        
        //创建label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.attributedText = string;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    }else{
        self.title = @"发微博";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel {
    NSLog(@"cancel button clicked!");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    NSLog(@"send button clicked!");
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end