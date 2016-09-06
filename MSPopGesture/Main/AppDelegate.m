//
//  AppDelegate.m
//  Anjo
//
//  Created by mr.scorpion on 16/5/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "AppDelegate.h"
#import "MSLauchVC.h"
#import "MSNavVC.h"
#import "ViewController.h"
#import "MSContentVC.h"
#import "MSMeVC.h"
#import "MSSettingVC.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MSLauchVC *launchVC = [[MSLauchVC alloc] init];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"])
    {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        if ([language hasPrefix:@"zh-Hans"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }
        else {
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
        }
    }
    return YES;
}


- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}
- (void)intoApp
{
    // After setting language
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = [[MSNavVC alloc] initWithRootViewController:vc];
    [vc.navigationController pushViewController:[[MSContentVC alloc] init] animated:NO];
    [vc.navigationController pushViewController:[[MSMeVC alloc] initWithNibName:@"MSMeVC" bundle:nil] animated:NO];
    [vc.navigationController pushViewController:[[MSSettingVC alloc] init] animated:NO];
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application{}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}
@end
