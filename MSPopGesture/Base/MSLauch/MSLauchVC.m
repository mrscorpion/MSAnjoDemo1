//
//  MSLauchVC.m
//  PianKe
//
//  Created by mr.scorpion on 16/2/25.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSLauchVC.h"
#import "MSNavVC.h"
#import "ViewController.h"


#define LAUNCHING_IMAGEVIEW_NAME @"launchingName"

@interface MSLauchVC ()
@property (nonatomic,strong) UIImageView *launchingBgImageView; // lauch imageView
@property (nonatomic,strong) NSTimer *launchingTimer;
@end

@implementation MSLauchVC
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // load lauch image
    [self.view addSubview:self.launchingBgImageView];
    [self loadLaunchingImageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // add animation
    [UIView animateWithDuration:3.0 animations:^{
        CGRect rect = self.launchingBgImageView.frame;
        rect.origin = CGPointMake(-100, -100);
        rect.size = CGSizeMake(rect.size.width + 200, rect.size.height + 200);
        _launchingBgImageView.frame = rect;
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[MSNavVC alloc] initWithRootViewController:[[ViewController alloc] init]];
    }];
}

#pragma mark - Actions
/**
 *  load default image
 */
- (void)loadLaunchingImageView
{
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:LAUNCHING_IMAGEVIEW_NAME];
    if (imageData) { 
        self.launchingBgImageView.image = [UIImage imageWithData:imageData];
    }
}

#pragma mark - Lazy Load
/**
 *  lauch image
 */
- (UIImageView *)launchingBgImageView
{
    if (!_launchingBgImageView) {
        _launchingBgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [_launchingBgImageView setImage:[UIImage imageNamed:@"lauch"]];
    }
    return _launchingBgImageView;
}
@end
