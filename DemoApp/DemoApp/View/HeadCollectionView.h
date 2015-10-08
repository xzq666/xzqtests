//
//  HeadCollectionView.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

#pragma mark delegate
@protocol HeadCollectionTouchDelegate <NSObject>

- (void)onUserSelected:(RCUserInfo *)user atIndex:(NSUInteger)index;

@optional

-(BOOL)quitButtonPressed;
-(BOOL)backButtonPressed;

@end

@interface HeadCollectionView : UIView

@property (nonatomic, strong) UIButton *quitButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) RCUserAvatarStyle avatarStyle;
@property (nonatomic, weak) id<HeadCollectionTouchDelegate> touchDelegate;

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame
                 participants:(NSArray *)userIds
                touchDelegate:touchDelegate;

- (instancetype)initWithFrame:(CGRect)frame
                 participants:(NSArray *)userIds
                touchDelegate:touchDelegate
              userAvatarStyle:(RCUserAvatarStyle)avatarStyle;

#pragma mark user source processing
- (BOOL)participantJoin:(NSString *)userId;
- (BOOL)participantQuit:(NSString *)userId;
- (NSArray *)getParticipantsUserInfo;

@end