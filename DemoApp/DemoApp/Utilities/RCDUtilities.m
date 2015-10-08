//
//  RCDUtilities.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDUtilities.h"

@implementation RCDUtilities

+ (UIImage *)imageNamed:(NSString *)name ofBundle:(NSString *)bundleName {
    UIImage *image = nil;
    NSString *image_name = [NSString stringWithFormat:@"%@.png", name];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *image_path = [bundlePath stringByAppendingPathComponent:image_name];
    
    // NSString* path = [[[[NSBundle mainBundle] resourcePath]
    // stringByAppendingPathComponent:bundleName]stringByAppendingPathComponent:[NSString
    // stringWithFormat:@"%@.png",name]];
    
    // image = [UIImage imageWithContentsOfFile:image_path];
    image = [[UIImage alloc] initWithContentsOfFile:image_path];
    
    return image;
}

@end