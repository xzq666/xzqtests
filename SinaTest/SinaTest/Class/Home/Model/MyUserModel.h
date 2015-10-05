//
//  MyUserModel.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/29.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyUserModel <NSObject>

@required

-(NSString*)userId;

-(NSString*)avatarUrl;

-(NSString*)username;

@end