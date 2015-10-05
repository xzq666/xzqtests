//
//  MyStatusDetailView.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusDetailView.h"
#import "MyStatusRetweetedView.h"
#import "MyStatusRetweetedFrame.h"
#import "MyStatusOriginalView.h"
#import "MyStatusOriginalFrame.h"
#import "MyStatusDetailFrame.h"

@interface MyStatusDetailView()

@property (nonatomic , weak) MyStatusRetweetedView *retweetedView;
@property (nonatomic , weak) MyStatusOriginalView *originalView;

@end

@implementation MyStatusDetailView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { // 初始化子控件
        self.image = [UIImage resizableImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizableImageWithName:@"timeline_card_top_background_highlighted"];
        self.opaque = YES;
        // 1.添加原创微博
        [self setupOriginalView];
        
        // 2.添加转发微博
        [self setupRetweetedView];
        
        //能与用户交互
        self.userInteractionEnabled = YES;
    }
    return self;
}


/**
 *  添加原创微博
 */
- (void)setupOriginalView {
    MyStatusOriginalView *originalView = [[MyStatusOriginalView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
}

/**
 *  添加转发微博
 */
- (void)setupRetweetedView {
    MyStatusRetweetedView *retweetedView = [[MyStatusRetweetedView alloc] init];
    [self addSubview:retweetedView];
    self.retweetedView = retweetedView;
}

- (void)setDetailFrame:(MyStatusDetailFrame *)detailFrame {
    _detailFrame = detailFrame;
    self.frame = detailFrame.frame;
    // 1.原创微博的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
    // 2.原创转发的frame数据
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}

@end