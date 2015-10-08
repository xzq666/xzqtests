//
//  RCDTextFieldValidate.h
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCDTextFieldValidate : NSObject

//验证手机号码
+ (BOOL) validateMobile:(NSString *)mobile;

//验证电子邮箱
+ (BOOL) validateEmail:(NSString *)email;

//验证密码
+ (BOOL) validatePassword:(NSString *) password;

@end