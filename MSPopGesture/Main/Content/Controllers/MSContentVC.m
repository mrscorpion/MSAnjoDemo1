//
//  MSContentVC.m
//  Anjo
//
//  Created by mr.scorpion on 16/5/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSContentVC.h"
#import "MSVerticalVC.h"
#import "MSMeVC.h"

@interface MSContentVC ()
@end

@implementation MSContentVC
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    // BG Image
    self.view.layer.contents = (__bridge id _Nullable)[UIImage imageNamed:@"firefly"].CGImage;
    
    // Gesture
    // To Next
    UITapGestureRecognizer *singleTapDouble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toNext)];
    singleTapDouble.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:singleTapDouble];
    
    // To Vertical
    UITapGestureRecognizer *doubleSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toVertical)];
    doubleSingleTap.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleSingleTap];
}

#pragma mark - Actions
- (void)toNext
{
    [self.navigationController pushViewController:[[MSMeVC alloc] initWithNibName:@"MSMeVC" bundle:nil] animated:YES];
}
- (void)toVertical
{
    [self presentViewController:[[MSVerticalVC alloc] init] animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
