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
#import "MJExtensionViewController.h"
#import "MBProgressHUDViewController.h"
#import "MJPhotoBrowserTestViewController.h"
#import "WeChatWebViewViewController.h"
#import "AppDelegate.h"
#import "MAMapViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; 
    
    _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [_menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [_menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_menuBtn];
    
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
    
    UIButton *extension = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [extension setTitle:@"MJExtension测试" forState:UIControlStateNormal];
    [extension setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    extension.layer.masksToBounds = YES;
    extension.layer.borderWidth = 0.5;
    extension.frame = CGRectMake(10, 320, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [extension addTarget:self action:@selector(extensionClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:extension];
    
    UIButton *progressHUD = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progressHUD setTitle:@"MBprogressHUD测试" forState:UIControlStateNormal];
    [progressHUD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progressHUD.layer.masksToBounds = YES;
    progressHUD.layer.borderWidth = 0.5;
    progressHUD.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 320, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progressHUD addTarget:self action:@selector(progressHUDClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progressHUD];
    
    UIButton *mjphotobrowser = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [mjphotobrowser setTitle:@"MJPhotoBrowser测试" forState:UIControlStateNormal];
    [mjphotobrowser setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    mjphotobrowser.layer.masksToBounds = YES;
    mjphotobrowser.layer.borderWidth = 0.5;
    mjphotobrowser.frame = CGRectMake(10, 380, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [mjphotobrowser addTarget:self action:@selector(mjphotobrowserClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mjphotobrowser];
    
    UIButton *wechatWebView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [wechatWebView setTitle:@"微信浏览器返回关闭" forState:UIControlStateNormal];
    [wechatWebView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    wechatWebView.layer.masksToBounds = YES;
    wechatWebView.layer.borderWidth = 0.5;
    wechatWebView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 380, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [wechatWebView addTarget:self action:@selector(wechatWebViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatWebView];
    
    UIButton *maMap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [maMap setTitle:@"高德地图测试" forState:UIControlStateNormal];
    [maMap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    maMap.layer.masksToBounds = YES;
    maMap.layer.borderWidth = 0.5;
    maMap.frame = CGRectMake(10, 440, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [maMap addTarget:self action:@selector(maMapClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:maMap];
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

- (void)extensionClick {
    MJExtensionViewController *vc = [[MJExtensionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)progressHUDClick {
    MBProgressHUDViewController *vc = [[MBProgressHUDViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)mjphotobrowserClick {
    MJPhotoBrowserTestViewController *vc = [[MJPhotoBrowserTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wechatWebViewClick {
    WeChatWebViewViewController *vc = [[WeChatWebViewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) openOrCloseLeftList {
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (tempAppDelegate.LeftSlideVC.closed) {
        [tempAppDelegate.LeftSlideVC openLeftView];
    } else {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    //在离开此页时移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    //在进入此页时添加通知，实现menu按钮的显示隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(open:) name:@"Open" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close:) name:@"Close" object:nil];
}

- (void)open:(NSNotification *)notification {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [_menuBtn.layer addAnimation:animation forKey:nil];
    [_menuBtn setHidden:YES];
}

- (void)close:(NSNotification *)notification {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [_menuBtn.layer addAnimation:animation forKey:nil];
    [_menuBtn setHidden:NO];
}

- (void)maMapClick {
    MAMapViewController *vc = [[MAMapViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end