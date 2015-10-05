//
//  MyLoadMoreFooter.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyLoadMoreFooter.h"

@interface MyLoadMoreFooter()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@end

@implementation MyLoadMoreFooter

+ (instancetype)footer {
    return [[[NSBundle mainBundle] loadNibNamed:@"MyLoadMoreFooter" owner:nil options:nil] lastObject];
}

- (void)beginRefreshing {
    self.statusLabel.text = @"正在拼命加载数据...";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

-(void)endRefreshing {
    self.statusLabel.text = @"没有更多数据了";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}

@end