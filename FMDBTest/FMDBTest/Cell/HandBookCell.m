//
//  HandBookCell.m
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "HandBookCell.h"

@implementation HandBookCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.view = [[UIView alloc] initWithFrame:CGRectMake(4, 8, [UIScreen mainScreen].bounds.size.width/4-8, ([UIScreen mainScreen].bounds.size.width/4-8)*1.25)];
        [self addSubview:self.view];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width/4-8, [UIScreen mainScreen].bounds.size.width/4-8, ([UIScreen mainScreen].bounds.size.width/4-8)*0.25)];
        [self.view addSubview:self.label];
        
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/4-8, [UIScreen mainScreen].bounds.size.width/4-8)];
        [self.view addSubview:self.img];
        
        self.star = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, [UIScreen mainScreen].bounds.size.width/4-12, ([UIScreen mainScreen].bounds.size.width/4-8)*0.25)];
        [self.view addSubview:self.star];
    }
    return self;
}

@end