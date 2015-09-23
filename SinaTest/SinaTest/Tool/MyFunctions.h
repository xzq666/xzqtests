//
//  MyFunctions.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FollowType) {
    TypeFollow,
    TypeFollowing,
    TypeFollowed
};

@interface MyFunctions : NSObject {
    CGRect screenRect;
}

#pragma mark - Share Instance
+ (id)sharedObject;

#pragma mark - App Methods

-(UIColor *)colorWithR:(int)red g:(int)green b:(int)blue alpha:(float)alpha;
-(UIImageView *)leftViewForTextFieldWithImage:(NSString *)imageName;
-(BOOL)validateEmail:(NSString *)email;
-(UIView *)showLoadingViewWithText:(NSString *)strMessage inView:(UIView *)view;
-(void)hideLoadingView:(UIView *)loadingView;

-(NSString *)setTimeElapsedForDate:(NSDate *)starDate;

#pragma mark - Resizing image

-(UIImage *)resizeImageWithImage:(UIImage *)image toSize:(CGSize)newSize;

@end