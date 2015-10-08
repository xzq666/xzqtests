//
//  RCDSelectPersonViewController.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDAddressBookViewController.h"
@class RCDUserInfo;

@interface RCDSelectPersonViewController : RCDAddressBookViewController<UIActionSheetDelegate>

typedef void(^clickDone)(RCDSelectPersonViewController *selectPersonViewController, NSArray *seletedUsers);

@property (nonatomic,copy) clickDone clickDoneCompletion;

@end