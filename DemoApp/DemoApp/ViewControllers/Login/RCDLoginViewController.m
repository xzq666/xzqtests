//
//  RCDLoginViewController.m
//  DemoApp
//
//  Created by 许卓权 on 15/9/30.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "RCDLoginViewController.h"
#import "RCUnderlineTextField.h"
#import "RCDFindPswViewController.h"
#import "RCDRegisterViewController.h"
#import "MBProgressHUD.h"
#import "AppkeyModel.h"
#import "AFHttpTool.h"
#import "RCDLoginInfo.h"
#import "UITextField+Shake.h"
#import "RCDTextFieldValidate.h"
#import "RCDCommonDefine.h"
#import "RCDHttpTool.h"
#import "RCDRCIMDataSource.h"

@interface RCDLoginViewController ()<UITextFieldDelegate>

@property (retain, nonatomic) RCAnimatedImagesView* animatedImagesView;
@property (weak, nonatomic) UITextField* emailTextField;
@property (weak, nonatomic) UITextField* pwdTextField;
@property (nonatomic, strong) UIView* headBackground;
@property (nonatomic, strong) UIImageView* rongLogo;
@property (nonatomic, strong) UIView* inputBackground;
@property (nonatomic, strong) UIView* statusBarView;
@property (nonatomic, strong) UILabel* errorMsgLb;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) AppkeyModel *currentModel;
@property (nonatomic, strong) UILabel *appKeyLabel;
@property (nonatomic, strong) UIButton *changeKeyButton;
@property (nonatomic) int loginFailureTimes;
@property (nonatomic) BOOL rcDebug;

@end

@implementation RCDLoginViewController

