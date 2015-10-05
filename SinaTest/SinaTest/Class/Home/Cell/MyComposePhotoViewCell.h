//
//  MyComposePhotoViewCell.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKAssets.h"

@interface MyComposePhotoViewCell : UICollectionViewCell

@property (nonatomic , strong) JKAssets *asset;
@property (nonatomic , weak) UIButton *deletePhotoButton;
@property (nonatomic , strong) NSIndexPath *indexpath;
@property (nonatomic , strong) UIImageView *imageView;

@end