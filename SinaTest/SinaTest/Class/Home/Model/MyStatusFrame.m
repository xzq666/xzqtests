//
//  MyStatusFrame.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusFrame.h"
#import "MyStatusDetailFrame.h"

@implementation MyStatusFrame

- (void)setStatus:(MyStatus *)status {
    _status = status;
    [self setupStatusDetailFrame];
    [self setupStatusToolbarFrame];
    self.cellHeight = CGRectGetMaxY(self.statusToolbarFrame);
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = MyScreenWidth;
    CGFloat h = CGRectGetMaxY(self.statusToolbarFrame);
    self.frame = CGRectMake(x,y, w, h);
}

//计算feed整体frame
- (void)setupStatusDetailFrame {
    MyStatusDetailFrame *detailFrame = [[MyStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    self.statusDetailFrame = detailFrame;
}

//计算工具条整体frame
- (void)setupStatusToolbarFrame {
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.statusDetailFrame.frame);
    CGFloat toolbarW = MyScreenWidth;
    CGFloat toolbarH = MyStatusToolbarWidth;
    self.statusToolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end