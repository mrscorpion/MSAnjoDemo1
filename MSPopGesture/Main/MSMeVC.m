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

@interface MSMeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *dragView;
@end

@implementation MSMeVC
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIImageView ignored user events by default, so set
    // `userInteractionEnabled` to YES for receive touch events.
    self.dragView.userInteractionEnabled = YES;
    
    // Make avatarView draggable
    [self.dragView makeDraggable];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Update snap point when layout occured
    [self.dragView updateSnapPoint];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
