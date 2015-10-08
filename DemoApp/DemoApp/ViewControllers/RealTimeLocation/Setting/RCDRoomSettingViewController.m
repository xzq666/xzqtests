//
//  RCDRoomSettingViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDRoomSettingViewController.h"

@implementation RCDRoomSettingViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.defaultCells.count - 2 ;
}

@end