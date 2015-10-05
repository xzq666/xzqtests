//
//  MyStatusRetweetedView.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusRetweetedView.h"
#import "MyStatusRetweetedFrame.h"
#import "MyStatus.h"
#import "MyStatusPhotosView.h"
#import "MyStatusLabel.h"

@interface MyStatusRetweetedView()

@property (nonatomic ,strong) MyStatusLabel *textLabel;
@property (nonatomic , strong) MyStatusPhotosView *photosView;

@end

@implementation MyStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableImageWithName:@"timeline_retweet_background"];
        
        
        MyStatusLabel *textLabel = [[MyStatusLabel alloc] init];
        //textLabel.textColor = SWColor(129, 129, 129);
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        // 3.配图相册
        MyStatusPhotosView *photosView = [[MyStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setRetweetedFrame:(MyStatusRetweetedFrame *)retweetedFrame {
    self.frame = retweetedFrame.frame;
    // 取出微博数据
    MyStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    // 取出用户数据
    //    SWUser *user = retweetedStatus.user;
    //1.设置昵称的frame
    //    self.nameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    //    self.nameLabel.frame = retweetedFrame.nameFrame;
    //2.设置转发正文的内容和frame
    self.textLabel.attributedText = retweetedStatus.attributedText;
    self.textLabel.frame = retweetedFrame.textFrame;
    // 3.配图相册
    if (retweetedStatus.pic_urls.count) { // 有配图
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.picUrls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
}

@end