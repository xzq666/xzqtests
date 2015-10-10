//
//  MyCommentViewControllerTableViewController.h
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCommentViewController : UITableViewController

@property (nonatomic ,strong) NSArray *comments;
@property (nonatomic , strong) AVObject *object;

- (void)refresh;

@end