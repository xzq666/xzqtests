//
//  RCDSelectPersonTableViewCell.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDSelectPersonTableViewCell.h"

@implementation RCDSelectPersonTableViewCell

- (void)awakeFromNib {
    self.ivAva.clipsToBounds = YES;
    self.ivAva.layer.cornerRadius = 8.f;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        _ivSelected.image = [UIImage imageNamed:@"select"];
    }else{
        _ivSelected.image = [UIImage imageNamed:@"unselect"];
    }
}

@end