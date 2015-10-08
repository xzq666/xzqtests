//
//  RCDGroupTableViewCell.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDGroupTableViewCell.h"
#import "RCDHttpTool.h"
#import "RCDGroupInfo.h"
#import <RongIMKit/RongIMKit.h>

@implementation RCDGroupTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imvGroupPort.layer.masksToBounds = YES;
    _imvGroupPort.layer.cornerRadius = 2.f;
}

- (void)setIsJoin:(BOOL)isJoin {
    if (isJoin) {
        [_btJoin setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
        [_btJoin setImage:[UIImage imageNamed:@"chat_hover"] forState:UIControlStateHighlighted];
    } else {
        [_btJoin setImage:[UIImage imageNamed:@"join"] forState:UIControlStateNormal];
        [_btJoin setImage:[UIImage imageNamed:@"join_hover"] forState:UIControlStateHighlighted];
    }
    _isJoin = isJoin;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)btnJoin:(id)sender {
    __block typeof(self) weakSelf = self;
    if (!self.isJoin) {
        int groupId=[self.groupID intValue];
        [RCDHTTPTOOL joinGroup:groupId complete:^(BOOL isOk) {
             if (_delegate) {
                 if ([self.delegate respondsToSelector:@selector(joinGroupCallback:withGroupId:)]) {
                     [self.delegate joinGroupCallback:isOk withGroupId:weakSelf.groupID];
                 }
             }
         }];
    } else {
        if (_delegate) {
            if ([self.delegate respondsToSelector:@selector(launchGroupChatPageByGroupId:)]) {
                [self.delegate launchGroupChatPageByGroupId:weakSelf.groupID];
            }
        }
    }
}

@end