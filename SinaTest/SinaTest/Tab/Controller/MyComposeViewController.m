//
//  MyComposeViewController.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/24.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyComposeViewController.h"
#import "MyEmotionKeyboard.h"
#import "MyComposeToolbar.h"
#import "MyComposePhotosView.h"
#import "MyEmotionTextView.h"
#import "JKImagePickerController.h"

#define SourceCompose @"compose"
#define SourceComment @"comment"

@interface MyComposeViewController ()<MyComposeToolbarDelegate,UITextViewDelegate,JKImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic , weak) MyEmotionTextView *textView;
@property (nonatomic , weak) MyComposeToolbar *toolbar;
@property (nonatomic , weak) MyComposePhotosView *photosView;
@property (nonatomic , weak) MyEmotionKeyboard *keyboard;
@property (nonatomic , strong) MyHttpTool *HttpManager;

//是否正在切换键盘
@property (nonatomic ,assign, getter=isChangingKeyboard) BOOL ChangingKeyboard;

@end

@implementation MyComposeViewController

- (MyEmotionKeyboard *)keyboard {
    if (_keyboard) {
        self.keyboard = [MyEmotionKeyboard keyboard];
        self.keyboard.width = MyScreenWidth;
        self.keyboard.height = 216;
    }
    return _keyboard;
}

- (MyHttpTool *)HttpManager {
    if(_HttpManager == nil){
        _HttpManager = [[MyHttpTool alloc] init];
    }
    return _HttpManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航标题
    [self setupNavigationItem];
    //添加输入控件
    [self setupTextView];
    //添加工具条
    [self setupToolbar];
    //添加显示图片相册控件
    [self setupPhotosView];
    self.toolbar.showEmotionButton = YES;
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:MyEmotionDidSelectedNotification object:nil];
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:MyEmotionDidDeletedNotification object:nil];
}

/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note {
    MyEmotion *emotion = note.userInfo[MySelectedEmotion];
    // 1.拼接表情
    [self.textView appendEmotion:emotion];
    // 2.检测文字长度
    [self textViewDidChange:self.textView];
}

/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note {
    // 往回删
    [self.textView deleteBackward];
}

/**
 *  监听文字该表
 *
 *  @param textView
 */
- (void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;;
}

//设置导航标题
- (void)setupNavigationItem {
    NSString *name = [AVUser currentUser].username;
    if (name) {
        NSString *prefix = @"";
        if ([self.source isEqual:SourceCompose]){
            prefix = @"发微博";
        }
        if ([self.source isEqual:SourceComment]){
            prefix = @"发评论";
        }
        NSString *text = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[text rangeOfString:prefix]];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:[text rangeOfString:name]];
        
        //创建label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.attributedText = string;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    } else {
        self.title = @"发微博";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

// 添加输入控件
- (void)setupTextView {
    // 1.创建输入控件
    MyEmotionTextView *textView = [[MyEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES ;//垂直方向上有弹簧效果
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    // 2.设置提醒文字
    textView.placeholder = @"发表新微博...";
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 添加工具条
- (void)setupToolbar {
    MyComposeToolbar *toolbar = [[MyComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.delegate = self;
    self.toolbar = toolbar;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
}

// 添加显示图片的相册控件
- (void)setupPhotosView {
    MyComposePhotosView *photosView = [[MyComposePhotosView alloc] init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 70;
    [photosView.addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    photosView.addButton.hidden = YES;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

- (void)addButtonClicked {
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 9;
    imagePickerController.selectedAssetArray = self.photosView.assetsArray;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏：工具条（toolbar）随着键盘移动
 */
- (void)keyboardWillHide:(NSNotification *)note {
    //需要判断是否自定义切换的键盘
    if (self.isChangingKeyboard) {
        self.ChangingKeyboard = NO;
        return;
    }
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;//回复之前的位置
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note {
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/**
 *  view消失前先再撤销键盘，避免退出控制器view的时候会卡住
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    if ([self.source isEqual:SourceCompose]){
//        if (self.photosView.assetsArray.count){
//            NSLog(@"%d",(int)self.photosView.assetsArray.count);
//            [self sendStatusWithImage];
//        }else{
            [self sendStatusWithoutImage];
//        }
    }
//    if ([self.source isEqual:SourceComment]){
//        [self sendStatusWithImage];
//    }
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

//文本内容（无图片）发布
- (void)sendStatusWithoutImage {
    if ([self.source  isEqual: SourceCompose]){
        if (self.textView.realText.length != 0 ){
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSError *error;
            [self.HttpManager createStatusWithText:self.textView.realText error:&error];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (error == nil){
                [MBProgressHUD showSuccess:@"发表成功"];
            }else{
                [MBProgressHUD showError:@"发表失败"];
            }
        }else{
            [MBProgressHUD showError:@"内容为空,发表失败"];
        }
    }
}

#pragma mark - MyComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(MyComposeToolbar *)toolbar didClickedButton:(MyComposeToolbarButtonType)buttonType {
    switch (buttonType) {
        case MyComposeToolbarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case MyComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case MyComposeToolbarButtonTypeEmotion: // 表情
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

/**
 *  打开照相机
 */
- (void)openCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum {
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 9;
    imagePickerController.selectedAssetArray = self.photosView.assetsArray;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}

/**
 *  打开表情
 */
- (void)openEmotion {
    // 正在切换键盘
    self.ChangingKeyboard = YES;
    if (!self.toolbar.showEmotionButton) { // 当前显示的是自定义键盘，切换为系统自带的键盘
        self.textView.inputView = nil;
        // 显示表情图片
        self.toolbar.showEmotionButton = YES;
    } else { // 当前显示的是系统自带的键盘，切换为自定义键盘
        // 如果临时更换了文本框的键盘，一定要重新打开键盘
        self.textView.inputView = self.keyboard;
        // 不显示表情图片
        self.toolbar.showEmotionButton = NO;
    }
    // 关闭键盘
    [self.textView resignFirstResponder];
    // 关闭键盘后，changKeyboard 为no
    self.ChangingKeyboard = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.textView becomeFirstResponder];
    });
}

#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source {
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source {
    self.photosView.assetsArray = [NSMutableArray arrayWithArray:assets];
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        if ([self.photosView.assetsArray count] > 0){
            self.photosView.addButton.hidden = NO;
        }
        [self.photosView.collectionView reloadData];
    }];
}

- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker {
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end