//
//  MyLink.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLink : UIView

//匹配的文本
@property (nonatomic , copy) NSString *text;
//匹配的文字范围
@property (nonatomic , assign) NSRange range;
//选中的范围
@property (nonatomic , strong) NSArray *rects;

@end