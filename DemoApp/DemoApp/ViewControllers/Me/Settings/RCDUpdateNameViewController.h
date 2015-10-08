//
//  RCDUpdateNameViewController.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^setDisplayText)(NSString *text);

@interface RCDUpdateNameViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (nonatomic,copy) NSString *targetId;
@property (nonatomic,copy) NSString *displayText;
@property (nonatomic,copy) setDisplayText setDisplayTextCompletion;

@end