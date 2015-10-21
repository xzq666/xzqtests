//
//  MessageViewController.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MessageViewController.h"

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 80, 100, 40);
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, 140, 100, 40);
    [btn2 setTitle:@"click" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
}

- (NSString *)ReplacingNewLineAndWhitespaceCharactersFromJson:(NSString *)dataStr{
    dataStr = [dataStr stringByReplacingOccurrencesOfString:@"\n" withString:@"</br>"];
    NSScanner *scanner = [[NSScanner alloc] initWithString:dataStr];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *temp;
    NSCharacterSet*newLineAndWhitespaceCharacters = [NSCharacterSet newlineCharacterSet];
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

- (void)click2 {
    //删除缓存
    NSString * cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCache"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [manager removeItemAtPath:cachePath error:nil];
    }
}

- (void)click {
    NSString * cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCache"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        //从本地读缓存文件
        NSData *resdata = [NSData dataWithContentsOfFile:cachePath];
        NSLog(@"data:%@",resdata);
        NSString *receiveStr = [[NSString alloc]initWithData:resdata encoding:NSUTF8StringEncoding];
        receiveStr = [self ReplacingNewLineAndWhitespaceCharactersFromJson:receiveStr];
        NSData *data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"res:%@",result);
    } else {
        NSLog(@"no");
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *url = @"http://api.umowang.com/index.php?c=data";
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"crusaders", @"gameid", @"pets", @"name", @"1", @"page", @"3000", @"pagesize", nil];
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"result: %@",operation.responseString);
            NSData *data = operation.responseData;
            //写缓存
            NSString * cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCache"];
            NSLog(@"Path:%@",cachePath);
            [data writeToFile:cachePath atomically:YES];
            if (operation.response.statusCode == 200) {
                NSLog(@"正常");
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

@end