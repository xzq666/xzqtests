//
//  ViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseMainViewController.h"
#import "PaoMaViewController.h"
#import "UMCommunity.h"

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
    
    UIButton *paoma = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [paoma setTitle:@"跑马灯" forState:UIControlStateNormal];
    [paoma setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    paoma.layer.masksToBounds = YES;
    paoma.layer.borderWidth = 0.5;
    paoma.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 80, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [paoma addTarget:self action:@selector(paomaClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paoma];
    
    UIButton *community = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [community setTitle:@"社区" forState:UIControlStateNormal];
    [community setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    community.layer.masksToBounds = YES;
    community.layer.borderWidth = 0.5;
    community.frame = CGRectMake(10, 140, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [community addTarget:self action:@selector(communityClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:community];
}

- (void)databaseClick {
    DatabaseMainViewController *vc = [[DatabaseMainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)paomaClick {
    PaoMaViewController *vc = [[PaoMaViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)communityClick {
    UIViewController *communityController = [UMCommunity getFeedsModalViewController];
    [self presentViewController:communityController animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end