//
//  RCDChatRoomTableViewCell.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDChatRoomTableViewCell.h"

@implementation RCDChatRoomTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.ivChatRoomPortrait.layer.cornerRadius     =   4;
        self.ivChatRoomPortrait.layer.masksToBounds    =   YES;
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end