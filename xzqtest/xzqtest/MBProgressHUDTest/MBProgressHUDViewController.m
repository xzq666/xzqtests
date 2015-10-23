//
//  MBProgressHUDViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/22.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "MBProgressHUDViewController.h"
#import "MBProgressHUD.h"

@interface MBProgressHUDViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
    
    long long expectedLength;
    long long currentLength;
}

@end

@implementation MBProgressHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MBProgressHUD测试";
    
    UIButton *progress1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress1 setTitle:@"SimpleIndeterminateProgress" forState:UIControlStateNormal];
    [progress1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress1.layer.masksToBounds = YES;
    progress1.layer.borderWidth = 0.5;
    progress1.frame = CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress1 addTarget:self action:@selector(progress1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress1];
    
    UIButton *progress2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress2 setTitle:@"WithLabel" forState:UIControlStateNormal];
    [progress2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress2.layer.masksToBounds = YES;
    progress2.layer.borderWidth = 0.5;
    progress2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 80, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress2 addTarget:self action:@selector(progress2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress2];
    
    UIButton *progress3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress3 setTitle:@"WithDetailsLabel" forState:UIControlStateNormal];
    [progress3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress3.layer.masksToBounds = YES;
    progress3.layer.borderWidth = 0.5;
    progress3.frame = CGRectMake(10, 140, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress3 addTarget:self action:@selector(progress3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress3];
    
    UIButton *progress4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress4 setTitle:@"DeterminateMode" forState:UIControlStateNormal];
    [progress4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress4.layer.masksToBounds = YES;
    progress4.layer.borderWidth = 0.5;
    progress4.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 140, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress4 addTarget:self action:@selector(progress4Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress4];
    
    UIButton *progress5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress5 setTitle:@"AnnularDeterminateMode" forState:UIControlStateNormal];
    [progress5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress5.layer.masksToBounds = YES;
    progress5.layer.borderWidth = 0.5;
    progress5.frame = CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress5 addTarget:self action:@selector(progress5Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress5];
    
    UIButton *progress6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress6 setTitle:@"BarDeterminateMode" forState:UIControlStateNormal];
    [progress6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress6.layer.masksToBounds = YES;
    progress6.layer.borderWidth = 0.5;
    progress6.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 200, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress6 addTarget:self action:@selector(progress6Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress6];
    
    UIButton *progress7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress7 setTitle:@"CustomView" forState:UIControlStateNormal];
    [progress7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress7.layer.masksToBounds = YES;
    progress7.layer.borderWidth = 0.5;
    progress7.frame = CGRectMake(10, 260, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress7 addTarget:self action:@selector(progress7Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress7];
    
    UIButton *progress8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress8 setTitle:@"ModeSwitching" forState:UIControlStateNormal];
    [progress8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress8.layer.masksToBounds = YES;
    progress8.layer.borderWidth = 0.5;
    progress8.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 260, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress8 addTarget:self action:@selector(progress8Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress8];
    
    UIButton *progress9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress9 setTitle:@"UsingBlocks" forState:UIControlStateNormal];
    [progress9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress9.layer.masksToBounds = YES;
    progress9.layer.borderWidth = 0.5;
    progress9.frame = CGRectMake(10, 320, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress9 addTarget:self action:@selector(progress9Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress9];
    
    UIButton *progress10 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress10 setTitle:@"OnWindow" forState:UIControlStateNormal];
    [progress10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress10.layer.masksToBounds = YES;
    progress10.layer.borderWidth = 0.5;
    progress10.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 320, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress10 addTarget:self action:@selector(progress10Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress10];
    
    UIButton *progress11 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress11 setTitle:@"NSURLConnection" forState:UIControlStateNormal];
    [progress11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress11.layer.masksToBounds = YES;
    progress11.layer.borderWidth = 0.5;
    progress11.frame = CGRectMake(10, 380, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress11 addTarget:self action:@selector(progress11Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress11];
    
    UIButton *progress12 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress12 setTitle:@"DimBackground" forState:UIControlStateNormal];
    [progress12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress12.layer.masksToBounds = YES;
    progress12.layer.borderWidth = 0.5;
    progress12.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 380, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress12 addTarget:self action:@selector(progress12Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress12];
    
    UIButton *progress13 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress13 setTitle:@"TextOnly" forState:UIControlStateNormal];
    [progress13 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress13.layer.masksToBounds = YES;
    progress13.layer.borderWidth = 0.5;
    progress13.frame = CGRectMake(10, 440, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress13 addTarget:self action:@selector(progress13Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress13];
    
    UIButton *progress14 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [progress14 setTitle:@"Colored" forState:UIControlStateNormal];
    [progress14 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    progress14.layer.masksToBounds = YES;
    progress14.layer.borderWidth = 0.5;
    progress14.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 440, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [progress14 addTarget:self action:@selector(progress14Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:progress14];
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
}

- (void)myMixedTask {
    // Indeterminate mode
    sleep(2);
    // Switch to determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.labelText = @"Progress";
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
    // Back to indeterminate mode
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"Cleaning up";
    sleep(2);
    // UIImageView is a UIKit class, we have to initialize it on the main thread
    __block UIImageView *imageView;
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageNamed:@"37x-Checkmark.png"];
        imageView = [[UIImageView alloc] initWithImage:image];
    });
    HUD.customView = imageView;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"Completed";
    sleep(2);
}

- (void)progress1Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress2Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress3Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
    HUD.detailsLabelText = @"正在更新数据";
    HUD.square = YES;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress4Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    // Set determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
    // myProgressTask uses the HUD instance to update progress
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress5Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
    // myProgressTask uses the HUD instance to update progress
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress6Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    // Set determinate bar mode
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.delegate = self;
    // myProgressTask uses the HUD instance to update progress
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress7Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"Completed";
    [HUD show:YES];
    [HUD hide:YES afterDelay:3];
}

- (void)progress8Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Connecting";
    HUD.minSize = CGSizeMake(135.f, 135.f);
    [HUD showWhileExecuting:@selector(myMixedTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress9Click {
#if NS_BLOCKS_AVAILABLE
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"With a block";
    [hud showAnimated:YES whileExecutingBlock:^{
        [self myTask];
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
#endif
}

- (void)progress10Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress11Click {
    NSURL *URL = [NSURL URLWithString:@"http://a1408.g.akamai.net/5/1408/1388/2005110403/1a1a1ad948be278cff2d96046ad90768d848b41947aa1986/sample_iPod.m4v.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
}

#pragma mark - NSURLConnectionDelegete
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    expectedLength = MAX([response expectedContentLength], 1);
    NSLog(@"-->%lld",expectedLength);
    currentLength = 0;
    HUD.mode = MBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    currentLength += [data length];
    NSLog(@"data-->%lld",currentLength);
    HUD.progress = currentLength / (float)expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:1];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [HUD hide:YES];
}

- (void)progress12Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)progress13Click {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"一些信息...";
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}

- (void)progress14Click {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    // Set the hud to display with a color
    HUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end