#define UserTextFieldTag 1000
#define PassWordFieldTag 1001
@synthesize animatedImagesView = _animatedImagesView;
@synthesize inputBackground = _inputBackground;
MBProgressHUD* hud ;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rcDebug = [[NSUserDefaults standardUserDefaults] boolForKey:@"rongcloud appkey debug"];
    if (self.rcDebug) {//测试切换appkey使用
        NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:@[@"z3v5yqkbv8v30", @"lmxuhwagxrxmd", @"e0x9wycfx7flq"], @"keys", @[@1, @2, @0], @"envs", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    //添加动态图
    self.animatedImagesView = [[RCAnimatedImagesView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.animatedImagesView];
    self.animatedImagesView.delegate = self;
    
    //添加头部内容
    _headBackground = [[UIView alloc] initWithFrame:CGRectMake(0, -100, self.view.bounds.size.width, 50)];
    _headBackground.userInteractionEnabled = YES;
    _headBackground.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:_headBackground];
    
    if (self.rcDebug) {
        self.appKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 150, 40)];
        self.appKeyLabel.text = @"请选择AppKey";
        
        self.changeKeyButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 20, 120, 40)];
        [self.changeKeyButton setTitle:@"选择" forState:UIControlStateNormal];
        [self.changeKeyButton  addTarget:self action:@selector(onChangeKey:) forControlEvents:UIControlEventTouchUpInside];
        [self.changeKeyButton setBackgroundColor:[UIColor redColor]];
        self.changeKeyButton .imageView.contentMode = UIViewContentModeCenter;
        
        [self.view addSubview:self.appKeyLabel];
        [self.view addSubview:self.changeKeyButton];
    }
    
    UIButton* registerHeadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    [registerHeadButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [registerHeadButton setTitleColor:[[UIColor alloc] initWithRed:153 green:153 blue:153 alpha:0.5] forState:UIControlStateNormal];
    registerHeadButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [registerHeadButton.titleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [registerHeadButton addTarget:self action:@selector(forgetPswEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [_headBackground addSubview:registerHeadButton];
    
    //添加图标
    UIImage* rongLogoSmallImage = [UIImage imageNamed:@"title_logo_small"];
    UIImageView* rongLogoSmallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 60, 5, 100, 40)];
    [rongLogoSmallImageView setImage:rongLogoSmallImage];
    
    [rongLogoSmallImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    rongLogoSmallImageView.contentMode = UIViewContentModeScaleAspectFit;
    rongLogoSmallImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    rongLogoSmallImageView.clipsToBounds = YES;
    [_headBackground addSubview:rongLogoSmallImageView];
    
    //顶部按钮
    UIButton* forgetPswHeadButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 0, 70, 50)];
    [forgetPswHeadButton setTitle:@"新用户" forState:UIControlStateNormal];
    [forgetPswHeadButton setTitleColor:[[UIColor alloc] initWithRed:153 green:153 blue:153 alpha:0.5] forState:UIControlStateNormal];
    [forgetPswHeadButton.titleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [forgetPswHeadButton addTarget:self action:@selector(registerEvent) forControlEvents:UIControlEventTouchUpInside];
    [_headBackground addSubview:forgetPswHeadButton];
    
    UIImage* rongLogoImage = [UIImage imageNamed:@"login_logo"];
    _rongLogo = [[UIImageView alloc] initWithImage:rongLogoImage];
    _rongLogo.contentMode = UIViewContentModeScaleAspectFit;
    _rongLogo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_rongLogo];
    
    //中部内容输入区
    _inputBackground = [[UIView alloc] initWithFrame:CGRectZero];
    _inputBackground.translatesAutoresizingMaskIntoConstraints = NO;
    _inputBackground.userInteractionEnabled = YES;
    [self.view addSubview:_inputBackground];
    _errorMsgLb = [[UILabel alloc] initWithFrame:CGRectZero];
    _errorMsgLb.text = @"";
    _errorMsgLb.font = [UIFont fontWithName:@"Heiti SC" size:12.0];
    _errorMsgLb.translatesAutoresizingMaskIntoConstraints = NO;
    _errorMsgLb.textColor = [UIColor colorWithRed:204.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
    [self.view addSubview:_errorMsgLb];
    
    //用户名
    RCUnderlineTextField* userNameTextField = [[RCUnderlineTextField alloc] initWithFrame:CGRectZero];
    userNameTextField.backgroundColor = [UIColor clearColor];
    userNameTextField.tag = UserTextFieldTag;
    userNameTextField.delegate=self;
    //_account.placeholder=[NSString stringWithFormat:@"Email"];
    UIColor* color = [UIColor whiteColor];
    userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"邮箱" attributes:@{ NSForegroundColorAttributeName : color }];
    userNameTextField.textColor = [UIColor whiteColor];
//    userNameTextField.text = [self getDefaultUserName];
    if (userNameTextField.text.length > 0) {
        [userNameTextField setFont:[UIFont fontWithName:@"Heiti SC" size:25.0]];
    }
    userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameTextField.adjustsFontSizeToFitWidth = YES;
    [userNameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_inputBackground addSubview:userNameTextField];
    
    //密码
    RCUnderlineTextField* passwordTextField = [[RCUnderlineTextField alloc] initWithFrame:CGRectZero];
    passwordTextField.tag = PassWordFieldTag;
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate=self;
    //passwordTextField.delegate = self;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{ NSForegroundColorAttributeName : color }];
    //passwordTextField.text = [self getDefaultUserPwd];
    [_inputBackground addSubview:passwordTextField];
//    passwordTextField.text = [self getDefaultUserPwd];
    self.passwordTextField = passwordTextField;
    
    //UIEdgeInsets buttonEdgeInsets = UIEdgeInsetsMake(0, 7.f, 0, 7.f);
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self action:@selector(actionLogin:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
    loginButton.imageView.contentMode = UIViewContentModeCenter;
    loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_inputBackground addSubview:loginButton];
    UIButton* userProtocolButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [userProtocolButton setTitle:@"阅读用户协议" forState:UIControlStateNormal];
    [userProtocolButton setTitleColor:[[UIColor alloc] initWithRed:153 green:153 blue:153 alpha:0.5] forState:UIControlStateNormal];
    
    [userProtocolButton.titleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [userProtocolButton addTarget:self action:@selector(userProtocolEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:userProtocolButton];
    
    //底部按钮区
    UIView* bottomBackground = [[UIView alloc] initWithFrame:CGRectZero];
    UIButton* registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, -20, 80, 50)];
    [registerButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [registerButton setTitleColor:[[UIColor alloc] initWithRed:153 green:153 blue:153 alpha:0.5] forState:UIControlStateNormal];
    [registerButton.titleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [registerButton addTarget:self action:@selector(forgetPswEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomBackground addSubview:registerButton];
    
    UIButton* forgetPswButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, -20, 80, 50)];
    [forgetPswButton setTitle:@"新用户" forState:UIControlStateNormal];
    [forgetPswButton setTitleColor:[[UIColor alloc] initWithRed:153 green:153 blue:153 alpha:0.5] forState:UIControlStateNormal];
    [forgetPswButton.titleLabel setFont:[UIFont fontWithName:@"Heiti SC" size:14.0]];
    [forgetPswButton addTarget:self action:@selector(registerEvent) forControlEvents:UIControlEventTouchUpInside];
    [bottomBackground addSubview:forgetPswButton];
    
    [self.view addSubview:bottomBackground];
    
    bottomBackground.translatesAutoresizingMaskIntoConstraints = NO;
    userProtocolButton.translatesAutoresizingMaskIntoConstraints = NO;
    passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    userNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    //添加约束
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bottomBackground attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]];
    NSDictionary* views = NSDictionaryOfVariableBindings(_errorMsgLb, _rongLogo, _inputBackground, userProtocolButton, bottomBackground);
    NSArray* viewConstraints = [[[[[[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-41-[_inputBackground]-41-|" options:0 metrics:nil views:views]
                                    arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_rongLogo]-60-|" options:0 metrics:nil views:views]]
                                   arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_rongLogo(==60)]-10-[_errorMsgLb(==10)]-20-[_inputBackground(180)]-20-[userProtocolButton(==20)]" options:0 metrics:nil views:views]]
                                  arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomBackground(==50)]" options:0 metrics:nil views:views]]
                                 arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[bottomBackground]-10-|" options:0 metrics:nil views:views]]
                                arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[_errorMsgLb]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:viewConstraints];
    NSLayoutConstraint* userProtocolLabelConstraint = [NSLayoutConstraint constraintWithItem:userProtocolButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0];
    [self.view addConstraint:userProtocolLabelConstraint];
    NSDictionary* inputViews = NSDictionaryOfVariableBindings(userNameTextField, passwordTextField, loginButton);
    NSArray* inputViewConstraints = [[[[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[userNameTextField]|" options:0 metrics:nil views:inputViews] arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[passwordTextField]|" options:0 metrics:nil views:inputViews]] arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[userNameTextField(60)]-[passwordTextField(60)]-[loginButton(50)]" options:0 metrics:nil views:inputViews]] arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loginButton]|" options:0 metrics:nil views:inputViews]];
    [_inputBackground addConstraints:inputViewConstraints];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    _statusBarView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:_statusBarView];
    [self.view setNeedsLayout];
    [self.view setNeedsUpdateConstraints];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)onChangeKey:(id)sender {
}

