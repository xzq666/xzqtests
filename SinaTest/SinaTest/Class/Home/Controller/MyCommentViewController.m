//
//  MyCommentViewControllerTableViewController.m
//  SinaTest
//
//  Created by 许卓权 on 15/10/10.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyAVComment.h"
#import "MyComment.h"
#import "MyHttpTool.h"
#import "MJExtension.h"
#import "MyUser.h"
#import "UIImageView+WebCache.h"
#import "MyLoadMoreFooter.h"
#import "MyCommentCellFrame.h"
#import "MyCommentCell.h"
#import "MyStatusToolbar.h"
#import "MyComposeViewController.h"
#import "MyNavigationController.h"

@interface MyCommentViewController ()

@property (nonatomic , strong) MyHttpTool *HttpToolManager;
@property (nonatomic , strong) NSMutableArray *commentsFrame;

@end

@implementation MyCommentViewController

- (MyHttpTool *)HttpToolManager {
    if (_HttpToolManager == nil){
        _HttpToolManager = [[MyHttpTool alloc] init];
    }
    return _HttpToolManager;
}

- (NSMutableArray *)commentsFrame {
    if(_commentsFrame == nil){
        _commentsFrame = [NSMutableArray array];
    }
    return _commentsFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = MyGlobleTableViewBackgroundColor;
}

- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"timeline_icon_add_friends" highBackgroudImageName:@"timeline_icon_add_friends" target:self action:@selector(jumpToPost)];
}

- (void)refresh {
    AVQuery *query = [AVQuery queryWithClassName:@"Album"];
    [query includeKey:@"comments"]; //Pointer查询要包含类中的key
    AVObject *object = [query getObjectWithId:self.object.objectId];
    NSArray *comments = [object objectForKey:@"comments"];
    //按发送时间排序
    NSMutableArray *tempbox = [NSMutableArray array];
    for (AVObject *c in comments){
        [tempbox insertObject:c atIndex:0];
    }
    self.comments = tempbox;
}

- (void)runInMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

- (void)runInGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), queue);
}

- (void)jumpToPost {
    MyComposeViewController *compose = [[MyComposeViewController alloc] init];
    compose.source = @"comment";
    compose.object = self.object;
    compose.commentVc = self;
    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:compose];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (NSArray *)commentFramesWithStatuses:(NSArray *)comments {
    NSMutableArray *frames = [NSMutableArray array];
    for (MyComment *comment in comments) {
        MyCommentCellFrame *frame = [[MyCommentCellFrame alloc] init];
        frame.commentData = comment;
        [frames addObject:frame];
    }
    return frames;
}

-(void)setComments:(NSArray *)comments {
    NSLog(@"new comments set");
    _comments = comments;
    NSArray *commentData = [self.HttpToolManager showCommentFromAVObject:comments];
    NSArray *newFrames = [self commentFramesWithStatuses:commentData];
    [self.commentsFrame removeAllObjects];
    NSRange range = NSMakeRange(0, newFrames.count);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.commentsFrame insertObjects:newFrames atIndexes:indexSet];
    [self.tableView reloadData];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCommentCell *cell = [MyCommentCell cellWithTableView:tableView];
    cell.commentFrame = self.commentsFrame[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCommentCellFrame *cellFrame = self.commentsFrame[indexPath.row];
    return cellFrame.cellHeight;
}

@end