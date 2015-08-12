//
//  ViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseMainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *database = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [database setTitle:@"数据库" forState:UIControlStateNormal];
    [database setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    database.layer.masksToBounds = YES;
    database.layer.borderWidth = 0.5;
    database.frame = CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [database addTarget:self action:@selector(databaseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:database];
}

- (void)databaseClick {
    DatabaseMainViewController *vc = [[DatabaseMainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end