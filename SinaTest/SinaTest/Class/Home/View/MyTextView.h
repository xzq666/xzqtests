//
//  MyTextView.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextView : UITextView

@property (nonatomic , copy) NSString *placeholder;
@property (nonatomic , strong) UIColor *placeholderColor;

@end