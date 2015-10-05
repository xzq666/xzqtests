//
//  MyHttpTool.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyHttpTool.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MyAVStatus.h"
#import "MyUser.h"
#import "MyStatus.h"

@implementation MyHttpTool

+ (void)monitoringReachabilityStatus:(void (^)(AFNetworkReachabilityStatus))statusBlock {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //当前网络改变了就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        if (status){
            statusBlock(status);
        }
    }];
    //开始监控
    [mgr startMonitoring];
}

+ (void)showNetworkActivityIndicatior {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

- (void)createStatusWithText:(NSString *)text error:(NSError *__autoreleasing *)error {
    if (text == nil) {
        text = @"";
    }
    NSError *theError;
    AVUser *user = [AVUser currentUser];
    //DSAVStatus *avstatus = [DSAVStatus object];
    AVObject *avstatus = [AVObject objectWithClassName:@"Album"];
    [avstatus setObject:user forKey:@"creator"];
    [avstatus setObject:text forKey:@"albumContent"];
    [avstatus setObject:[NSArray array] forKey:@"comments"];
    [avstatus save:&theError];
    *error = theError;
}

- (void)findStatusWithBlock:(AVArrayResultBlock)block {
    AVQuery *query = [MyAVStatus query];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"albumPhotos"];
    [query includeKey:@"creator"];
    [query includeKey:@"comments.commentUser"];
    [query includeKey:@"comments.toUser"];
    [query setCachePolicy:kAVCachePolicyNetworkElseCache];
    query.limit = 50;
    [query findObjectsInBackgroundWithBlock:block];
}

- (MyHomeStatus *)showHomestatusFromAVObjects:(NSArray *)objects {
    MyHomeStatus *homestatus = [[MyHomeStatus alloc] init];
    NSMutableArray *tempStatuses = [NSMutableArray array];
    NSMutableArray *tempLoadedIDs = [NSMutableArray array];
    homestatus.total_number = (int)objects.count;
    for (AVObject *object in objects) {
        MyStatus *status = [[MyStatus alloc] init];
        AVUser *creator = [object objectForKey:@"creator"];
        MyUser *feeduser = [[MyUser alloc] init];
        feeduser.username = creator.username;
        feeduser.userId = creator.objectId;
        AVFile *avatarFile = [creator objectForKey:@"avatar"];
        feeduser.avatarUrl = avatarFile.url;
        status.user = feeduser;
        NSString *text = [object objectForKey:@"albumContent"];
        status.attributedText = [[NSAttributedString alloc] initWithString:text];
        status.attitudes_count = (int)((NSArray *)[object objectForKey:@"digUsers"]).count;
        status.digusers = [object objectForKey:@"digUsers"];
        status.comments_count = (int)((NSArray *)[object objectForKey:@"comments"]).count;
        status.idstr = object.objectId;
        status.comments = [object objectForKey:@"comments"];
        NSArray *picFiles = [object objectForKey:@"albumPhotos"];
        NSMutableArray *picUrls = [NSMutableArray array];
        for (AVFile *file in picFiles) {
            [picUrls addObject:file.url];
        }
        status.pic_urls = picUrls;
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"EEE MMM dd HH24:mm:ss Z yyyy";
        NSDate *createDate = object.createdAt;
        if (createDate.isThisYear) {
            if (createDate.isToday) { // 今天
                NSDateComponents *cmps = [createDate deltaWithNow];
                if (cmps.hour >= 1) { // 至少是1小时前发的
                    status.created_at =  [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
                } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                    status.created_at = [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
                } else { // 1分钟内发的
                    status.created_at = @"刚刚";
                }
            } else if (createDate.isYesterday) { // 昨天
                fmt.dateFormat = @"昨天 HH:mm";
                status.created_at = [fmt stringFromDate:createDate];
            } else { // 至少是前天
                fmt.dateFormat = @"MM-dd HH:mm";
                status.created_at = [fmt stringFromDate:createDate];
            }
        } else { // 非今年
            fmt.dateFormat = @"yyyy-MM-dd";
            status.created_at = [fmt stringFromDate:createDate];
        }
        [tempStatuses addObject:status];
        [tempLoadedIDs addObject:status.idstr];
    }
    homestatus.statuses = [tempStatuses mutableCopy];
    homestatus.loadedObjectIDs = [tempLoadedIDs mutableCopy];
    return homestatus;
}

- (void)digOrCancelDigOfStatus:(MyStatus *)clickedStatus sender:(UIButton *)sender block:(AVBooleanResultBlock)block {
    AVQuery *query = [AVQuery queryWithClassName:@"Album"];
    AVObject *status = [query getObjectWithId:clickedStatus.idstr];
    AVUser *user = [AVUser currentUser];
    NSMutableArray *digUsers = [status objectForKey:@"digUsers"];
    if ( [digUsers containsObject:user]){
        [status removeObject:user forKey:@"digUsers"];
        [self setupButtonTitle:sender count:clickedStatus.attitudes_count - 1 image:@"timeline_icon_like_disable" defaultTitle:@"赞"];
    } else {
        [status addObject:user forKey:@"digUsers"];
        [self setupButtonTitle:sender count:clickedStatus.attitudes_count + 1 image:@"timeline_icon_like" defaultTitle:@"赞"];
    }
    [status saveInBackgroundWithBlock:block];
}

- (void)setupButtonTitle:(UIButton *)button count:(int)count image:(NSString *)imagename defaultTitle:(NSString *)defaultTitle {
    if (count >= 10000){
        defaultTitle = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0){
        defaultTitle = [NSString stringWithFormat:@"%d",count];
    }
    [button setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}

- (void)findMoreStatusWithBlock:(NSArray *)loadedStatusIDs block:(AVArrayResultBlock)block {
    AVQuery *query = [MyAVStatus query];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"albumPhotos"];
    [query includeKey:@"creator"];
    [query includeKey:@"comments.commentUser"];
    [query includeKey:@"comments.toUser"];
    [query whereKey:@"objectId" notContainedIn:loadedStatusIDs];
    [query setCachePolicy:kAVCachePolicyNetworkElseCache];
    query.limit = 50;
    [query findObjectsInBackgroundWithBlock:block];
}

@end