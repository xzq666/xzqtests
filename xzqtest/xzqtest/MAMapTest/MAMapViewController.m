//
//  MAMapViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/25.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "MAMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "CustomAnnotationView.h"

@interface MAMapViewController () <MAMapViewDelegate> {
    MAMapView *_mapView;
}

@end

@implementation MAMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"高德地图";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加地图视图
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64)];
    [_mapView setZoomLevel:16.0 animated:YES];
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动
    _mapView.delegate = self; //设置代理
    [self.view addSubview:_mapView];
    
    //添加大头针标注
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.289631, 120.001018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    [_mapView addAnnotation:pointAnnotation];
    
    //添加大头针标注
    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
    pointAnnotation2.coordinate = CLLocationCoordinate2DMake(30.287999, 119.998018);
    pointAnnotation2.title = @"未知";
    pointAnnotation2.subtitle = @"不知道是哪里";
    [_mapView addAnnotation:pointAnnotation2];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        if ([annotation.title isEqualToString:@"方恒国际"]) {
            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
            CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
            if (annotationView == nil) {
                annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            }
            annotationView.image = [UIImage imageNamed:@"car"];
            // 设置为NO，用以调用自定义的calloutView
            annotationView.canShowCallout = NO;
            // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -18);
            annotationView.tag = 100;
            return annotationView;
        } else {
            static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
            MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            }
            annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
            //        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
            annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
            //        annotationView.pinColor = MAPinAnnotationColorPurple;
            annotationView.image = [UIImage imageNamed:@"car"];
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -18);
            annotationView.tag = 200;
            return annotationView;
        }
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if(updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end