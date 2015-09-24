//
//  MyStatusOriginalFrame.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusOriginalFrame.h"
#import "MyStatusPhotosView.h"
#import "MyStatus.h"
#import "MyUser.h"

@implementation MyStatusOriginalFrame

- (void)setStatus:(MyStatus *)status {
    _status = status;
    // 1.头像
    CGFloat iconX = MyStatusCellInset;
    CGFloat iconY = MyStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + MyStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.username sizeWithFont:MyStatusOriginalNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.nameFrame = (CGRect){ {nameX , nameY} , nameSize };
    // 3.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + MyStatusCellInset;
    CGFloat maxW = MyScreenWidth - 2 *textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX , textY} , textSize };
    // 4.更多图标计算
    UIImage *moreImage = [UIImage imageNamed:@"timeline_icon_more"];
    CGFloat moreW = moreImage.size.width;
    CGFloat moreX = MyScreenWidth - MyStatusCellInset - moreW;
    CGFloat moreY = iconY;
    CGFloat moreH = moreImage.size.height;
    self.moreFrame = CGRectMake(moreX, moreY, moreW, moreH);
    // 5.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + MyStatusCellInset;
        CGSize photosSize = [MyStatusPhotosView sizeWithPhotosCount:(int)status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        h = CGRectGetMaxY(self.photosFrame) + MyStatusCellInset;
    }else{
        h = CGRectGetMaxY(self.textFrame) + MyStatusCellInset;
    }
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = MyScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
}

@end