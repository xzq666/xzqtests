//
//  CDUser.h
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//  通过xcdatamodeld生成

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface CDUser : NSManagedObject

@property (nonatomic, retain) NSString * screenName;
@property (nonatomic, retain) NSString * profileImageUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * mbtype;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSManagedObject *cdstatus;

@end