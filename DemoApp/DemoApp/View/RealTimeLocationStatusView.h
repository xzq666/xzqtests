//
//  RealTimeLocationStatusView.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMLib/RongIMLib.h>

@protocol RealTimeLocationStatusViewDelegate <NSObject>

- (void)onJoin;
- (void)onShowRealTimeLocationView;
- (RCRealTimeLocationStatus)getStatus;

@end

@interface RealTimeLocationStatusView : UIView

@property (nonatomic, weak)id<RealTimeLocationStatusViewDelegate> delegate;

- (void)updateText:(NSString *)statusText;
- (void)updateRealTimeLocationStatus;

@end