//
//  JSONArrToModelArrViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/21.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "JSONArrToModelArrViewController.h"
#import "User.h"

@interface JSONArrToModelArrViewController ()

@end

@implementation JSONArrToModelArrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"字典数组转模型数组";
    
    NSArray *dictArr = @[
                         @{
                                @"name" : @"Jack",
                                @"icon" : @"lufy.png"
                             },
                         @{
                                @"name" : @"Rose",
                                @"icon" : @"nami.png"
                             }
                         ];
    NSArray *userArr = [User objectArrayWithKeyValuesArray:dictArr];
    for (User *user in userArr) {
        NSLog(@"name=%@, icon=%@", user.name, user.icon);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end