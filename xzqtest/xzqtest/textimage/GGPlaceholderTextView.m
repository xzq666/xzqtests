//
//  GGPlaceholderTextView.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/15.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "GGPlaceholderTextView.h"

@implementation GGPlaceholderTextView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, frame.size.width-4, frame.size.height)];
        [self addSubview:self.placeholderLabel];
        [self addObserver];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.textColor = [UIColor grayColor];
}

-(void)addObserver {
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeEditing:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminate:) name:UIApplicationWillTerminateNotification object:[UIApplication sharedApplication]];
}

- (void)terminate:(NSNotification *)notification {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didBeginEditing:(NSNotification *)notification {
    NSLog(@"-->%d",self.text.length);
    if (self.text.length>0) {
        self.placeholderLabel.text = @"";
    } else {
        self.placeholderLabel.text = self.placeholder;
    }
}

- (void)didChangeEditing:(NSNotification *)notification {
    NSLog(@"-->%d",self.text.length);
    if (self.text.length>0) {
        self.placeholderLabel.text = @"";
    } else {
        self.placeholderLabel.text = self.placeholder;
    }
}

- (void)didEndEditing:(NSNotification *)notification {
    NSLog(@"-->%d",self.text.length);
    if (self.text.length>0) {
        self.placeholderLabel.text = @"";
    } else {
        self.placeholderLabel.text = self.placeholder;
    }
}

@end