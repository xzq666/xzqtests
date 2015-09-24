//
//  HomeViewController.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "HomeViewController.h"
#import "MyTitleButton.h"
#import "MyUser.h"
#import "MyHomeStatus.h"
#import "MyStatus.h"
#import "MyStatusFrame.h"

@interface HomeViewController () <UIActionSheetDelegate>

@property (nonatomic , strong) NSMutableArray *statusesFrame;
@property (nonatomic , strong) NSMutableArray *loadedObjects;
@property (nonatomic , weak) MyTitleButton *titleButton;
@property (nonatomic , strong) MyHttpTool *HttpToolManager;
@property (nonatomic , strong) MyHomeStatus *homeStatus;
@property (nonatomic , strong) NSMutableArray *AVObjects;

@end

@implementation HomeViewController

- (NSMutableArray *)statusesFrame {
    if (_statusesFrame == nil) {
        _statusesFrame = [NSMutableArray array];
    }
    return _statusesFrame;
}

- (NSMutableArray *)loadedObjects{
    if (_loadedObjects == nil){
        _loadedObjects = [NSMutableArray array];
    }
    return _loadedObjects;
}

- (NSMutableArray *)AVObjects {
    if (_AVObjects == nil){
        _AVObjects = [NSMutableArray array];
    }
    return _AVObjects;
}

- (MyHttpTool *)HttpToolManager {
    if (_HttpToolManager == nil){
        _HttpToolManager = [[MyHttpTool alloc] init];
    }
    return _HttpToolManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置导航栏
    [self setupNavigationItem];
    // 2.删除分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 3.刷新控件
    [self setupRefresh];
    self.tableView.backgroundColor = MyGlobleTableViewBackgroundColor;
    // 4.监听更多按钮被点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusOriginalViewDidClickedMoreButton:) name:MyStatusOriginalDidMoreNotication object:nil];
    // 6. 监听文本链接
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkDidSelected:) name:MyLinkDidSelectedNotification object:nil];
    // 7. 普通文本链接
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusNormalTextDidSelected:) name:MyStatusNormalTextDidSelectedNotification object:nil];
}

//设置导航栏
- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"navigationbar_friendsearch" highBackgroudImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"navigationbar_pop" highBackgroudImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    [self setupCenterTitle];
}

