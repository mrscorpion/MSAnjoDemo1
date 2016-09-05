//
//  MSPhoneLoginViewController.m
//  MSAudio
//
//  Created by mr.scorpion on 15/11/2.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "MSPhoneLoginViewController.h"
#import "HomePageAnimationUtil.h"

#define MSNotificationCenter [NSNotificationCenter defaultCenter]
#define kTransfromHeight 70

@interface MSPhoneLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldBottomLineConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *phoneIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *topTipsLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomTipsView;
@property (weak, nonatomic) IBOutlet UITextField *inputPhoneField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation MSPhoneLoginViewController
#pragma mark - Life Cycle
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [HomePageAnimationUtil titleLabelAnimationWithLabel:_topTitleLabel withView:self.view];
    [HomePageAnimationUtil titleLabelAnimationWithLabel:_bottomTitleLabel withView:self.view];
    [HomePageAnimationUtil textFieldBottomLineAnimationWithConstraint:_textFieldBottomLineConstraint WithView:self.view];
    [HomePageAnimationUtil phoneIconAnimationWithLabel:_phoneIconImageView withView:self.view];
    [HomePageAnimationUtil tipsLabelMaskAnimation:_topTipsLabel withBeginTime:0];
    [HomePageAnimationUtil tipsLabelMaskAnimation:_bottomTipsView withBeginTime:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _topTitleLabel.transform = CGAffineTransformMakeTranslation(0, -200);
    _bottomTitleLabel.transform = CGAffineTransformMakeTranslation(0, -200);
    _phoneIconImageView.transform = CGAffineTransformMakeTranslation(-200, 0);
    _textFieldBottomLineConstraint.constant = 0;
    _inputPhoneField.delegate = self;
    
    _loginButton.transform = CGAffineTransformMakeScale(0, 44);
    _loginButton.hidden = YES;
    
    [HomePageAnimationUtil registerButtonWidthAnimation:_loginButton withView:self.view andProgress:0];
    
    // 2.监听textView文字改变的通知
    [MSNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:_inputPhoneField];
    // 3.监听键盘的通知
    [MSNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [MSNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)dealloc
{
    [MSNotificationCenter removeObserver:self];
}

#pragma mark - Text Field
/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
//    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.phoneIconImageView.transform = CGAffineTransformMakeTranslation(0, -kTransfromHeight); //(0, --keyboardF.size.height);
        self.inputPhoneField.transform = CGAffineTransformMakeTranslation(0, -kTransfromHeight); //(0, -keyboardF.size.height);
        self.loginButton.transform = CGAffineTransformMakeTranslation(0, -kTransfromHeight); //(0, -keyboardF.size.height);
        self.textFieldBottomLineConstraint.constant = 0;
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.phoneIconImageView.transform = CGAffineTransformIdentity;
        self.inputPhoneField.transform = CGAffineTransformIdentity;
        self.loginButton.transform = CGAffineTransformIdentity;
        self.textFieldBottomLineConstraint.constant = 160.0;
    }];
}

/**
 *  监听文字改变
 */
- (void)textDidChange
{
    if (self.inputPhoneField.text.length <= 11) {
        CGFloat show = self.inputPhoneField.text.length / 11.0;
        [HomePageAnimationUtil registerButtonWidthAnimation:self.loginButton withView:self.view andProgress:show];
    }
}


#pragma mark - Actions
- (IBAction)loginTapped:(UIButton *)sender
{
    if (self.inputPhoneField.text.length == 11) {
        sender.userInteractionEnabled = YES;
        // back
        [self backButtonTapped:nil];
    }
    else {
        sender.userInteractionEnabled = NO;
    }
}

- (IBAction)backButtonTapped:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - override view method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length > 0 && textField.text.length <= 11)
    {
        CGFloat show = textField.text.length / 11;
        [HomePageAnimationUtil registerButtonWidthAnimation:self.loginButton withView:self.view andProgress:show];
    }
}

// hidden status bar
- (BOOL)modalPresentationCapturesStatusBarAppearance
{
    return NO;
}
@end
