//
//  RCDLoginInfo.h
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface RCDLoginInfo : JSONModel

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic, copy) NSString *portrait;

+(id) shareLoginInfo;

@end