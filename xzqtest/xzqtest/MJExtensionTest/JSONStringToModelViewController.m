//
//  JSONStringToModelViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/20.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "JSONStringToModelViewController.h"
#import "User.h"

@interface JSONStringToModelViewController ()

@end

@implementation JSONStringToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"JSON字符串转模型";
    
    NSString *jsonString = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20}";
    NSLog(@"-->%@", jsonString);
    User *user = [User objectWithKeyValues:jsonString];
    NSLog(@"name=%@,icon=%@,age=%d", user.name, user.icon, user.age);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end