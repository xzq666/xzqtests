//
//  MyTabBar.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTabBar;

@protocol MyTabBarDelegate <NSObject>

@optional

- (void)tabBarDidClickedPlusButton:(MyTabBar *)tabBar;

@end

@interface MyTabBar : UITabBar

@property (nonatomic , weak) id<MyTabBarDelegate> tabBarDelegate;

@end