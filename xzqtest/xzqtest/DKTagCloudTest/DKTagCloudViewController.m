//
//  DKTagCloudViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/11/4.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "DKTagCloudViewController.h"
#import "DKTagCloudView.h"

@interface DKTagCloudViewController ()

@property (nonatomic, weak) DKTagCloudView *tagCloudView;

@property (strong, nonatomic) WWTagsCloudView* tagCloud;
@property (strong, nonatomic) NSArray* tags;

@end

@implementation DKTagCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"标签云";
    DKTagCloudView *tagCloud = [[DKTagCloudView alloc] initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
    [self.view addSubview:tagCloud];
    self.tagCloudView = tagCloud;
    self.tagCloudView.maxFontSize = 20;
    self.tagCloudView.titls = @[
                                @"逆转裁判",
                                @"同人",
                                @"克鲁赛德",
                                @"GAL",
                                @"英雄传说",
                                @"Konami",
                                @"FPS",
                                @"ACT",
                                @"RPG",
                                @"皮卡丘",
                                @"口袋妖怪",
                                @"AVG",
                                @"牛肉拉面",
                                @"maxFontSize",
                                @"randomColors",
                                @"generate",
                                @"UIView",
                                @"NSInteger",
                                @"Min font size",
                                @"Max font size",
                                ];
    [self.tagCloudView setTagClickBlock:^(NSString *title, NSInteger index) {
        NSLog(@"title:%@,index:%zd",title,index);
    }];
    [self.tagCloudView generate];
    
    
//    _tags = @[@"当幸福来敲门", @"海滩", @"如此的夜晚", @"大进军", @"险地", @"姻缘订三生", @"死亡城", @"苦海孤雏", @"老人与海", @"烽火异乡情", @"父亲离家时", @"无情大地补情天", @"以眼还眼", @"锦绣人生", @"修女传", @"第十三号", @"末代启示录", @"西北前线", @"西北区骑警", @"黄金广场大劫案", @"畸恋山庄", @"守夜", @"我们爱黑夜", @"恐怖夜校", @"夏尔洛结婚", @"特别的一夜", @"下一站格林威治村", @"升职记", @"恶夜之吻", @"木匠兄妹故事", ];
//    NSArray* colors = @[[UIColor colorWithRed:0 green:0.63 blue:0.8 alpha:1], [UIColor colorWithRed:1 green:0.2 blue:0.31 alpha:1], [UIColor colorWithRed:0.53 green:0.78 blue:0 alpha:1], [UIColor colorWithRed:1 green:0.55 blue:0 alpha:1]];
//    NSArray* fonts = @[[UIFont systemFontOfSize:12], [UIFont systemFontOfSize:16], [UIFont systemFontOfSize:20]];
//    //初始化
//    _tagCloud = [[WWTagsCloudView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
//                                               andTags:_tags
//                                          andTagColors:colors
//                                              andFonts:fonts
//                                       andParallaxRate:1.7
//                                          andNumOfLine:9];
//    _tagCloud.delegate = self;
//    [self.view addSubview:_tagCloud];
}

-(void)tagClickAtIndex:(NSInteger)tagIndex {
    NSLog(@"%@",_tags[tagIndex]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"memory full");
}

@end