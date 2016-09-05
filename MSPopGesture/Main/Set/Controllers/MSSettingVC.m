//
//  MSSettingVC.m
//  MSPopGesture
//
//  Created by mr.scorpion on 16/9/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSSettingVC.h"
#import "AppDelegate.h"
#import <DKNightVersion/DKNightVersion.h>
#import <Masonry.h>
#import "UIButton+Block.h"
#import "MSPhoneLoginViewController.h"

#define kMargin 20
#define kHeight 36

@interface MSSettingVC ()
@end

@implementation MSSettingVC
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // configure
    [self configurationUI];
    
    // add notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged) name:LANGUAGE_CHANGED_NOTIFICATION object:nil];
}
- (void)configurationUI
{
    WeakSelf;
    
    // title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:25.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text =  Localized(@"Setting");
    [self.view addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kMargin);
        make.top.height.mas_equalTo(kHeight);
        make.right.equalTo(self.view).offset(-kMargin);
        make.height.mas_equalTo(kHeight);
    }];
    
    // language
    UIButton *languageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:languageBtn];
    [languageBtn setTitle:[NSString stringWithFormat:@"%@ : %@", Localized(@"Tap"), Localized(@"Change Display Language")] forState:UIControlStateNormal];
    languageBtn.layer.cornerRadius = 5;
    languageBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [languageBtn addActionHandler:^(NSInteger tag) {
        [weakSelf languageAction];
    }];
    [languageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(kHeight);
    }];
    
    // day night
    UIButton *nightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:nightBtn];
    [nightBtn setTitle:Localized(@"Switch Night") forState:UIControlStateNormal];
    nightBtn.layer.cornerRadius = 5;
    nightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [nightBtn addActionHandler:^(NSInteger tag) {
        [weakSelf setDayNight];
    }];
    [nightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(languageBtn);
        make.top.equalTo(languageBtn.mas_bottom).offset(kMargin);
    }];
    
    // login
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:Localized(@"Login") forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn addActionHandler:^(NSInteger tag) {
        [weakSelf loginAction];
    }];
    [loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(nightBtn);
        make.top.equalTo(nightBtn.mas_bottom).offset(kMargin);
    }];
    
    // color setting
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [titleLabel dk_setTextColorPicker:DKColorPickerWithKey(TEXT)];
    [titleLabel dk_setShadowColorPicker:DKColorPickerWithKey(BAR)];
    [languageBtn dk_setTitleColorPicker:DKColorPickerWithKey(TEXT) forState:UIControlStateNormal];
    [languageBtn dk_setBackgroundColorPicker:DKColorPickerWithKey(HIGHLIGHTED)];
    [nightBtn dk_setTitleColorPicker:DKColorPickerWithKey(TEXT) forState:UIControlStateNormal];
    [nightBtn dk_setBackgroundColorPicker:DKColorPickerWithKey(HIGHLIGHTED)];
    [loginBtn dk_setTitleColorPicker:DKColorPickerWithKey(TEXT) forState:UIControlStateNormal];
    [loginBtn dk_setBackgroundColorPicker:DKColorPickerWithKey(HIGHLIGHTED)];
}
- (void)dealloc
{
    // remove notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LANGUAGE_CHANGED_NOTIFICATION object:nil];
}



#pragma mark - Actions
// NIGHT SETTING
- (void)setDayNight
{
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight])
    {
        [self.dk_manager dawnComing];
    }
    else {
        [self.dk_manager nightFalling];
    }
}

// LOGIN ANIMATION
- (void)loginAction
{
    MSPhoneLoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"MSPhoneLoginViewController"];
    [self presentViewController:loginVC animated:YES completion:nil];
}

// LANGUAGE
- (void)languageAction
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:Localized(@"Change Display Language") message:[NSString stringWithFormat:@"%@: %@", Localized(@"App language"), Localized(@"System Language")] delegate:self cancelButtonTitle:Localized(@"Cancel") otherButtonTitles:Localized(@"Confirm"), nil];
    [view show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        // 修改本地获取的语言文件-交替
        NSString *language = [[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"];
        if ([language isEqualToString: @"en"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }
        else {
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
            
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        // Post notification
        [[NSNotificationCenter defaultCenter] postNotificationName:LANGUAGE_CHANGED_NOTIFICATION object:nil];
    }
}

#pragma mark - Notification
/*
 *  Reload All
 */
- (void)languageChanged
{
    [APP_DELEGATE intoApp];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
