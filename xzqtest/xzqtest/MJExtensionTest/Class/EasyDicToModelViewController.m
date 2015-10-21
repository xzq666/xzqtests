//
//  EasyDicToModelViewController.m
//  xzqtest
//  最简单的字典转模型
//  Created by 许卓权 on 15/10/20.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "EasyDicToModelViewController.h"
#import "User.h"

@interface EasyDicToModelViewController ()

@end

@implementation EasyDicToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"简单字典转模型";
    
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @1.60,
                           @"weight" : @46,
                           @"money" : @100.9,
                           @"sex" : @(SexFemale),
                           @"gay" : @"true"
                           };
    NSLog(@"dic-->%@",dict);
    // JSON -> User
    User *user = [User objectWithKeyValues:dict];
    NSLog(@"name=%@, icon=%@, age=%zd, height=%.2f, weight=%.2f, money=%@, sex=%d, gay=%d", user.name, user.icon, user.age, user.height, user.weight, user.money, user.sex, user.gay);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end