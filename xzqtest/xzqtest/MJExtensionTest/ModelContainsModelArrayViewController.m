//
//  ModelContainsModelArrayViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/21.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "ModelContainsModelArrayViewController.h"
#import "Status.h"
#import "StatusResult.h"
#import "User.h"
#import "Ad.h"

@interface ModelContainsModelArrayViewController ()

@end

@implementation ModelContainsModelArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"模型中有数组 数组装着其他模型";
    
    // Tell MJExtension what type model will be contained in statuses and ads.
    [StatusResult setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"statuses" : @"Status",
                 // @"statuses" : [Status class],
                 @"ads" : @"Ad"
                 // @"ads" : [Ad class]
                 };
    }];
    // Equals: StatusResult.m implements +objectClassInArray method.
    
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"Nice weather!",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   @{
                                       @"text" : @"Go camping tomorrow!",
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   ],
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.ad02.com"
                                       }
                                   ],
                           @"totalNumber" : @"2014"
                           };
    
    // JSON -> StatusResult
    StatusResult *result = [StatusResult objectWithKeyValues:dict];
    
    NSLog(@"totalNumber=%@", result.totalNumber);
    
    for (Status *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    
    for (Ad *ad in result.ads) {
        NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end