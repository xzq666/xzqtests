//
//  RCAnnotation.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "RCLocationView.h"
#import "RCAnnotationView.h"

@protocol RCAnnotationProtocol <NSObject>

- (MKAnnotationView *)annotationViewInMap:(MKMapView *)mapView;

@end

@interface RCAnnotation : NSObject <MKAnnotation, RCAnnotationProtocol>

@property (nonatomic, strong) RCAnnotationView *view;
@property (nonatomic, strong) RCLocationView *thumbnail;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (id)initWithThumbnail:(RCLocationView *)thumbnail;
- (void)updateThumbnail:(RCLocationView *)thumbnail animated:(BOOL)animated;

@end