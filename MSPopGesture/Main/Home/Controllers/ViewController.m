//
//  ViewController.m
//  Anjo
//
//  Created by mr.scorpion on 16/5/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//
/*
 希望能结识更多好友，欢迎加我
 QQ   : 1515679729
 Blog : http://mrscorpion.github.io
 */

#import "ViewController.h"
#import "MSContentVC.h"
#import "Masonry.h"

@interface ViewController ()
@end

@implementation ViewController
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Anjo"]];
    [self.view addSubview:bgImageView];
    [bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
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