/*阅读用户协议*/
- (void)userProtocolEvent {
}

/*注册*/
- (void)registerEvent {
    RCDRegisterViewController* temp = [[RCDRegisterViewController alloc] init];
    [self.navigationController pushViewController:temp animated:YES];
}

/*找回密码*/
- (void)forgetPswEvent {
    RCDFindPswViewController* temp = [[RCDFindPswViewController alloc] init];
    [self.navigationController pushViewController:temp animated:YES];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.text.length == 0) {
        [textField setFont:[UIFont fontWithName:@"Heiti SC" size:18.0]];
    } else {
        [textField setFont:[UIFont fontWithName:@"Heiti SC" size:25.0]];
    }
    if ([textField.text isEqualToString:@"appkeydebug"]) {
        [[NSUserDefaults standardUserDefaults] setBool:!self.rcDebug forKey:@"rongcloud appkey debug"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:(!self.rcDebug ? @"进入debug模式，请重新启动应用！":@"退出debug模式，请重新启动应用") delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil];
        [alert show];
        self.rcDebug = !self.rcDebug;
        exit(0);
        return;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)actionLogin:(id)sender {
    NSString* userName = [(UITextField*)[self.view viewWithTag:UserTextFieldTag] text];
    NSString* userPwd = [(UITextField*)[self.view viewWithTag:PassWordFieldTag] text];
    [self login:userName password:userPwd];
}

