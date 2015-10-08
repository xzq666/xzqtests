//
//  RCDConversationSettingTableViewHeaderItem.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/7.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDConversationSettingTableViewHeaderItem.h"
#import "RCDUtilities.h"
#import "UIImageView+WebCache.h"

@implementation RCDConversationSettingTableViewHeaderItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIView *myView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _ivAva = [[UIImageView alloc] initWithFrame:CGRectZero];
        _ivAva.clipsToBounds = YES;
        _ivAva.layer.cornerRadius = 6.f;
        //_ivAva.placeholderImage = IMAGE_BY_NAMED(@"default_portrait_msg");
        [_ivAva setBackgroundColor:[UIColor grayColor]];
        [myView addSubview:_ivAva];
        
        _titleLabel = [UILabel new];
        [_titleLabel setTextColor:[UIColor darkGrayColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [myView addSubview:_titleLabel];
        
        _btnImg = [[UIButton alloc] initWithFrame:CGRectZero];
        [_btnImg setHidden:YES];
        [_btnImg setImage:[RCDUtilities imageNamed:@"delete_member_tip" ofBundle:@"RongCloud.bundle"]
                 forState:UIControlStateNormal];
        [_btnImg addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:_btnImg];
        
        [self.contentView addSubview:myView];
        
        // add contraints
        [myView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ivAva setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_btnImg setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UIView *tempContentView = self.contentView;
        
        [self.contentView
         addConstraints:[NSLayoutConstraint
                         constraintsWithVisualFormat:@"H:|[myView(==tempContentView)]|"
                         options:kNilOptions
                         metrics:nil
                         views:NSDictionaryOfVariableBindings(myView, tempContentView)]];
        [self.contentView
         addConstraints:[NSLayoutConstraint
                         constraintsWithVisualFormat:@"V:|[myView(==tempContentView)]|"
                         options:kNilOptions
                         metrics:nil
                         views:NSDictionaryOfVariableBindings(myView, tempContentView)]];
        
        [self.contentView
         addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ivAva]|"
                                                                options:kNilOptions
                                                                metrics:nil
                                                                  views:NSDictionaryOfVariableBindings(_ivAva)]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(
                                                                                                                        _titleLabel, myView)]];
        [self.contentView
         addConstraints:[NSLayoutConstraint
                         constraintsWithVisualFormat:@"V:|[_ivAva(56)]-5-[_titleLabel(==15)]|"
                         options:kNilOptions
                         metrics:nil
                         views:NSDictionaryOfVariableBindings(_titleLabel, _ivAva)]];
        
        [self.contentView
         addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_btnImg(20)]"
                                                                options:kNilOptions
                                                                metrics:nil
                                                                  views:NSDictionaryOfVariableBindings(_btnImg)]];
        [self.contentView
         addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_btnImg(20)]"
                                                                options:kNilOptions
                                                                metrics:nil
                                                                  views:NSDictionaryOfVariableBindings(_btnImg)]];
    }
    return self;
}

- (void)deleteItem:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteTipButtonClicked:)]) {
        [self.delegate deleteTipButtonClicked:self];
    }
}

@end