//
//  RCDAddFriendViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDAddFriendViewController.h"
#import "RCDHttpTool.h"
#import "UIImageView+WebCache.h"

@interface RCDAddFriendViewController ()

@end

@implementation RCDAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lblName.text = self.targetUserInfo.name;
    [self.ivAva sd_setImageWithURL:[NSURL URLWithString:self.targetUserInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"icon_person"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionAddFriend:(id)sender {
    [RCDHTTPTOOL requestFriend:_targetUserInfo.userId complete:^(BOOL result) {
        if (result) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请求已发送" delegate:nil
                                                      cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}

@end