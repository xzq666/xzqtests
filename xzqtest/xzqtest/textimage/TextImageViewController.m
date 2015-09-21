//
//  TextImageViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/9/14.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "TextImageViewController.h"
#import "Utility.h"

@interface TextImageViewController () {
    UILabel *_firstLabel;
    UILabel *_secondLabel;
}

@end

@implementation TextImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图文混排";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *content = @"文字加上表情[得意][酷][呲牙]";
    NSMutableAttributedString *attrStr = [Utility emotionStrWithString:content];
    _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, kWidth-20, 30)];
    _firstLabel.attributedText= attrStr;
    [self.view addSubview:_firstLabel];
    
    NSString *text = @"<微信>腾讯科技讯 微软提供免费升级的Windows 10，在全球获得普遍好评。但微软已经有一段时间没有公布最新升级数据。科技市场研究公司StatCounter发布了有关Windows升级的相关数据，显示出Windows 10的升级节奏开始放缓。<微信>另外，数据显示Windows 8用户是升级的主力军，Windows 7用户升级动力不太足。";
    NSMutableAttributedString *attrStr2 = [Utility exchangeString:@"<微信>" withText:text imageName:@"header_wechat"];
    _secondLabel = [[UILabel alloc] init];
    CGSize textSize=[text boundingRectWithSize:CGSizeMake(kWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    CGRect textRect=CGRectMake(10, 130, textSize.width, textSize.height+5);
    _secondLabel.numberOfLines = 0;
    _secondLabel.attributedText = attrStr2;
    _secondLabel.frame=textRect;
    [_secondLabel sizeToFit];
    [self.view addSubview:_secondLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end