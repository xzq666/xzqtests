
//
//  PaoMaViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "PaoMaViewController.h"
#import "PaoMaView.h"

@interface PaoMaViewController ()

@end

@implementation PaoMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"跑马灯";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString* text = @"我得到神器宝贝了，并不是初学者的御三家：小火龙，杰尼龟，妙蛙种子。机缘巧合之下拿到了皮卡丘，没错，是皮卡丘，很激动有木有，其他都是初段的，这个直接是二段的！";
    PaoMaView* paomav = [[PaoMaView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 30) title:text];
    [self.view addSubview:paomav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
