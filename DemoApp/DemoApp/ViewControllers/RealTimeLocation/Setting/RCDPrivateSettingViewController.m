//
//  RCDPrivateSettingViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDPrivateSettingViewController.h"

@interface RCDPrivateSettingViewController ()

@end

@implementation RCDPrivateSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[UIView new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.defaultCells[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //覆盖父类实现，什么也不做
}

@end