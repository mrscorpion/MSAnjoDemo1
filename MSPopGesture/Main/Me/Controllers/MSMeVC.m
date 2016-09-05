//
//  MSMeVC.m
//  Anjo
//
//  Created by mr.scorpion on 16/9/2.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSMeVC.h"
#import "UIView+Draggable.h"
#import "MSSettingVC.h"
#import <DKNightVersion.h>
#import <Masonry.h>

@interface MSMeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *dragView;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (strong, nonatomic) UIVisualEffectView *effectview;
@end

@implementation MSMeVC
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.signatureLabel.text = Localized(@"Signature");
    self.signatureLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    
    // Effect view
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    self.effectview.frame = self.blurImageView.bounds;
    self.effectview.alpha = 0.6;
    [self.blurImageView addSubview:self.effectview];
    [self.effectview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.blurImageView);
    }];
    
    
    // Draggable view
    self.dragView.userInteractionEnabled = YES;
    [self.dragView makeDraggable];
    
    // Gesture
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
