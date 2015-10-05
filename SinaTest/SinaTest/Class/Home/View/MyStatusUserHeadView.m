//
//  MyStatusUserHeadView.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusUserHeadView.h"

@interface MyStatusUserHeadView()

@property (nonatomic ,weak) UIImageView *verifiedImageView;

@end

@implementation MyStatusUserHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *verifiedImageView = [[UIImageView alloc] init];
        [self addSubview:verifiedImageView];
        _verifiedImageView = verifiedImageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIImage *vipImage = [UIImage imageNamed:@"avatar_vip"];
    _verifiedImageView.center = CGPointMake(self.width, self.height);
    _verifiedImageView.width = vipImage.size.width - 1;
    _verifiedImageView.height = vipImage.size.height - 1;
}

//添加验证图片
- (void)addVIPImageWithVerified:(NSString *)verified verifiedType:(int)verifiedType {
    UIImage *vipImage;
    _verifiedImageView.hidden = YES;
    if (verified.intValue == 0)return;
    _verifiedImageView.hidden = NO;
    if (verifiedType == 0) {//个人认证
        vipImage = [UIImage imageNamed:@"avatar_vip"];
    }
    if (verifiedType == 3) {//企业认证
        vipImage = [UIImage imageNamed:@"avatar_enterprise_vip"];
    }
    _verifiedImageView.image = vipImage;
}

@end