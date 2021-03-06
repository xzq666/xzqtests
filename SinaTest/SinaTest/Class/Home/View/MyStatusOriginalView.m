//
//  MyStatusOriginalView.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusOriginalView.h"
#import "MyStatusOriginalFrame.h"
#import "MyStatus.h"
#import "MyUser.h"
#import "UIImageView+WebCache.h"
#import "MyStatusPhotosView.h"
#import "MyStatusLabel.h"
#import "MyStatusUserHeadView.h"

@interface MyStatusOriginalView()

// 昵称
@property (nonatomic , weak) UILabel *nameLabel;
// 正文
@property (nonatomic , weak) MyStatusLabel *textLabel;
//来源
@property (nonatomic , weak) UILabel *sourceLabel;
//时间
@property (nonatomic ,weak) UILabel *timeLabel;
//头像
@property (nonatomic ,weak) MyStatusUserHeadView *iconView;
//会员图标
@property (nonatomic , weak) UIImageView *vipView;
//更多图标
@property (nonatomic , weak) UIButton *moreBtn;
//配图
@property (nonatomic ,weak) MyStatusPhotosView *photosView;

@end

@implementation MyStatusOriginalView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.opaque = YES;
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = MyStatusOriginalNameFont;
        //nameLabel.text = self.originalFrame.status.user.name;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        // 2.正文
        MyStatusLabel *textLabel = [[MyStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = MyColor(242, 153, 92);
        timeLabel.font = MyStatusOriginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.textColor = MyColor(113, 113, 113);
        sourceLabel.font = MyStatusOriginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        // 5.头像
        MyStatusUserHeadView *iconView = [[MyStatusUserHeadView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        // 7.显示更多按钮
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
        [moreBtn addTarget:self action:@selector(moreBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        self.moreBtn = moreBtn;
        moreBtn.adjustsImageWhenDisabled = NO;
        [self addSubview:moreBtn];
        // 8.配图
        MyStatusPhotosView *photosView = [[MyStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setOriginalFrame:(MyStatusOriginalFrame *)originalFrame {
    _originalFrame = originalFrame;
    self.frame = originalFrame.frame;
    //取出数据
    MyStatus *status = originalFrame.status;
    //取出用户数据
    MyUser *user = status.user;
    // 1.昵称
    self.nameLabel.text = user.username;
    self.nameLabel.frame = originalFrame.nameFrame;
    //会员
    // 2.正文
    self.textLabel.attributedText = status.attributedText;
    self.textLabel.frame = originalFrame.textFrame;
    // 3.时间
    NSString *time = status.created_at;
    self.timeLabel.text = time;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + MyStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithFont:MyStatusOriginalTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    // 4.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + MyStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:MyStatusOriginalSourceFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    // 5.头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    // 6.更多按钮
    self.moreBtn.frame = originalFrame.moreFrame;
    // 7.配图
    if (status.pic_urls.count){
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.picUrls = status.pic_urls;
        self.photosView.hidden = NO;
    } else{
        self.photosView.hidden = YES;
    }
}

- (void)moreBtnOnClick{
    //利用通知发送更多按钮被点击：挣对于多层次需要传递数据
    [[NSNotificationCenter defaultCenter] postNotificationName:MyStatusOriginalDidMoreNotication object:nil];
}

@end