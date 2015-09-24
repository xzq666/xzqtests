//
//  MyStatusRetweetedFrame.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusRetweetedFrame.h"
#import "MyStatusPhotosView.h"
#import "MyStatus.h"

@implementation MyStatusRetweetedFrame

- (void)setRetweetedStatus:(MyStatus *)retweetedStatus {
    _retweetedStatus = retweetedStatus;
    // 1.昵称
    //    CGFloat nameX = SWStatusCellInset;
    //    CGFloat nameY = SWStatusCellInset * 0.5;
    //    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    //    CGSize nameSize = [name sizeWithFont:SWStatusRetweetedNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = MyStatusCellInset;
    CGFloat textY = MyStatusCellInset * 0.5;
    CGFloat maxW = MyScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    // 5.配图相册
    CGFloat h = 0;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + MyStatusCellInset;
        CGSize photosSize = [MyStatusPhotosView sizeWithPhotosCount:(int)retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        h = CGRectGetMaxY(self.photosFrame) + MyStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + MyStatusCellInset;
    }
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = MyScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
}

@end