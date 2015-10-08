//
//  RCDMeDetailTableViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/8.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDMeDetailTableViewController.h"
#import "UIColor+RCColor.h"
#import <RongIMLib/RongIMLib.h>
#import "RCDRCIMDataSource.h"
#import "AFNetworking.h"

@interface RCDMeDetailTableViewController () {
    NSString *userId;
}

@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentUserNickNameLabel;

@end

@implementation RCDMeDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[UIView new];
    //设置分割线颜色
    self.tableView.separatorColor = [UIColor colorWithHexString:@"dfdfdf" alpha:1.0f];
    self.currentUserNameLabel.text = [RCIMClient sharedRCIMClient].currentUserInfo.name;
    userId = @"";
    [[RCDRCIMDataSource shareInstance]getUserInfoWithUserId:[RCIMClient sharedRCIMClient].currentUserInfo.userId completion:^(RCUserInfo *userInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"is %@",userInfo.name);
            userId = userInfo.userId;
            self.currentUserNickNameLabel.text=userInfo.name;
        });
    }];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"0");
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        NSString *url = @"http://webim.demo.rong.io/update_profile";
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:userId, @"userId", @"皮卡丘爆炸了", @"username", nil];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.requestSerializer.HTTPShouldHandleCookies = YES;
        [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"result: %@",operation.responseString);
            if (operation.response.statusCode == 200) {
                NSLog(@"正常");
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"-->%@",operation.responseString);
            NSLog(@"error-->%@",error);
        }];
    }
}

@end