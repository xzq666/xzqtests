//
//  DSCommentDetailView.m
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyCommentDetailView.h"
#import "MyCommentDetailFrame.h"
#import "MyComment.h"
#import "MyUser.h"
#import "UIImageView+WebCache.h"
#import "MyStatusLabel.h"
#import "MyStatusUserHeadView.h"
#import "MyStatusPhotosView.h"

@interface MyCommentDetailView()

// 昵称
@property (nonatomic , weak) UILabel *nameLabel;
// 正文
@property (nonatomic , weak) MyStatusLabel *textLabel;
//时间
@property (nonatomic ,weak) UILabel *timeLabel;
//头像
@property (nonatomic ,weak) MyStatusUserHeadView *iconView;
//配图
@property (nonatomic ,weak) MyStatusPhotosView *photosView;

@end


@implementation MyCommentDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizableImageWithName:@"timeline_card_top_background_highlighted"];
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = MyStatusOriginalTimeFont;
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
        
        // 4.头像
        MyStatusUserHeadView *iconView = [[MyStatusUserHeadView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 5.配图
        MyStatusPhotosView *photosView = [[MyStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        // 6.分割线
    }
    return self;
}

- (void)setCommentDetailFrame:(MyCommentDetailFrame *)commentDetailFrame {
    _commentDetailFrame = commentDetailFrame;
    self.frame = commentDetailFrame.frame;
    //取出数据
    MyComment *commentData = commentDetailFrame.commentData;
    //取出用户数据
    MyUser *user = commentData.user;
    // 1.昵称
    self.nameLabel.text = user.username;
    self.nameLabel.frame = commentDetailFrame.nameFrame;
    //会员
    // 2.正文
    self.textLabel.attributedText = commentData.attributedText;
    self.textLabel.frame = commentDetailFrame.textFrame;
    // 3.时间
    NSString *time = commentData.created_at;
    self.timeLabel.text = time;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + MyStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithFont:MyStatusOriginalTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    // 4.头像
    self.iconView.frame = commentDetailFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    // 5.配图
    if (commentData.pic_urls.count){
        self.photosView.frame = commentDetailFrame.photosFrame;
        self.photosView.picUrls = commentData.pic_urls;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
}

@end