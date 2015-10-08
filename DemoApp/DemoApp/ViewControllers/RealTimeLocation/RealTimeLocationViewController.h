//
//  RealTimeLocationViewController.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

/**
 * 位置选取视图控制器
 */
@interface RealTimeLocationViewController : UIViewController

@property (nonatomic, weak)id<RCRealTimeLocationProxy> realTimeLocationProxy;

@end