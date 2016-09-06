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
#define kButtonCount 3

@interface MSSettingVC ()
@property (nonatomic, strong) NSArray *buttonArr;
@property (nonatomic, strong) UILabel *titleLabel;
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
    // title
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:25.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text =  Localized(@"Setting");
    [self.view addSubview:titleLabel];
    
    // color setting
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [titleLabel dk_setTextColorPicker:DKColorPickerWithKey(TEXT)];
    [titleLabel dk_setShadowColorPicker:DKColorPickerWithKey(BAR)];
    
    // buttons
    NSArray *titleArr = @[[NSString stringWithFormat:@"%@ : %@", Localized(@"Tap"), Localized(@"Change Display Language")], Localized(@"Switch Night"), Localized(@"Login")];
    NSMutableArray *buttonArrM = [NSMutableArray array];
    for (int index = 0; index < kButtonCount; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArr[index] forState:UIControlStateNormal];
        button.layer.cornerRadius = 5;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button dk_setTitleColorPicker:DKColorPickerWithKey(TEXT) forState:UIControlStateNormal];
        [button dk_setBackgroundColorPicker:DKColorPickerWithKey(HIGHLIGHTED)];
        [buttonArrM addObject:button];
        [self.view addSubview:button];
        button.tag = index + 10;
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchDown];
    }
    self.buttonArr = [buttonArrM copy];
}
- (void)dealloc
{
    // remove notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LANGUAGE_CHANGED_NOTIFICATION object:nil];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kMargin);
        make.top.equalTo(self.view).offset(kHeight);
        make.right.equalTo(self.view).offset(-kMargin);
        make.height.mas_equalTo(kHeight);
    }];
    
    __block UIButton *lastButton;
    for (int index = 0; index < kButtonCount; index++) {
        UIButton *button = self.buttonArr[index];
        
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.titleLabel);
            if (index == 0) {
                make.top.equalTo(self.titleLabel.mas_bottom).offset(kMargin);
            }
            else {
                make.top.equalTo(lastButton.mas_bottom).offset(kMargin);
            }
        }];
        lastButton = button;
    }
}


#pragma mark - Actions
- (void)buttonTapped:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
            [self languageAction];
            break;
            
        case 11:
            [self setDayNight];
            break;
            
        case 12:
            [self loginAction];
            break;
            
        default:
            break;
    }
}
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
//    [self presentViewController:loginVC animated:YES completion:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
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
