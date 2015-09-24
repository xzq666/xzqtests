//
//  MyStatusPhotoView.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatusPhotoView.h"
#import "MyPhoto.h"
#import "UIImageView+WebCache.h"

@interface MyStatusPhotoView()

@property (nonatomic , weak) UIImageView *gifView;

@end

@implementation MyStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.opaque = YES;
        //添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(NSString *)photo {
    _photo = photo;
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    // 2.添加gif图标显示
    NSString *extension = photo.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end