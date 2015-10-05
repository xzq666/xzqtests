//
//  RCAnimatedImagesView.h
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kJSAnimatedImagesViewDefaultTimePerImage 20.0f

@protocol RCAnimatedImagesViewDelegate;

@interface RCAnimatedImagesView : UIView

@property (nonatomic, assign) id<RCAnimatedImagesViewDelegate> delegate;

@property (nonatomic, assign) NSTimeInterval timePerImage;

- (void)startAnimating;
- (void)stopAnimating;

- (void)reloadData;

@end

@protocol RCAnimatedImagesViewDelegate

- (NSUInteger)animatedImagesNumberOfImages:(RCAnimatedImagesView *)animatedImagesView;
- (UIImage *)animatedImagesView:(RCAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index;

@end