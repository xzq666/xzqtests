//
//  PayTestViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/29.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "PayTestViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AFNetworking.h"

@implementation PayTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"支付宝快捷支付测试";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 80, 100, 40);
    [btn setTitle:@"支付" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"uid", @"1", @"mid", @"0.01", @"total", @"提交任务", @"subject", nil];
    NSString *url =  @"http://120.26.215.224:8080/jk/alipay";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:param
          success:^(AFHTTPRequestOperation *operation,id responseObj){
              NSDictionary *res = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
              NSString *order = [res objectForKey:@"order"];
              NSLog(@"order-->%@", order);
              [[AlipaySDK defaultService] payOrder:order fromScheme:@"xzqtest" callback:^(NSDictionary *resultDic) {
                  NSLog(@"reslut = %@",resultDic);
              }];
          } failure:^(AFHTTPRequestOperation *operation,NSError *error){
              NSLog(@"error-->%@", error);
          }
     ];
}

@end