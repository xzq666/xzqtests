//
//  CDStatusTableViewCell.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDStatus;

@interface CDStatusTableViewCell : UITableViewCell

#pragma mark 微博对象
@property (nonatomic,strong) CDStatus *status;

#pragma mark 单元格高度
@property (assign,nonatomic) CGFloat height;

@end