//
//  MyComposeViewController.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@class MyComposeViewController;
@interface MyComposeViewController : UIViewController

@property (nonatomic , strong) HomeViewController *homeVc;
@property (nonatomic , assign) NSString *source;
@property (nonatomic , strong) AVObject *object;
@property (nonatomic , strong) MyComposeViewController* commentVc;

@end