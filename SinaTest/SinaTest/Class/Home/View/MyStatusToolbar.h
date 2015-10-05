//
//  MyStatusToolbar.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyStatus;

@interface MyStatusToolbar : UIImageView

@property (nonatomic , strong) MyStatus *status;
@property (nonatomic , weak) UIButton *repostsBtn;
@property (nonatomic , weak) UIButton *commentsBtn;
@property (nonatomic , weak) UIButton *attitudesBtn;
@property (nonatomic , weak) UIButton *messageBtn;

@end