//
//  HandBookViewController.m
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "HandBookViewController.h"
#import "HandBookCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "XZQDataBaseCreator.h"
#import "XZQDbManager.h"
#import "HandBook.h"
#import "HandBookService.h"

@interface HandBookViewController() {
    UICollectionView *_collectionView; //图鉴信息列表
    
    NSMutableArray *images; //图鉴图片数组
    NSMutableArray *names; //图鉴名称数组
    NSMutableArray *stars; //title星级数组
    NSInteger count; //图鉴数量
}

@end

@implementation HandBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条背景色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //设置当前页面背景色
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图鉴";
    
    count = 0;
    images = [[NSMutableArray alloc] init];
    names = [[NSMutableArray alloc] init];
    stars = [[NSMutableArray alloc] init];
    
    //设置列表
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-5) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    //注册Cell，必须要有
    [_collectionView registerClass:[HandBookCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if ([[defaults valueForKey:@"IsCreateDb"] intValue] != 1) { //如果数据库无表
        NSLog(@"网络");
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"crusaders", @"gameid", @"Weapons", @"name", @"3000", @"pagesize", @"1", @"page", nil];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:@"http://api.umowang.com/index.php?c=data" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [images removeAllObjects];
            [names removeAllObjects];
            [stars removeAllObjects];
            NSData *resdata = operation.responseData;
            NSString *receiveStr = [[NSString alloc]initWithData:resdata encoding:NSUTF8StringEncoding];
            receiveStr = [self ReplacingNewLineAndWhitespaceCharactersFromJson:receiveStr];
            NSData *data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSString *erron = [result objectForKey:@"erron"];
            if ([erron isEqualToString:@"0"]) {
                NSArray *infos = [result objectForKey:@"data"];
                count = infos.count;
                //初始化本地数据库
                [XZQDataBaseCreator initDatabase];
                for (int i=0; i<count; i++) {
                    NSDictionary *dic = infos[i];
                    [images addObject:[dic objectForKey:@"Image"]];
                    [names addObject:[dic objectForKey:@"Name"]];
                    [stars addObject:[dic objectForKey:@"Title"]];
                    HandBook *handbook=[HandBook handbookWithName:[dic objectForKey:@"Name"] star:[dic objectForKey:@"Title"] imgurl:[dic objectForKey:@"Image"]];
                    [[HandBookService sharedHandBookService] addHandBook:handbook];
                }
            }
            [_collectionView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"err:%@",error);
        }];
    } else {
        //直接从本地数据库取数据
        NSLog(@"本地");
        [images removeAllObjects];
        [names removeAllObjects];
        [stars removeAllObjects];
        NSArray *arr = [[HandBookService sharedHandBookService] getAllHandBook];
        count = arr.count;
        for (int i=0; i<count; i++) {
            HandBook *handbook = [[HandBook alloc] init];
            [handbook setValuesForKeysWithDictionary:arr[i]];
            [images addObject:handbook.imgurl];
            [names addObject:handbook.name];
            [stars addObject:handbook.star];
        }
    }
}

- (NSString *)ReplacingNewLineAndWhitespaceCharactersFromJson:(NSString *)dataStr{
    NSScanner *scanner = [[NSScanner alloc] initWithString:dataStr];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *temp;
    NSCharacterSet*newLineAndWhitespaceCharacters = [ NSCharacterSet newlineCharacterSet];
    // 扫描
    while (![scanner isAtEnd]) {
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        // 替换换行符
        if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
            if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                [result appendString:@"</br>"];
        }
    }
    return result;
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionCell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return count;
}

//定义Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString *identify = @"UICollectionViewCell";
    HandBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建");
    }
    //设置承载框样式
    cell.view.backgroundColor = [UIColor whiteColor];
    cell.view.layer.masksToBounds = YES;
    cell.view.layer.cornerRadius = 3;
    cell.view.layer.borderWidth = 0.5;
    cell.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //设置图片
    [cell.img sd_setImageWithURL:[images objectAtIndex:indexPath.row] placeholderImage:[UIImage imageNamed:@"test2.jpg"] options:SDWebImageRefreshCached];
    //设置星级
    cell.star.text = [stars objectAtIndex:indexPath.row];
    cell.star.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    cell.star.font = [UIFont systemFontOfSize:13];
    //    cell.star.font = [UIFont fontWithName:@"SourceHanSansSC-Light" size:13];
    cell.star.shadowColor = [UIColor whiteColor];
    cell.star.shadowOffset = CGSizeMake(0.5, 1.0);
    cell.star.textAlignment = NSTextAlignmentLeft;
    //设置文字
    cell.label.text = [names objectAtIndex:indexPath.row];
    cell.label.font = [UIFont systemFontOfSize:10];
    cell.label.textAlignment = NSTextAlignmentCenter;
    cell.label.textColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
    cell.label.backgroundColor = [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:242/255.f];
    return cell;
}

//定义每个UICollectionView 的大小（返回CGSize：宽度和高度）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/4, ([UIScreen mainScreen].bounds.size.width/4-8)*1.25+8);
}

//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//选中时调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中%ld",(long)indexPath.row);
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//设定指定区内Cell的最小行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end