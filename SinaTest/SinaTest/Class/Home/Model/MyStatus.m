//
//  MyStatus.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyStatus.h"
#import "MyUser.h"

@implementation MyStatus

+ (MyStatus *)transfer:(AVObject *)object {
    MyStatus *status = [[MyStatus alloc] init];
    AVUser *creator = [object objectForKey:@"avatarImage"];
    status.user = [MyUser transfer:creator];
    status.attitudes_count = (int)[object objectForKey:@"attitudeCount"];
    status.reposts_count = (int)[object objectForKey:@"repostCount"];
    AVObject *retweetedstatue = [object objectForKey:@"retweetedStatus"];
    status.retweeted_status = [MyStatus transfer:retweetedstatue];
    status.comments_count = (int)[object objectForKey:@"commentCount"];
    status.source = [object objectForKey:@"source"];
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
    return status;
}

@end