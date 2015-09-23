//
//  UserLoginViewController.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/23.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate> {
    __weak IBOutlet UITextField *txtFieldUsername; //用户名
    __weak IBOutlet UITextField *txtFieldPassword; //密码
    __weak IBOutlet UIButton *btnLogin; //登录
    __weak IBOutlet UIButton *btnSign; //注册
    UIView *viewLoading;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //将输入框字体颜色设置为白色
    [txtFieldUsername setTextColor:[UIColor whiteColor]];
    [txtFieldPassword setTextColor:[UIColor whiteColor]];
}

- (IBAction)buttonLoginTouched:(UIButton *)sender {
    NSString *errorMessage = [self checkUserDetails];
    if (![errorMessage length]){
        NSCharacterSet *whiteNewChars = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *username = [txtFieldUsername.text stringByTrimmingCharactersInSet:whiteNewChars];
        NSString *password = [txtFieldPassword.text stringByTrimmingCharactersInSet:whiteNewChars];
        
        viewLoading = [_MyFunctions showLoadingViewWithText:@"登录中" inView:self.view];
        NSLog(@"%@,%@",username,password);
        [AVUser logInWithUsernameInBackground:username password:password
                                        block:^(AVUser *user , NSError *error){
                                            [_MyFunctions hideLoadingView:viewLoading];
                                            if (user != nil){
                                                MyTabBarController *vc = [[MyTabBarController alloc] init];
                                                // 切换控制器
                                                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                                                window.rootViewController = vc;
                                                NSLog(@"登录成功");
                                            }else{
                                                NSString *errMsg = [error userInfo][@"error"];
                                                [[[UIAlertView alloc] initWithTitle:@"登录失败"
                                                                            message:[errMsg capitalizedString]
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"确定"
                                                                  otherButtonTitles:nil, nil] show];
                                            }
                                        }];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"登录失败"
                                    message:errorMessage
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil] show];
    }
}

#pragma mark - check user details
-(NSString *)checkUserDetails {
    NSCharacterSet *whiteNewChars = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *username = [txtFieldUsername.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString *password = [txtFieldPassword.text stringByTrimmingCharactersInSet:whiteNewChars];
    NSString *message = @"";
    if ([username length] < 3){
        message = [NSString stringWithFormat:@"用户名太短啦"];
    }
    if ([password length] < 6){
        if ([message length]) message = [NSString stringWithFormat:@"%@, ",message];
        message = [NSString stringWithFormat:@"%@请谨慎设置密码",message];
    }
    return message;
}

- (IBAction)buttonFogotTouched:(UIButton *)sender {
    NSLog(@"忘记密码");
}


#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UIView *viewTouched = [[touches anyObject] view];
    if(![viewTouched isKindOfClass:[UITextField class]]){
        [txtFieldUsername resignFirstResponder];
        [txtFieldPassword resignFirstResponder];
    }
}

@end