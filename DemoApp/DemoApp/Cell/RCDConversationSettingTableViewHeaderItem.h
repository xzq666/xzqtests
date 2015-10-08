//
//  RCDConversationSettingTableViewHeaderItem.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RCDConversationSettingTableViewHeaderItemDelegate;

@interface RCDConversationSettingTableViewHeaderItem : UICollectionViewCell

@property(nonatomic, strong) UIImageView *ivAva;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *btnImg;
@property(nonatomic, copy) NSString *userId;
@property(nonatomic, weak) id<RCDConversationSettingTableViewHeaderItemDelegate> delegate;

@end

@protocol RCDConversationSettingTableViewHeaderItemDelegate <NSObject>

- (void)deleteTipButtonClicked:(RCDConversationSettingTableViewHeaderItem *)item;

@end