//
//  HandBook.m
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "HandBook.h"

@implementation HandBook

- (HandBook *)initWithName:(NSString *)name star:(NSString *)star imgurl:(NSString *)imgurl {
    if (self=[super init]) {
        self.name = name;
        self.star = star;
        self.imgurl = imgurl;
    }
    return self;
}

- (HandBook *)initWithDictionary:(NSDictionary *)dic {
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}

+ (HandBook *)handbookWithName:(NSString *)name star:(NSString *)star imgurl:(NSString *)imgurl {
    HandBook *handbook = [[HandBook alloc] initWithName:name star:star imgurl:imgurl];
    return handbook;
}

@end