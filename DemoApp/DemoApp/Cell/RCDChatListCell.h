//
//  RCDChatListCell.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface RCDChatListCell : RCConversationBaseCell

@property (nonatomic,strong) UIImageView *ivAva;
@property (nonatomic,strong) UILabel *lblName;
@property (nonatomic,strong) UILabel *lblDetail;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, strong) UILabel *labelTime;

@end