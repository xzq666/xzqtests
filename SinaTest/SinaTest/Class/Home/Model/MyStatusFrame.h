//
//  MyStatusFrame.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyStatus;
@class MyStatusDetailFrame;

@interface MyStatusFrame : NSObject

//Feed模型
@property (nonatomic , strong) MyStatus *status;
//Feed detail frame
@property (nonatomic , strong) MyStatusDetailFrame *statusDetailFrame;
//工具条frame
@property (nonatomic , assign) CGRect statusToolbarFrame;
//cell高度
@property (nonatomic , assign) CGFloat cellHeight;
//cell frame
@property (nonatomic , assign) CGRect frame;

@end