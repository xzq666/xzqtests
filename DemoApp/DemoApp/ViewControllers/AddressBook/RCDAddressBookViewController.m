//
//  RCDAddressBookViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "RCDAddressBookViewController.h"
#import "RCDRCIMDataSource.h"
#import <RongIMLib/RongIMLib.h>
#import "RCDAddressBookTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RCDHttpTool.h"
#import "pinyin.h"
#import "RCDUserInfo.h"
#include <ctype.h>
#import "RCDPersonDetailViewController.h"
#import "RCDataBaseManager.h"

@interface RCDAddressBookViewController ()

//#字符索引对应的user object
@property (nonatomic,strong) NSMutableArray *tempOtherArr;
@property (nonatomic,strong) NSMutableArray *friends;

@end

@implementation RCDAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"通讯录";
    self.tableView.tableFooterView = [UIView new];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAllData];
}

//删除已选中用户
-(void) removeSelectedUsers:(NSArray *) selectedUsers {
    for (RCUserInfo *user in selectedUsers) {
        [_friends enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            RCDUserInfo *userInfo = obj;
            if ([user.userId isEqualToString:userInfo.userId]) {
                [_friends removeObject:obj];
            }
        }];
    }
}

/**
 *  initial data
 */
-(void) getAllData {
    _keys = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
    _allFriends = [NSMutableDictionary new];
    _allKeys = [NSMutableArray new];
    _friends = [NSMutableArray arrayWithArray:[[RCDataBaseManager shareInstance]getAllFriends ] ];
    if (_friends==nil||_friends.count<1) {
        [RCDDataSource syncFriendList:^(NSMutableArray * result) {
            _friends=result;
            if (_friends.count < 20) {
                self.hideSectionHeader = YES;
            }
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                _allFriends = [self sortedArrayWithPinYinDic:_friends];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    
                });
            });
            
        }];
    } else {
        if (_friends.count < 20) {
            self.hideSectionHeader = YES;
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            _allFriends = [self sortedArrayWithPinYinDic:_friends];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                
            });
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reusableCellWithIdentifier = @"RCDAddressBookCell";
    RCDAddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellWithIdentifier];
    
    NSString *key = [_allKeys objectAtIndex:indexPath.section];
    NSArray *arrayForKey = [_allFriends objectForKey:key];
    
    RCDUserInfo *user = arrayForKey[indexPath.row];
    if(user){
        cell.lblName.text = user.name;
        [cell.imgvAva sd_setImageWithURL:[NSURL URLWithString:user.portraitUri] placeholderImage:[UIImage imageNamed:@"contact"]];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [_allKeys objectAtIndex:section];
    NSArray *arr = [_allFriends objectForKey:key];
    return [arr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_allKeys count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.f;
}

//pinyin index
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.hideSectionHeader) {
        return nil;
    }
    return _allKeys;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.hideSectionHeader) {
        return nil;
    }
    NSString *key = [_allKeys objectAtIndex:section];
    return key;
}

#pragma mark - 拼音排序
/**
 *  汉字转拼音
 *
 *  @param hanZi 汉字
 *
 *  @return 转换后的拼音
 */
- (NSString *) hanZiToPinYinWithString:(NSString *)hanZi {
    if(!hanZi)
        return nil;
    NSString *pinYinResult=[NSString string];
    for(int j=0;j<hanZi.length;j++){
        NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([hanZi characterAtIndex:j])] uppercaseString];
        pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
    }
    return pinYinResult;
}

/**
 *  根据转换拼音后的字典排序
 *
 *  @param pinyinDic 转换后的字典
 *
 *  @return 对应排序的字典
 */
-(NSMutableDictionary *) sortedArrayWithPinYinDic:(NSArray *) friends {
    if(!friends) return nil;
    NSMutableDictionary *returnDic = [NSMutableDictionary new];
    _tempOtherArr = [NSMutableArray new];
    BOOL isReturn = NO;
    for (NSString *key in _keys) {
        if ([_tempOtherArr count]) {
            isReturn = YES;
        }
        NSMutableArray *tempArr = [NSMutableArray new];
        for (RCDUserInfo *user in friends) {
            NSString *pyResult = [self hanZiToPinYinWithString:user.name];
            NSString *firstLetter = [pyResult substringToIndex:1];
            if ([firstLetter isEqualToString:key]){
                [tempArr addObject:user];
            }
            if(isReturn) continue;
            char c = [pyResult characterAtIndex:0];
            if (isalpha(c) == 0) {
                [_tempOtherArr addObject:user];
            }
        }
        if(![tempArr count]) continue;
        [returnDic setObject:tempArr forKey:key];
    }
    if([_tempOtherArr count])
        [returnDic setObject:_tempOtherArr forKey:@"#"];
    _allKeys = [[returnDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    return returnDic;
}

//跳转到个人详细资料
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *key = [_allKeys objectAtIndex:indexPath.section];
    NSArray *arrayForKey = [_allFriends objectForKey:key];
    RCDUserInfo *user = arrayForKey[indexPath.row];
    RCUserInfo *userInfo = [RCUserInfo new];
    userInfo.userId = user.userId;
    userInfo.portraitUri = user.portraitUri;
    userInfo.name = user.name;
    RCDPersonDetailViewController *detailViewController = [segue destinationViewController];
    detailViewController.userInfo = userInfo;
}

@end