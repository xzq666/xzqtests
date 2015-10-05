//
//  AppkeyModel.h
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppkeyModel : NSObject

@property (nonatomic, strong)NSString *appKey;
@property (nonatomic)int env;
- (instancetype)initWithKey:(NSString *)appKey env:(int)env;

@end