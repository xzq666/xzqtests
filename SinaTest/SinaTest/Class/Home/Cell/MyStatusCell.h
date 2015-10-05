//
//  MyStatusCell.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyStatusFrame;
@class MyStatusDetailView;

@protocol MyStatusCellDelegate <NSObject>

- (void)didCommentButtonClicked:(UIButton *)button indexPath:(NSIndexPath *)indexpath;
- (void)didLikeButtonClicked:(UIButton *)button indexPath:(NSIndexPath *)indexpath;
- (void)didMessageButtonClicked:(UIButton *)button indexPath:(NSIndexPath *)indexpath;
- (void)didShareButtonClicked:(UIButton *)button indexPath:(NSIndexPath *)indexpath;

@end

@interface MyStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tablView;

@property (nonatomic , strong) MyStatusFrame *statusFrame;
@property (nonatomic , weak) MyStatusDetailView *detailView;
@property (nonatomic , strong) id<MyStatusCellDelegate>delegate;
@property (nonatomic , strong) NSIndexPath *indexpath;

@end