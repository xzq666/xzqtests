//
//  MyStatusDetailFrame.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyStatus,MyStatusOriginalFrame,MyStatusRetweetedFrame;

@interface MyStatusDetailFrame : NSObject

// 1.自己的frame
@property (nonatomic , assign) CGRect frame;
// 2.数据
@property (nonatomic , strong) MyStatus *status;
// 3.转发Feed frame
@property (nonatomic ,strong) MyStatusRetweetedFrame *retweetedFrame;
// 4.原始Feed frame
@property (nonatomic , strong) MyStatusOriginalFrame *originalFrame;

@end
