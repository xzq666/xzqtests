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
#import "PhotoSelectViewController.h"
#import "TextImageViewController.h"
#import "GestureLock.h"
#import "JSPatchViewController.h"
#import "MasonryViewController.h"

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
    
    UIButton *photoselect = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [photoselect setTitle:@"照片选择" forState:UIControlStateNormal];
    [photoselect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    photoselect.layer.masksToBounds = YES;
    photoselect.layer.borderWidth = 0.5;
    photoselect.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 140, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [photoselect addTarget:self action:@selector(photoselectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoselect];
    
    UIButton *textimg = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [textimg setTitle:@"图文混排" forState:UIControlStateNormal];
    [textimg setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    textimg.layer.masksToBounds = YES;
    textimg.layer.borderWidth = 0.5;
    textimg.frame = CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [textimg addTarget:self action:@selector(textimgClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:textimg];
    
    UIButton *gesturelock = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [gesturelock setTitle:@"手势解锁" forState:UIControlStateNormal];
    [gesturelock setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    gesturelock.layer.masksToBounds = YES;
    gesturelock.layer.borderWidth = 0.5;
    gesturelock.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 200, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [gesturelock addTarget:self action:@selector(gesturelockClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gesturelock];
    
    UIButton *jspatch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [jspatch setTitle:@"JSPatch应用" forState:UIControlStateNormal];
    [jspatch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jspatch.layer.masksToBounds = YES;
    jspatch.layer.borderWidth = 0.5;
    jspatch.frame = CGRectMake(10, 260, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [jspatch addTarget:self action:@selector(jspatchClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jspatch];
    
    UIButton *masonry = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [masonry setTitle:@"Masonry自动布局" forState:UIControlStateNormal];
    [masonry setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    masonry.layer.masksToBounds = YES;
    masonry.layer.borderWidth = 0.5;
    masonry.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 260, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [masonry addTarget:self action:@selector(masonryClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:masonry];
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

- (void)textimgClick {
    TextImageViewController *textimageController = [[TextImageViewController alloc] init];
    [self.navigationController pushViewController:textimageController animated:YES];
}

- (void)photoselectClick {
    PhotoSelectViewController *vc = [[PhotoSelectViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gesturelockClick {
    GestureLock *vc = [[GestureLock alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jspatchClick {
    JSPatchViewController *vc = [[JSPatchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)masonryClick {
    MasonryViewController *vc = [[MasonryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end