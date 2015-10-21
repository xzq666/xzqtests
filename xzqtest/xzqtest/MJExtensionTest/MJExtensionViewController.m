//
//  MJExtensionViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/20.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "MJExtensionViewController.h"
#import "EasyDicToModelViewController.h"
#import "JSONStringToModelViewController.h"
#import "ModelContainsModelViewController.h"
#import "ModelContainsModelArrayViewController.h"
#import "JSONArrToModelArrViewController.h"

@interface MJExtensionViewController ()

@end

@implementation MJExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MJExtension测试";
    
    UIButton *easy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [easy setTitle:@"简单字典转模型" forState:UIControlStateNormal];
    [easy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    easy.layer.masksToBounds = YES;
    easy.layer.borderWidth = 0.5;
    easy.frame = CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [easy addTarget:self action:@selector(easyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:easy];
    
    UIButton *jsonstringToModel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [jsonstringToModel setTitle:@"JSON串转模型" forState:UIControlStateNormal];
    [jsonstringToModel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jsonstringToModel.layer.masksToBounds = YES;
    jsonstringToModel.layer.borderWidth = 0.5;
    jsonstringToModel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 80, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [jsonstringToModel addTarget:self action:@selector(jsonstringToModelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jsonstringToModel];
    
    UIButton *modelContainsModel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [modelContainsModel setTitle:@"模型中嵌套模型" forState:UIControlStateNormal];
    [modelContainsModel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    modelContainsModel.layer.masksToBounds = YES;
    modelContainsModel.layer.borderWidth = 0.5;
    modelContainsModel.frame = CGRectMake(10, 140, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [modelContainsModel addTarget:self action:@selector(modelContainsModelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modelContainsModel];
    
    UIButton *modelContainsModelArray = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [modelContainsModelArray setTitle:@"模型中有含模型的数组" forState:UIControlStateNormal];
    [modelContainsModelArray setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    modelContainsModelArray.layer.masksToBounds = YES;
    modelContainsModelArray.layer.borderWidth = 0.5;
    modelContainsModelArray.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2+10, 140, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [modelContainsModelArray addTarget:self action:@selector(modelContainsModelArrayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modelContainsModelArray];
    
    UIButton *jsonArrToModeaArr = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [jsonArrToModeaArr setTitle:@"字典数组转模型数组" forState:UIControlStateNormal];
    [jsonArrToModeaArr setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jsonArrToModeaArr.layer.masksToBounds = YES;
    jsonArrToModeaArr.layer.borderWidth = 0.5;
    jsonArrToModeaArr.frame = CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width/2-20, 40);
    [jsonArrToModeaArr addTarget:self action:@selector(jsonArrToModeaArrClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jsonArrToModeaArr];
}

- (void)easyClick {
    EasyDicToModelViewController *vc = [[EasyDicToModelViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jsonstringToModelClick {
    JSONStringToModelViewController *vc = [[JSONStringToModelViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)modelContainsModelClick {
    ModelContainsModelViewController *vc = [[ModelContainsModelViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)modelContainsModelArrayClick {
    ModelContainsModelArrayViewController *vc = [[ModelContainsModelArrayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jsonArrToModeaArrClick {
    JSONArrToModelArrViewController *vc = [[JSONArrToModelArrViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end