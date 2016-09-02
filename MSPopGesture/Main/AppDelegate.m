//
//  AppDelegate.m
//  Anjo
//
//  Created by mr.scorpion on 16/5/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//
/*
 希望结识更多的朋友，欢迎加我
 QQ   : 1515679729
 Blog : http://mrscorpion.github.io
 */

#import "AppDelegate.h"
#import "MSLauchVC.h"
#import "MSNavVC.h"
#import "ViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //到主页
//    [self toMain];
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MSLauchVC *launchVC = [[MSLauchVC alloc] init];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        // 开头匹配
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

- (void)toMain
{
    self.window.rootViewController = [[MSNavVC alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application{}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}
@end
