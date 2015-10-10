//
//  MyCommentCellFrame.m
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyCommentCellFrame.h"
#import "MyCommentDetailFrame.h"
#import "MyComment.h"

@implementation MyCommentCellFrame

- (void)setCommentData:(MyComment *)commentData {
    _commentData = commentData;
    [self setupDetailFrame];
    self.cellHeight = CGRectGetMaxY(self.commentDetailFrame.frame);
}

- (void)setupDetailFrame {
    MyCommentDetailFrame *detailFrame = [[MyCommentDetailFrame alloc] init];
    detailFrame.commentData = self.commentData;
    self.commentDetailFrame = detailFrame;
}

@end