//键盘升起时动画
- (void)keyboardWillShow:(NSNotification*)notif {
    CATransition* animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.25;
    [_rongLogo.layer addAnimation:animation forKey:nil];
    _rongLogo.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0.f, -50, self.view.frame.size.width, self.view.frame.size.height);
        _headBackground.frame=CGRectMake(0, 70, self.view.bounds.size.width, 50);
        _statusBarView.frame = CGRectMake(0.f,50, self.view.frame.size.width,20);
    } completion:nil];
}

//键盘关闭时动画
- (void)keyboardWillHide:(NSNotification*)notif {
    CATransition* animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.25;
    [_rongLogo.layer addAnimation:animation forKey:nil];
    _rongLogo.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
        CGRectMake(0, -100, self.view.bounds.size.width, 50);
        _headBackground.frame=CGRectMake(0, -100, self.view.bounds.size.width, 50);
        _statusBarView.frame = CGRectMake(0.f,0, self.view.frame.size.width,20);
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.animatedImagesView startAnimating];
    if (self.rcDebug) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.animatedImagesView stopAnimating];
}

- (void)loginSuccess:(NSString *)userName password:(NSString *)password token:(NSString *)token userId:(NSString *)userId {
    //保存默认用户
    [DEFAULTS setObject:userName forKey:@"userName"];
    [DEFAULTS setObject:password forKey:@"userPwd"];
    [DEFAULTS setObject:token forKey:@"userToken"];
    [DEFAULTS setObject:userId forKey:@"userId"];
    [DEFAULTS synchronize];
    
    //设置当前的用户信息
    RCUserInfo *_currentUserInfo = [[RCUserInfo alloc]initWithUserId:userId name:userName portrait:nil];
    [RCIMClient sharedRCIMClient].currentUserInfo = _currentUserInfo;
    [RCDHTTPTOOL getUserInfoByUserID:userId
                          completion:^(RCUserInfo* user) {
                              [[RCIM sharedRCIM]refreshUserInfoCache:user withUserId:userId];
                              
                          }];
    //同步群组
    [RCDDataSource syncGroups];
    [RCDDataSource syncFriendList:^(NSMutableArray *friends) {}];
    BOOL notFirstTimeLogin = [DEFAULTS boolForKey:@"notFirstTimeLogin"];
    if (!notFirstTimeLogin) {
        [RCDDataSource cacheAllData:^{ //auto saved after completion.
//            [DEFAULTS setBool:YES forKey:@"notFirstTimeLogin"];
//            [DEFAULTS synchronize];
        }];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *rootNavi = [storyboard instantiateViewControllerWithIdentifier:@"rootNavi"];
        [ShareApplicationDelegate window].rootViewController = rootNavi;
        [hud hide:YES];
        NSLog(@"登录成功");
        
    });
}

/**
 *  登录融云服务器
 *
 *  @param userName 用户名
 *  @param token    token
 *  @param password 密码
 */
- (void)loginRongCloud:(NSString *)userName token:(NSString *)token password:(NSString *)password {
    //登陆融云服务器
    NSLog(@"token-->%@",token);
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        [self loginSuccess:userName password:password token:token userId:userId];
    } error:^(RCConnectErrorCode status) {
        //关闭HUD
        [hud hide:YES];
        NSLog(@"RCConnectErrorCode is %ld",(long)status);
        _errorMsgLb.text=@"Token无效！";
        [_pwdTextField shake];
    } tokenIncorrect:^{
        NSLog(@"IncorrectToken");
        //        if (_loginFailureTimes<3) {
        //            _loginFailureTimes++;
        //            [AFHttpTool getTokenSuccess:^(id response) {
        //                [self loginRongCloud:userName token:token password:password];
        //            } failure:^(NSError *err) {
        //                dispatch_async(dispatch_get_main_queue(), ^{
        //                [hud hide:YES];
        //                _errorMsgLb.text=@"Token无效";
        //                });
        //            }];
        //        }else
        //        {
        _loginFailureTimes=0;
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            _errorMsgLb.text=@"Token无效";
        });
        //        }
        
        
    }];
}

