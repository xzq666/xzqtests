//
//  MyAbuseReport.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/29.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "AVObject.h"

@interface MyAbuseReport : AVObject<AVSubclassing>

@property (nonatomic,strong) NSString *reason;
@property (nonatomic,strong) NSString *convid;
@property (nonatomic,strong) AVUser *author;

@end