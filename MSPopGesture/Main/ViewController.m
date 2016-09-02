//
//  ViewController.m
//  Anjo
//
//  Created by mr.scorpion on 16/5/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "ViewController.h"
#import "MSContentVC.h"

@interface ViewController ()
@end

@implementation ViewController
#pragma mark - View Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Anjo";
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Anjo"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toNext)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Actions
- (void)toNext
{
    [self.navigationController pushViewController:[[MSContentVC alloc] init] animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
