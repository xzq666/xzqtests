//
//  RCAnnotationView.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RCLocationView.h"

@protocol RCAnnotationViewProtocol <NSObject>

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView;
- (void)didDeselectAnnotationViewInMap:(MKMapView *)mapView;

@end

@interface RCAnnotationView : MKAnnotationView <RCAnnotationViewProtocol> {
    
}

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImageView *locationImageView;
//@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, copy) TapActionBlock tapBlock;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation;
//- (void)refreshHead:(NSString *)imageUrl;

@end