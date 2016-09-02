//
//  MSContentVC.m
//  Anjo
//
//  Created by mr.scorpion on 16/5/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSContentVC.h"
#import "MSMeVC.h"

@interface MSContentVC ()
@end

@implementation MSContentVC
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
    self.title = @"To Jane";

    // BG Image
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"firefly"]];
    bgImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:bgImageView];
    
    // To Next
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toNext)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Actions
- (void)toNext
{
    [self.navigationController pushViewController:[[MSMeVC alloc] initWithNibName:@"MSMeVC" bundle:nil] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
