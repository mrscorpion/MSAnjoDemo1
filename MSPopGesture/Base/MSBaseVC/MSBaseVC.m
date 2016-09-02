//
//  MSBaseVC.m
//  MSPopGesture
//
//  Created by mr.scorpion on 16/9/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSBaseVC.h"

@interface MSBaseVC ()

@end

@implementation MSBaseVC
#pragma mark - View Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
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
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:22.0f], NSFontAttributeName, nil]];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
