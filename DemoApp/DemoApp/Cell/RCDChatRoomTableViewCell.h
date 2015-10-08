//
//  RCDChatRoomTableViewCell.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCDChatRoomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbChatroom;
@property (weak, nonatomic) IBOutlet UIImageView *ivChatRoomPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;

@end