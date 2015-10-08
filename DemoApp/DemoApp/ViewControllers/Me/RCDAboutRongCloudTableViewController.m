//
//  RCDAboutRongCloudTableViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDAboutRongCloudTableViewController.h"
#import "SVWebViewController.h"

@interface RCDAboutRongCloudTableViewController()

@property (nonatomic, strong)NSArray *urls;

@end

@implementation RCDAboutRongCloudTableViewController

- (void)viewDidLoad {
    self.tableView.tableFooterView=[UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *url = [self getUrlAt:indexPath];
    if (url) {
//        [[UIApplication sharedApplication]openURL:[self getUrlAt:indexPath]];
        SVWebViewController *webC = [[SVWebViewController alloc] initWithAddress:[NSString stringWithFormat:@"%@",[self getUrlAt:indexPath]]];
        [self.navigationController pushViewController:webC animated:YES];
    }
}

- (NSArray *)urls {
    if (!_urls) {
        NSArray *section0 = [NSArray arrayWithObjects:@"http://rongcloud.cn/", @"http://rongcloud.cn/downloads/history/ios", @"http://rongcloud.cn/features", @"http://docs.rongcloud.cn/api/ios/imkit/index.html", nil];
        NSArray *section1 = [NSArray arrayWithObjects:@"http://rongcloud.cn/", nil];
        _urls = [NSArray arrayWithObjects:section0, section1, nil];
    }
    return _urls;
}

- (NSURL *)getUrlAt:(NSIndexPath *)indexPath {
    NSArray *section = self.urls[indexPath.section];
    NSString *urlString = section[indexPath.row];
    if (!urlString.length) {
        return nil;
    }
    return [NSURL URLWithString:urlString];
}

@end