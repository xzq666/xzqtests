//
//  MyAVStatus.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAVStatus : AVObject<AVSubclassing>

@property (nonatomic , strong) AVUser *creator;
@property (nonatomic , copy) NSString *statusContent;
@property (nonatomic , assign) NSArray *albumPhotos;
@property (nonatomic , assign) NSArray *comments;
@property (nonatomic , assign) NSArray *digUsers;

+ (NSString *)parseClassName;

@end