/**
 *  登陆
 */
- (void)login:(NSString *)userName password:(NSString *)password {
    RCNetworkStatus stauts=[[RCIMClient sharedRCIMClient]getCurrentNetworkStatus];
    if (RC_NotReachable == stauts) {
        _errorMsgLb.text=@"当前网络不可用，请检查！";
        return;
    } else {
        _errorMsgLb.text=@"";
    }
    if ([self validateUserName:userName userPwd:password]) {
        if (self.rcDebug) {
            [[RCIM sharedRCIM] initWithAppKey:self.currentModel.appKey];
        }
        hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"登录中...";
        [hud show:YES];
        [AFHttpTool loginWithEmail:userName password:password env:(self.currentModel == nil ? 1 : self.currentModel.env)
                           success:^(id response) {
                               if ([response[@"code"] intValue] == 200) {
                                   RCDLoginInfo *loginInfo = [RCDLoginInfo shareLoginInfo];
                                   loginInfo = [loginInfo initWithDictionary:response[@"result"] error:NULL];
                                   [AFHttpTool getTokenSuccess:^(id response) {
                                       NSString *token = response[@"result"][@"token"];
                                       [self loginRongCloud:userName token:token password:password];
                                   } failure:^(NSError *err) {
                                       //关闭HUD
                                       [hud hide:YES];
                                       NSLog(@"NSError is %@",err);
                                       _errorMsgLb.text=@"APP服务器错误！";
                                       [_pwdTextField shake];
                                   }];
                               }else{
                                   //关闭HUD
                                   [hud hide:YES];
                                   int _errCode = [response[@"code"] intValue];
                                   NSLog(@"NSError is %d",_errCode);
                                   if(_errCode==500) {
                                       _errorMsgLb.text=@"APP服务器错误！";
                                   } else {
                                       _errorMsgLb.text=@"用户名或密码错误！";
                                   }
                                   [_pwdTextField shake];
                               }
                           }
                           failure:^(NSError* err) {
                               //关闭HUD
                               [hud hide:YES];
                               NSLog(@"NSError is %ld",(long)err.code);
                               if (err.code == 3840) {
                                   _errorMsgLb.text=@"用户名或密码错误！";
                                   [_pwdTextField shake];
                               } else{
                                   _errorMsgLb.text=@"DemoServer错误！";
                                   [_pwdTextField shake];
                               }
                           }];
    }
}

//验证用户信息格式
- (BOOL)validateUserName:(NSString*)userName userPwd:(NSString*)userPwd {
    NSString* alertMessage = nil;
    if (userName.length == 0) {
        alertMessage = @"用户名不能为空!";
    }
    else if (userPwd.length == 0) {
        alertMessage = @"密码不能为空!";
    }
    if (self.rcDebug) {
        if (self.currentModel == nil) {
            alertMessage = @"请选择AppKey";
        }
    }
    if (alertMessage) {
        _errorMsgLb.text = alertMessage;
        [_pwdTextField shake];
        return NO;
    }
    return [RCDTextFieldValidate validateEmail:userName] && [RCDTextFieldValidate validatePassword:userPwd];
    return YES;
}

- (NSUInteger)animatedImagesNumberOfImages:(RCAnimatedImagesView*)animatedImagesView {
    return 2;
}

- (UIImage*)animatedImagesView:(RCAnimatedImagesView*)animatedImagesView imageAtIndex:(NSUInteger)index {
    return [UIImage imageNamed:@"login_background.png"];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

@end