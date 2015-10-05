//
//  MyEmotionToolbar.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyEmotionToolbar;

typedef enum {
    MyEmotionTypeRecent = 1,
    MyEmotionTypeDefault ,
    MyEmotionTypeEmoji,
    MyEmotionTypeLxh
} MyEmotionTYype;

@protocol MyEmotionToolbarDelegate <NSObject>

@optional

-(void)emotionToolbar:(MyEmotionToolbar *)toolbar didSelectedButton:(MyEmotionTYype)emotionType;

@end

@interface MyEmotionToolbar : UIView

@property (nonatomic , assign) MyEmotionTYype currentButtonType;
@property (nonatomic , weak) id<MyEmotionToolbarDelegate>delegate;

@end