- (void)setupCenterTitle{
    //创建导航中间标题按钮
    MyTitleButton *titleButton = [[MyTitleButton alloc] init];
    titleButton.height = MyNavigationItemOfTitleViewHeight;
    //设置文字
    [titleButton setTitle:[MyUser readLocalUser].username ? [MyUser readLocalUser].username : @"首页" forState:UIControlStateNormal];
    //设置图标
    UIImage *mainImage = [[UIImage imageWithName:@"main_badge"] scaleImageWithSize:CGSizeMake(10, 10)];
    [titleButton setImage:mainImage forState:UIControlStateNormal];
    //设置背景
    [titleButton setBackgroundImage:[UIImage resizableImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    //监听点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    //获取用户信息
    [self setupUserInfo];
}

- (void)setupUserInfo {
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        [MyUser save:currentUser];
    }else{
        NSLog(@"获取用户昵称失败");
    }
}

//点击标题点击
- (void)titleClick:(UIButton *)titleButton {
    // 弹出菜单
    NSLog(@"--标题--");
}

//扫一扫
- (void)pop {
    NSLog(@"--扫一扫--");
}

//好友搜索
- (void)friendsearch {
    NSLog(@"--好友搜索--");
}

//下拉刷新
- (void)setupRefresh {
    // 1.添加下拉刷新
    UIRefreshControl *refreshController = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshController];
    // 2.监听状态
    [refreshController addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    // 3.让刷新控件自动进入刷新状态
    [refreshController beginRefreshing];
    // 4.加载数据
    [self refreshControlStateChange:refreshController];
//    // 5.添加上拉加载更多控件
//    DSLoadMoreFooter *footer = [DSLoadMoreFooter footer];
//    self.tableView.tableFooterView = footer;
//    self.footer = footer;
}

/**
 *  当下拉刷新控件进入刷新状态（转圈圈）的时候会自动调用
 */
- (void) refreshControlStateChange:(UIRefreshControl *)refreshControl {
    [self loadNewStatuses:refreshControl];
}

#pragma mark - 加载数据
/**
 *  加载最新的数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl{
    typeof(self) __weak weakSelf= self;
    [self.HttpToolManager findStatusWithBlock:^(NSArray *objects , NSError *error){
        NSLog(@"%d loaded" , (int)objects.count);
        if (!error){
            int currentFeeds = 0;
            if (self.homeStatus.statuses) {
                currentFeeds = (int)self.homeStatus.statuses.count;
            }
            self.homeStatus = [weakSelf.HttpToolManager showHomestatusFromAVObjects:objects];
            //获得新数据的frame数组
            NSArray *newFrames = (NSArray *)[weakSelf statusFramesWithStatuses:self.homeStatus.statuses];
            // 将新数据插入到旧数据的最前面
            NSRange range = NSMakeRange(0, newFrames.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [weakSelf.statusesFrame removeAllObjects];
            [weakSelf.statusesFrame insertObjects:newFrames atIndexes:indexSet];
            [weakSelf.loadedObjects removeAllObjects];
            [weakSelf.loadedObjects insertObjects:self.homeStatus.loadedObjectIDs atIndexes:indexSet];
            [weakSelf.AVObjects removeAllObjects];
            [weakSelf.AVObjects insertObjects:objects atIndexes:indexSet];
            // 重新刷新表格
            [weakSelf.tableView reloadData];
            // 让刷新控件停止刷新
            [refreshControl endRefreshing];
            //提示用户刷新的Feed个数
            int newF = (int)newFrames.count - currentFeeds;
            [weakSelf showNewStatusesCount:newF];
            // 首页图标数据清零
            [UIApplication sharedApplication].applicationIconBadgeNumber -= weakSelf.tabBarItem.badgeValue.intValue;
            weakSelf.tabBarItem.badgeValue = nil;
        } else {
            NSLog(@"请求失败,请检查网络");
        }
    }];
}

/**
 *  提示用户最新的微博数量
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatusesCount:(int)count {
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    // 2.显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%d条新的数据", count];
    } else {
        label.text = @"没有最新的数据";
    }
    // 3.设置背景
    label.backgroundColor = MyCommonColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    // 4.设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = MyNavigationHeight - label.height;
    // 5.添加到导航控制器的view
    //    [self.navigationController.view addSubview:label];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 6.动画
    CGFloat duration = 0.75;
    //    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        //        label.alpha = 1.0;
    } completion:^(BOOL finished) { // 向下移动完毕
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            //            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
}

- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses {
    NSMutableArray *frames = [NSMutableArray array];
    for (MyStatus *status in statuses) {
        MyStatusFrame *frame = [[MyStatusFrame alloc] init];
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

- (void)statusOriginalViewDidClickedMoreButton:(NSNotification *)notification {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报",@"屏蔽",@"取消关注",@"收藏", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"---点击按钮");
}

- (void)linkDidSelected:(NSNotification *)notification {
    NSLog(@"link");
}

//跳转到正文，可以是评论界面
- (void)statusNormalTextDidSelected:(NSNotification *)notification {
    NSLog(@"跳转cell：到正文");
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = [UIColor redColor];
    newVc.title = @"正文";
    [self.navigationController pushViewController:newVc animated:YES];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    self.footer.hidden = self.statusesFrame.count == 0 ;
//    return self.statusesFrame.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    DSStatusCell *cell = [DSStatusCell cellWithTableView:tableView];
//    cell.statusFrame = self.statusesFrame[indexPath.row];
//    NSLog(@"number %d cell loaded",indexPath.row);
//    cell.delegate = self;
//    cell.indexpath = indexPath;
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MyStatusFrame *statusFrame = self.statusesFrame[indexPath.row];
//    return statusFrame.cellHeight;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIViewController *newVc = [[UIViewController alloc] init];
//    newVc.view.backgroundColor = [UIColor redColor];
//    newVc.title = @"新控制器";
//    [self.navigationController pushViewController:newVc animated:YES];
//}

@end