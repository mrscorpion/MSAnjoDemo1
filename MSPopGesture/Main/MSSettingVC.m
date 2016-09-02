//
//  MSSettingVC.m
//  MSPopGesture
//
//  Created by mr.scorpion on 16/9/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSSettingVC.h"
#import "AppDelegate.h"
#import "MSContentVC.h"

#define LanguageChanged   @"LANGUAGE_CHANGE_NOTIFICATION"

@interface MSSettingVC ()
@end

@implementation MSSettingVC
#pragma mark - View Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    // add notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged) name:LanguageChanged object:nil];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = Localized(@"Setting");
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:22.0f], NSFontAttributeName, nil]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 120, self.view.frame.size.width - 20, 30);
    btn.backgroundColor = [UIColor blackColor];
    btn.layer.cornerRadius = 5;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:[NSString stringWithFormat:@"%@ : %@", Localized(@"Tap"), Localized(@"Change Display Language")] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(languageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)dealloc
{
    // remove notification
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LanguageChanged object:nil];
}



#pragma mark - Actions
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
        [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChanged object:nil];
    }
}

#pragma mark - 接收到语言改变的通知后，调用该方法。
/*
 *  因为是要刷新所有试图，所以之前的所有试图都要重新初始化，需要重新设置window.rootViewController
 *  为了不再重复代码，就直接调用AppDelegate的toMain方法，来设rootViewController。
 */
- (void)languageChanged
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate toMain];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
