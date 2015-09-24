//
//  MyStatusDetailFrame.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusDetailFrame.h"
#import "MyStatusOriginalFrame.h"
#import "MyStatus.h"
#import "MyStatusRetweetedFrame.h"

@implementation MyStatusDetailFrame

- (void)setStatus:(MyStatus *)status {
    _status = status;
    // 1.计算原始Feed的frame
    MyStatusOriginalFrame *originalFrame = [[MyStatusOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    // 2.计算转发Feed的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        MyStatusRetweetedFrame *retweetedFrame = [[MyStatusRetweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(retweetedFrame.frame);
        retweetedFrame.frame = f;
        self.retweetedFrame = retweetedFrame;
        h = CGRectGetMaxY(retweetedFrame.frame);
    }else{
        h = CGRectGetMaxY(originalFrame.frame);
    }
    // 自己的frame
    CGFloat x = 0;
    CGFloat y = MyStatusCellMargin;
    CGFloat w = MyScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
}

@end