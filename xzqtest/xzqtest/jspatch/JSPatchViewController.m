//
//  JSPatchViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/9/21.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "JSPatchViewController.h"
//#import "JPEngine.h"

@interface JSPatchViewController ()

@end

@implementation JSPatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"JSPatch";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, 50);
    [btn setTitle:@"查看JS效果" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)handleBtn:(id)sender {
//    [JPEngine startEngine];
    
    // exec js directly
//    [JPEngine evaluateScript:@"\
//     var alertView = require('UIAlertView').alloc().init();\
//     alertView.setTitle('Alert');\
//     alertView.setMessage('AlertView from js'); \
//     alertView.addButtonWithTitle('OK');\
//     alertView.show(); \
//     "];
    
    // exec js file from network
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://crusaders.umowang.com/wp-content/themes/umowang/js/jquery-1.11.0.min.js"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"data:%@",script);
//        [JPEngine evaluateScript:script];
//    }];
    
    // exec local js file
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"data:%@",script);
//    [JPEngine evaluateScript:script];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end