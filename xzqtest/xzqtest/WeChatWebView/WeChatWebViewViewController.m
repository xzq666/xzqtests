//
//  WeChatWebViewViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/23.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "WeChatWebViewViewController.h"
#import "WeChatWebView.h"

@interface WeChatWebViewViewController ()

@property (nonatomic, strong) UITextField * textView;
@property (nonatomic, strong) UIButton * submitBtn;

@end

@implementation WeChatWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"仿微信浏览器返回关闭";

    [self.view addSubview:self.textView];
    [self.view addSubview:self.submitBtn];
}


- (UITextField *)textView{
    if(!_textView){
        _textView = ({
            UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 40)];
            textField.placeholder = @"输入网址";
            textField.layer.borderColor = [UIColor colorWithWhite:0.797 alpha:1.000].CGColor;
            textField.layer.borderWidth = 0.5f;
            textField;
        });
    }
    return _textView;
}


- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = ({
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 -75, CGRectGetMaxY(self.textView.frame)+50, 150, 44)];
            btn.backgroundColor = [UIColor colorWithRed:0.226 green:0.780 blue:1.000 alpha:1.000];
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _submitBtn;
}

- (void)clickedBtn:(UIButton *)btn{
    NSString * url = self.textView.text;
    if(!url.length) url = @"m.baidu.com";
    if (![url hasPrefix:@"http://"]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    WeChatWebView * web = [[WeChatWebView alloc]init];
    web.url = url;
    web.title = @"web";
    [self.navigationController pushViewController:web animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end