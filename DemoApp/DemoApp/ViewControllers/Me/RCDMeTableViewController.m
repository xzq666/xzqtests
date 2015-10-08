//
//  RCDMeTableViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDMeTableViewController.h"
#import "UIColor+RCColor.h"
#import <RongIMLib/RongIMLib.h>
#import "RCDChatViewController.h"
#import "RCDRCIMDataSource.h"

@interface RCDMeTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (nonatomic)BOOL hasNewVersion;
@property (nonatomic)NSString *versionUrl;
@property (nonatomic, strong)NSURLConnection *connection;
@property (nonatomic, strong)NSMutableData *receiveData;
@end

@implementation RCDMeTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //设置为不用默认渲染方式
        self.tabBarItem.image = [[UIImage imageNamed:@"icon_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_me_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.hasNewVersion = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasNewVersion"];
        self.versionUrl= [[NSUserDefaults standardUserDefaults] stringForKey:@"newVersionUrl"];
        [self checkNewVersion];
    }
    return self;
}
#if DEBUG
#define DEMO_VERSION_BOARD @""
#else
#define DEMO_VERSION_BOARD @"http://rongcloud.cn/demo"
#endif

- (void)checkNewVersion {
    long lastCheckTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"lastupdatetimestamp"];
    
    NSDate *now = [[NSDate alloc] init];
    if (now.timeIntervalSince1970 - lastCheckTime > 24*60*60) {
        if (DEMO_VERSION_BOARD.length == 0) {
            return;
        }
        NSURL *url = [NSURL URLWithString:DEMO_VERSION_BOARD];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[UIView new];
    //设置分割线颜色
    self.tableView.separatorColor = [UIColor colorWithHexString:@"dfdfdf" alpha:1.0f];
    self.currentUserNameLabel.text = [RCIMClient sharedRCIMClient].currentUserInfo.name;
    [[RCDRCIMDataSource shareInstance]getUserInfoWithUserId:[RCIMClient sharedRCIMClient].currentUserInfo.userId completion:^(RCUserInfo *userInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.currentUserNickNameLabel.text=userInfo.name;
        });
    }];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont boldSystemFontOfSize:19];
    titleView.textColor = [UIColor whiteColor];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"我";
    self.tabBarController.navigationItem.titleView = titleView;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    [self updateNewVersionBadge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
#define SERVICE_ID @"kefu114"
        RCDChatViewController *chatService = [[RCDChatViewController alloc] init];
        chatService.userName = @"客服";
        chatService.targetId = SERVICE_ID;
        chatService.conversationType = ConversationType_CUSTOMERSERVICE;
        chatService.title = chatService.userName;
        [self.navigationController pushViewController:chatService animated:YES];
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        if (self.hasNewVersion) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.versionUrl]];
            self.hasNewVersion = NO;
            self.versionUrl = nil;
        } else {
            [self checkNewVersion];
        }
    }
}

- (void)setHasNewVersion:(BOOL)hasNewVersion {
    _hasNewVersion = hasNewVersion;
    [[NSUserDefaults standardUserDefaults] setBool:self.hasNewVersion forKey:@"hasNewVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self updateNewVersionBadge];
}

- (void)setVersionUrl:(NSString *)versionUrl {
    _versionUrl = versionUrl;
    [[NSUserDefaults standardUserDefaults] setObject:self.versionUrl forKey:@"newVersionUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
    self.receiveData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDate *now = [[NSDate alloc] init];
    [[NSUserDefaults standardUserDefaults] setInteger:now.timeIntervalSince1970 forKey:@"lastupdatetimestamp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    
    [self compareVersion:receiveStr];
}

#if DEBUG
- (void)compareVersion:(NSString *)receiveStr {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"%@",receiveStr);
    NSRange strRange = NSMakeRange(0, receiveStr.length);
    while (true) {
        NSRange startRange = [receiveStr rangeOfString:@"<a href='itms-services:" options:0 range:strRange];
        if (startRange.location != NSNotFound) {
            NSRange endRange = [receiveStr rangeOfString:@"'>" options:0 range:NSMakeRange(startRange.location + startRange.length, receiveStr.length - startRange.location - startRange.length)];
            NSString *url = [receiveStr substringWithRange:NSMakeRange(startRange.location + 9, endRange.location - startRange.location - 9)];
            NSRange nameEndRange = [receiveStr rangeOfString:@"</a>" options:0 range:NSMakeRange(endRange.location, receiveStr.length - endRange.location)];
            NSString *name = [receiveStr substringWithRange:NSMakeRange(endRange.location+2, nameEndRange.location - endRange.location - 2)];
            
            NSString *model= @"debug";
            NSRange range = [name rangeOfString:model];
            if (range.location != NSNotFound) {
                range = [name rangeOfString:version];
                if (range.location == NSNotFound) {
                    self.hasNewVersion = YES;
                    self.versionUrl = url;
                    break;
                } else {
                    self.hasNewVersion = NO;
                    self.versionUrl = nil;
                    break;
                }
            }
            strRange.location = nameEndRange.location + nameEndRange.length;
            strRange.length = receiveStr.length - strRange.location;
        } else {
            self.hasNewVersion = NO;
            self.versionUrl = nil;
            break;
        }
    }
}

#else

- (void)compareVersion:(NSString *)receiveStr {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"%@",receiveStr);
    NSRange strRange = NSMakeRange(0, receiveStr.length);
    while (true) {
        NSRange startRange = [receiveStr rangeOfString:@"itms-services:" options:0 range:strRange];
        if (startRange.location != NSNotFound) {
            NSRange endRange = [receiveStr rangeOfString:@"')\"" options:0 range:NSMakeRange(startRange.location + startRange.length, receiveStr.length - startRange.location - startRange.length)];
            NSString *url = [receiveStr substringWithRange:NSMakeRange(startRange.location, endRange.location - startRange.location)];
            
            NSRange nameStartRange = [receiveStr rangeOfString:@">" options:0 range:NSMakeRange(endRange.location, receiveStr.length - endRange.location)];
            
            NSRange nameEndRange = [receiveStr rangeOfString:@"</a>" options:0 range:NSMakeRange(endRange.location, receiveStr.length - endRange.location)];
            NSString *name = [receiveStr substringWithRange:NSMakeRange(nameStartRange.location+1, nameEndRange.location - nameStartRange.location - 1)];
            
            NSString *model = @"稳定";
            
            NSRange range = [name rangeOfString:model];
            if (range.location != NSNotFound) {
                range = [name rangeOfString:version];
                if (range.location == NSNotFound) {
                    self.hasNewVersion = YES;
                    self.versionUrl = url;
                    break;
                } else {
                    self.hasNewVersion = NO;
                    self.versionUrl = nil;
                    break;
                }
            }
            strRange.location = nameEndRange.location + nameEndRange.length;
            strRange.length = receiveStr.length - strRange.location;
        } else {
            self.hasNewVersion = NO;
            self.versionUrl = nil;
            break;
        }
    }
}
#endif

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.hasNewVersion = NO;
    self.versionUrl = nil;
}

- (void)updateNewVersionBadge {
    if (self.hasNewVersion) {
        self.tabBarItem.badgeValue = @"有新版本！";
        _versionLb.attributedText = [[NSAttributedString alloc] initWithString:@"有新版本啦。。。" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    } else {
        self.tabBarItem.badgeValue = nil;
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _versionLb.text=[NSString stringWithFormat:@"当前版本 %@",version];
    }
}

@end