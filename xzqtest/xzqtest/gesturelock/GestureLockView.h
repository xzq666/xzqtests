//
//  GestureLockView.h
//  xzqtest
//
//  Created by 许卓权 on 15/9/16.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GestureLockView;

@protocol GestureLockDelegate <NSObject>

@optional

- (void)GestureLockSetResult:(NSString *)result gestureView:(GestureLockView *)gestureView;
- (void)GestureLockPasswordRight:(GestureLockView *)gestureView;
- (void)GestureLockPasswordWrong:(GestureLockView *)gestureView;

@end

@interface GestureLockView : UIView

@property (assign, nonatomic) id<GestureLockDelegate> delegate;

- (void)setRigthResult:(NSString *)rightResult;

@end