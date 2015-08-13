//
//  CDMainTableViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "CDMainTableViewController.h"
#import "CDDBManager.h"
#import "CDUser.h"
#import "CDStatus.h"
#import "CDUserService.h"
#import "CDStatusService.h"
#import "CDStatusTableViewCell.h"

@interface CDMainTableViewController (){
    NSArray *_status;
    NSMutableArray *_statusCells;
}

@end

@implementation CDMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUsers];
    //    [self removeUser];
    //    [self modifyUserInfo];
    
    [self addStatus];
    
    //    NSLog(@"status:%@",[[CDStatusService sharedCDStatusService]getStatusesByUserName:@"Binger"]);
    [self loadStatusData];
    
}

-(void)addUsers{
    [[CDUserService sharedCDUserService]addUserWithName:@"Binger" screenName:@"冰儿" profileImageUrl:@"binger.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [[CDUserService sharedCDUserService] addUserWithName:@"Xiaona" screenName:@"小娜" profileImageUrl:@"xiaona.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [[CDUserService sharedCDUserService]addUserWithName:@"Lily" screenName:@"丽丽" profileImageUrl:@"lily.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [[CDUserService sharedCDUserService]addUserWithName:@"Qianmo" screenName:@"阡陌" profileImageUrl:@"qianmo.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [[CDUserService sharedCDUserService]addUserWithName:@"Yanyue" screenName:@"炎月" profileImageUrl:@"yanyue.jpg" mbtype:@"mbtype.png" city:@"北京"];
}

-(void)removeUser{
    //注意在SQLite中区分大小写
    [[CDUserService sharedCDUserService] removeUserByName:@"Yanyue"];
}

-(void)modifyUserInfo{
    CDUser *user1= [[CDUserService sharedCDUserService]getUserByName:@"Xiaona"];
    user1.city=@"上海";
    [[CDUserService sharedCDUserService] modifyUser:user1];
    
    CDUser *user2= [[CDUserService sharedCDUserService]getUserByName:@"Lily"];
    user2.city=@"深圳";
    [[CDUserService sharedCDUserService] modifyUser:user2];
}


-(void)addStatus{
    CDUser *user1=[[CDUserService sharedCDUserService]getUserByName:@"Binger"];
    CDUser *user2=[[CDUserService sharedCDUserService]getUserByName:@"Xiaona"];
    NSDate *date=[NSDate date];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"一只雪猴在日本边泡温泉边玩iPhone的照片，获得了\"2014年野生动物摄影师\"大赛特等奖。一起来为猴子配个词" user:user1];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"【Apple Watch或推迟到明年3月底发售】Apple Watch何时发售是消费者关注的重点，之前曾经传闻说它会在明年年初一月份出货，不过现在看来这个日子要往后延长了。" user:user2];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"【我们送iPhone6了 要求很简单】真心回馈粉丝，小编觉得现在最好的奖品就是iPhone6了。今起到12月31日，关注我们，转发微博，就有机会获iPhone6(奖品可能需要等待)！每月抽一台[鼓掌]。不费事，还是试试吧，万一中了呢" user:user1];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"重大新闻：蒂姆库克宣布出柜后，ISIS战士怒扔iPhone，沙特神职人员呼吁人们换回iPhone 4。[via Pan-Arabia Enquirer]" user:user2];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"小伙伴们，有谁知道怎么往Iphone4S里倒东西？倒入的东西又该在哪里找？用了Iphone这么长时间，还真的不知道怎么弄！有谁知道啊？谢谢！" user:user1];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"在音悦台iPhone客户端里发现一个悦单《Infinite 金明洙》，推荐给大家! " user:user2];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"如果sony吧mp3播放器产品发展下去，不贪图手头节目源的现实利益，就木有苹果的ipod，也就木有iphone。柯达类似的现实利益，不自我革命的案例也是一种巨头的宿命。" user:user1];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"【iPhone 7 Plus】新买的iPhone 7 Plus ，如何？够酷炫么？" user:user2];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"自拍神器#卡西欧TR500#，tr350S～价格美丽，行货，全国联保～iPhone6 iPhone6Plus卡西欧TR150 TR200 TR350 TR350S全面到货 招收各种代理！[给力]微信：39017366" user:user1];
    [[CDStatusService sharedCDStatusService] addStatusWithCreatedAt:date source:@"iPhone 6" text:@"猜到猴哥玩手机时所思所想者，再奖iPhone一部。（奖品由“2014年野生动物摄影师”评委会颁发）" user:user2];
}

#pragma mark 加载数据
-(void)loadStatusData{
    _statusCells=[[NSMutableArray alloc]init];
    _status=[[CDStatusService sharedCDStatusService]getAllStatus];
    [_status enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CDStatusTableViewCell *cell=[[CDStatusTableViewCell alloc]init];
        cell.status=(CDStatus *)obj;
        [_statusCells addObject:cell];
    }];
    NSLog(@"%@",[_status lastObject]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _status.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identtityKey=@"myTableViewCellIdentityKey1";
    CDStatusTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:identtityKey];
    if(cell==nil){
        cell=[[CDStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identtityKey];
    }
    cell.status=_status[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((CDStatusTableViewCell *)_statusCells[indexPath.row]).height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

@end