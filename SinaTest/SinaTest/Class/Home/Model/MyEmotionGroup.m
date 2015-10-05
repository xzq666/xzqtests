//
//  MyEmotionGroup.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyEmotionGroup.h"
#import "MJExtension.h"
#import "MyEmotion.h"

@implementation MyEmotionGroup

- (NSDictionary *)objectClassInArray {
    return @{@"emotion_group_emotions" : [MyEmotion class]};
}

@end