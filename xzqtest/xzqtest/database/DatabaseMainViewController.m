//
//  DatabaseMainViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/12.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "DatabaseMainViewController.h"
#import "KCMainViewController.h"
#import "CDMainTableViewController.h"

@implementation DatabaseMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"数据库";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *SQLite = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [SQLite setTitle:@"SQLite" forState:UIControlStateNormal];
    [SQLite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    SQLite.layer.masksToBounds = YES;
    SQLite.layer.borderWidth = 0.5;
    SQLite.frame = CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [SQLite addTarget:self action:@selector(SQLiteClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SQLite];
    
    UIButton *CoreData = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [CoreData setTitle:@"CoreData" forState:UIControlStateNormal];
    [CoreData setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CoreData.layer.masksToBounds = YES;
    CoreData.layer.borderWidth = 0.5;
    CoreData.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 80, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [CoreData addTarget:self action:@selector(CoreDataClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CoreData];
    
    UIButton *FMDB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [FMDB setTitle:@"FMDB" forState:UIControlStateNormal];
    [FMDB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    FMDB.layer.masksToBounds = YES;
    FMDB.layer.borderWidth = 0.5;
    FMDB.frame = CGRectMake(10, 130, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [FMDB addTarget:self action:@selector(FMDBClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FMDB];
}

//跳转至SQLite效果展示页
- (void)SQLiteClick {
    KCMainViewController *vc = [[KCMainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)CoreDataClick {
    CDMainTableViewController *vc = [[CDMainTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)FMDBClick {
    NSLog(@"2");
}

@end