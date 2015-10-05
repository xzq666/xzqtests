//
//  MyTabBarController.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyTabBar.h"
#import "MyNavigationController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "MyComposeViewController.h"

@interface MyTabBarController () <MyTabBarDelegate>

@property (nonatomic , weak)HomeViewController *homeViewController;
@property (nonatomic , weak)MessageViewController *messageViewController;
@property (nonatomic , weak)ProfileViewController *profileViewController;

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.添加所有的自控制器
    [self addAllChildVcs];
    //2.创建自定义tabbar
    [self addCustomTabBar];
    //3.设置用户信息未读数 （利用定时器获取用户未读数）
    [self getUnreadCount];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self openClient];
}

- (void)openClient{
//    AVUser *currentUser = [AVUser currentUser];
//    [DSCache registerUser:currentUser];
//    DSIM *im = [DSIM sharedInstance];
//    WEAKSELF
//    [DSUtils showNetworkIndicator];
//    [DSIMConfig config].userDelegate = [DSIMService shareInstance];
//    [im openWithClientId:currentUser.objectId callback:^(BOOL succeeded , NSError *error){
//        [DSUtils hideNetworkIndicator];
//        
//    }];
}

- (void)addAllChildVcs {
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addOneChildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    _homeViewController = home;
    MessageViewController *message = [[MessageViewController alloc] init];
    [self addOneChildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    _messageViewController = message;
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addOneChildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self addOneChildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    _profileViewController = profile;
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
//    childVc.view.backgroundColor = [UIColor whiteColor];
    //设置标题
    childVc.title = title;
//    if ([childVc class] == [DiscoverViewController class]){
//        childVc.navigationItem.title = @"社区";
//    }
    //设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    //设置选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        //声明这张图用原图
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    //添加导航控制器
    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

//创建自定义tabbar
- (void)addCustomTabBar {
    //创建自定义tabbar
    MyTabBar *customTabBar = [[MyTabBar alloc] init];
    customTabBar.tabBarDelegate = self;
    //更换系统自带的tabbar
    [self setValue:customTabBar forKey:@"tabBar"];
}

- (void)getUnreadCount {
    
}

// 在iOS7+中, 会对selectedImage的图片进行再次渲染为蓝色
// 要想显示原图, 就必须得告诉它: 不要渲染
/**
 *  默认只调用该功能一次
 */
+ (void)initialize {
    //设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MyCommonColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

#pragma mark - DSTabBarDelegate
- (void)tabBarDidClickedPlusButton:(MyTabBar *)tabBar {
    // 弹出发微博控制器
    NSLog(@"+");
    MyComposeViewController *compose = [[MyComposeViewController alloc] init];
    compose.source = @"compose";
    compose.homeVc = self.homeViewController;
    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end