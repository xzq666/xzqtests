//
//  StatusResult.h
//  xzqtest
//
//  Created by 许卓权 on 15/10/21.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "BaseObject.h"

@interface StatusResult : BaseObject

/** 存放着某一页微博数据（里面都是Status模型） */
@property (strong, nonatomic) NSMutableArray *statuses;
/** 存放着一堆的广告数据（里面都是Ad模型） */
@property (strong, nonatomic) NSArray *ads;
/** 总数 */
@property (strong, nonatomic) NSNumber *totalNumber;
/** 上一页的游标 */
@property (assign, nonatomic) long long previousCursor;
/** 下一页的游标 */
@property (assign, nonatomic) long long nextCursor;

@end