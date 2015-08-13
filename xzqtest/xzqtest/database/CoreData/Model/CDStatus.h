//
//  CDStatus.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
// 通过xcdatamodeld生成

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDUser;

@interface CDStatus : NSManagedObject

@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) CDUser *cduser;

@end