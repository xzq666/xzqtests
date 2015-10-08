//
//  RCLocationView.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef void (^TapActionBlock)();

@interface RCLocationView : NSObject

@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) BOOL isMyLocation;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) TapActionBlock tapBlock;

@end