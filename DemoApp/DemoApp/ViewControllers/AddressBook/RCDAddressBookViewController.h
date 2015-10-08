//
//  RCDAddressBookViewController.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCDAddressBookViewController : UITableViewController

@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSMutableDictionary *allFriends;
@property (nonatomic,strong) NSArray *allKeys;
@property (nonatomic,strong) NSArray *seletedUsers;
@property (nonatomic,assign) BOOL hideSectionHeader;

@end