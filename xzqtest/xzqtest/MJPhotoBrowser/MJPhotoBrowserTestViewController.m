//
//  MJPhotoBrowserTestViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/22.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "MJPhotoBrowserTestViewController.h"

#import "UIImageView+WebCache.h"
#import "MyPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "MLPhotoBrowserAssets.h"
#import "MLPhotoBrowserViewController.h"

@interface MJPhotoBrowserTestViewController ()
//<MLPhotoBrowserViewControllerDelegate,MLPhotoBrowserViewControllerDataSource>
//
//@property (weak,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) NSMutableArray *photos;

@end

@implementation MJPhotoBrowserTestViewController

- (NSMutableArray *)photos{
    if (!_photos) {
        
        // 注意：
        // 如果是用数据源的方式传 self.photos = @[@"http://url1",@"http://url2"] 就好了
        // 下面是直接传photo模型
        
        self.photos = [NSMutableArray arrayWithArray:@[
                                                       @"http://imgsrc.baidu.com/forum/pic/item/3f7dacaf2edda3cc7d2289ab01e93901233f92c5.jpg",
                                                       @"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg"]];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MJPhotoBrowser测试";
    
    // 这个属性不能少
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 100, 100)];
    [img1 sd_setImageWithURL:[NSURL URLWithString:[self.photos objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"back.jpg"]];
    img1.tag = 0;
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clcik:)];
    img1.userInteractionEnabled = YES;
    [img1 addGestureRecognizer:ges1];
    [self.view addSubview:img1];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 180, 100, 100)];
    [img2 sd_setImageWithURL:[NSURL URLWithString:[self.photos objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"back.jpg"]];
    img2.tag = 1;
    UITapGestureRecognizer *ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clcik:)];
    img2.userInteractionEnabled = YES;
    [img2 addGestureRecognizer:ges2];
    [self.view addSubview:img2];
}

- (void)clcik:(UITapGestureRecognizer *)recognizer {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:recognizer.view.tag inSection:0];
//    // 图片游览器
//    MLPhotoBrowserViewController *photoBrowser = [[MLPhotoBrowserViewController alloc] init];
//    // 缩放动画
//    photoBrowser.status = UIViewAnimationAnimationStatusZoom;
//    // 数据源/delegate
//    photoBrowser.delegate = self;
//    photoBrowser.dataSource = self;
//    // 当前选中的值
//    photoBrowser.currentIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
//    // 展示控制器
//    [photoBrowser showPickerVc:self];
    
    
    
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    int count = 2;
    for (int i = 0; i <count; i++){
        MyPhoto *pic = [[MyPhoto alloc] init];
        pic.original_pic = [self.photos objectAtIndex:i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:pic.original_pic];
        //设置来源于哪一个UIImageView
        photo.srcImageView = self.view.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    // 4.显示浏览器
    [browser show];
}

//#pragma mark - <MLPhotoBrowserViewControllerDataSource>
//- (NSInteger)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
//    return self.photos.count;
//}
//
//#pragma mark - 每个组展示什么图片,需要包装下MLPhotoBrowserPhoto
//- (MLPhotoBrowserPhoto *) photoBrowser:(MLPhotoBrowserViewController *)browser photoAtIndexPath:(NSIndexPath *)indexPath{
//    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
//    MLPhotoBrowserPhoto *photo = [[MLPhotoBrowserPhoto alloc] init];
//    photo.photoObj = [self.photos objectAtIndex:indexPath.row];
//    // 缩略图
//    UIImageView *btn = [[UIImageView alloc] init];
//    [btn sd_setImageWithURL:[self.photos objectAtIndex:indexPath.row]];
//    photo.toView = btn;
//    photo.thumbImage = btn.image;
//    return photo;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end