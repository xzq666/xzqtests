//
//  KCStatusTableViewCell.h
//  SinaTest
//
//  Created by 许卓权 on 15/7/2.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KCStatus;

@interface KCStatusTableViewCell : UITableViewCell

#pragma mark 微博对象
@property (nonatomic,strong) KCStatus *status;

#pragma mark 单元格高度
@property (assign,nonatomic) CGFloat height;

@end