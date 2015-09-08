//
//  HandBookCell.h
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandBookCell : UICollectionViewCell

@property(nonatomic,strong) UIView *view; //承载框
@property(nonatomic,strong) UILabel *star; //图鉴星级
@property(nonatomic,strong) UIImageView *img; //图鉴图片
@property(nonatomic,strong) UILabel *label; //图鉴文字

@end