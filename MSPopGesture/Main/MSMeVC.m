//
//  MSMeVC.m
//  Anjo
//
//  Created by mr.scorpion on 16/9/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//
/*
 希望结识更多的朋友，如不嫌弃，欢迎加我
 QQ   : 1515679729
 Blog : http://mrscorpion.github.io
 */

#import "MSMeVC.h"
#import "UIView+Draggable.h"
#import "MSSettingVC.h"
//#import "AppDelegate.h"

@interface MSMeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *dragView;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@end

@implementation MSMeVC
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
    
    self.signatureLabel.text = Localized(@"Signature");
    
    // UIImageView ignored user events by default, so set
    // `userInteractionEnabled` to YES for receive touch events.
    self.dragView.userInteractionEnabled = YES;
    
    // Make avatarView draggable
    [self.dragView makeDraggable];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toNext)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Update snap point when layout occured
    [self.dragView updateSnapPoint];
}

#pragma mark - Actions
- (void)toNext
{
    [self.navigationController pushViewController:[[MSSettingVC alloc] init] animated:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
