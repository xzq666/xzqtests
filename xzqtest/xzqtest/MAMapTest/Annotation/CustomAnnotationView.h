//
//  CustomAnnotationView.h
//  xzqtest
//
//  Created by 许卓权 on 15/10/26.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end