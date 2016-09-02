//
//  ViewController.m
//  Anjo
//
//  Created by mr.scorpion on 16/5/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//
/*
 望结识更多好友，欢迎加我
 QQ   : 1515679729
 Blog : http://mrscorpion.github.io
 */

#import "ViewController.h"
#import "MSContentVC.h"

@interface ViewController ()
@end

@implementation ViewController
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"Anjo";
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Anjo"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
}

#pragma mark - Actions
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[[MSContentVC alloc] init] animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
