//
//  RCDSearchFriendViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDSearchFriendViewController.h"
#import "MBProgressHUD.h"
#import "RCDHttpTool.h"
#import "RCDAddressBookTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCDRCIMDataSource.h"
#import "RCDUserInfo.h"
#import "RCDSearchResultTableViewCell.h"
#import "RCDAddFriendViewController.h"

@interface RCDSearchFriendViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate>

@property (strong, nonatomic) NSMutableArray *searchResult;

@end

@implementation RCDSearchFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"查找好友";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //initial data
    _searchResult=[[NSMutableArray alloc] init];
}

+ (instancetype) searchFriendViewController {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RCDSearchFriendViewController *searchController = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDSearchFriendViewController"];
    return searchController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchResultDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.searchDisplayController.searchResultsTableView)
        return _searchResult.count;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.searchDisplayController.searchResultsTableView)
        return 80.f;
    return 0.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusableCellWithIdentifier = @"RCDSearchResultTableViewCell";
    RCDSearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellWithIdentifier];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell = [[RCDSearchResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableCellWithIdentifier];
        RCDUserInfo *user =_searchResult[indexPath.row];
        if(user){
            cell.lblName.text = user.name;
            [cell.ivAva sd_setImageWithURL:[NSURL URLWithString:user.portraitUri] placeholderImage:[UIImage imageNamed:@"icon_person"]];
        }
    }
    return cell;
}

#pragma mark - searchResultDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RCDUserInfo *user = _searchResult[indexPath.row];
    RCUserInfo *userInfo = [RCUserInfo new];
    userInfo.userId = user.userId;
    userInfo.name = user.name;
    userInfo.portraitUri = user.portraitUri;
    if(user && tableView == self.searchDisplayController.searchResultsTableView){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RCDAddFriendViewController *addViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"RCDAddFriendViewController"];
        addViewController.targetUserInfo = userInfo;
        [self.navigationController pushViewController:addViewController animated:YES];
    }
}

#pragma mark - UISearchBarDelegate
/**
 *  执行delegate搜索好友
 *
 *  @param searchBar  searchBar description
 *  @param searchText searchText description
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [_searchResult removeAllObjects];
    if ([searchText length]) {
        [RCDHTTPTOOL searchFriendListByEmail:searchText complete:^(NSMutableArray *result) {
            if (result) {
                [_searchResult addObjectsFromArray:result];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.searchDisplayController.searchResultsTableView reloadData];
                });
            }
        }];
        [RCDHTTPTOOL searchFriendListByName:searchText complete:^(NSMutableArray *result) {
            if (result) {
                [_searchResult addObjectsFromArray:result];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.searchDisplayController.searchResultsTableView reloadData];
                });
            }
        }];
    }
}

@end