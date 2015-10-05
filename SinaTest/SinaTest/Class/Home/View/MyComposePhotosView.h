//
//  MyComposePhotosView.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyComposePhotosView : UIView

@property (nonatomic , retain) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *assetsArray;
@property (nonatomic , strong) UIButton *addButton;
@property (nonatomic , strong) NSArray *selectedPhotos;

@end