//
//  MyComposeToolbar.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    MyComposeToolbarButtonTypeCamera,  //照相机
    MyComposeToolbarButtonTypePicture,  //相册
    MyComposeToolbarButtonTypeMention,  //提到@
    MyComposeToolbarButtonTypeTrend,  //话题
    MyComposeToolbarButtonTypeEmotion  //表情
} MyComposeToolbarButtonType;

@class MyComposeToolbar;

@protocol MyComposeToolbarDelegate <NSObject>

@optional

- (void)composeTool:(MyComposeToolbar *)toolbar didClickedButton:(MyComposeToolbarButtonType)buttonType;

@end

@interface MyComposeToolbar : UIView

@property (nonatomic ,weak) id<MyComposeToolbarDelegate>delegate;
@property (nonatomic ,assign ,getter=isShowEmotionButton) BOOL showEmotionButton;

@end