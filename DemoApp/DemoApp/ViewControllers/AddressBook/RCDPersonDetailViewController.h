//
//  RCDPersonDetailViewController.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMLib/RCUserInfo.h>

@interface RCDPersonDetailViewController : UIViewController

//对方ID
@property (nonatomic,strong) RCUserInfo *userInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *ivAva;

@end