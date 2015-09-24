//
//  MyStatusPhotosView.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStatusPhotosView : UIImageView

@property(nonatomic , strong) NSArray *picUrls;

//根据图片个数计算尺寸
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
