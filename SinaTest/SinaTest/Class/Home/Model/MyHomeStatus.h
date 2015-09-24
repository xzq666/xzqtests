//
//  MyHomeStatus.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHomeStatus : NSObject

@property (nonatomic , strong) NSMutableArray *statuses;
@property (nonatomic , assign) int total_number;
@property (nonatomic , strong) NSArray *loadedObjectIDs;

@end