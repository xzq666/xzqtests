//
//  MyCommentCellTableViewCell.h
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyCommentCellFrame;
@class MyCommentDetailView;

@interface MyCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic , strong) MyCommentCellFrame *commentFrame;
@property (nonatomic , weak) MyCommentDetailView *commentDetailView;
@property (nonatomic , strong) NSIndexPath *indexpath;

@end