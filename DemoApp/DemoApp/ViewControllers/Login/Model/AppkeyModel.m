//
//  AppkeyModel.m
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "AppkeyModel.h"

@implementation AppkeyModel

- (instancetype)initWithKey:(NSString *)appKey env:(int)env {
    self = [super init];
    if (self) {
        self.appKey = appKey;
        self.env = env;
    }
    return self;
}

@end