//
//  MyCommentCellFrame.h
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyComment;
@class MyCommentDetailFrame;

@interface MyCommentCellFrame : NSObject

@property (nonatomic , strong) MyComment *commentData;
@property (nonatomic , strong) MyCommentDetailFrame *commentDetailFrame;
@property (nonatomic , assign) CGFloat cellHeight;

@end