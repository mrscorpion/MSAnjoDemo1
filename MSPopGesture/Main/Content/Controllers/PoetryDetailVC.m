//
//  PoetryDetailVC.m
//  Poetry
//
//  Created by Liujinlong on 11/12/15.
//  Copyright © 2015 Jaylon. All rights reserved.
//

#import "PoetryDetailVC.h"
#import <ZCAnimatedLabel/ZCFocusLabel.h>

@interface PoetryDetailVC ()
@property (nonatomic, strong) ZCFocusLabel *poetryLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *poetry;
@end

@implementation PoetryDetailVC
- (instancetype)initWithPoem:(NSString *)poem
{
    if (self = [super init]) {
        _poetry = poem;
    }
    return self;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.poetryLabel];
    
    // Back
    UITapGestureRecognizer *singleTapDouble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    singleTapDouble.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:singleTapDouble];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startPoetryLabelAnimation];
}

#pragma mark - Getter and Setter
- (ZCFocusLabel *)poetryLabel
{
    if (!_poetryLabel)
    {
        self.poetryLabel =  [[ZCFocusLabel alloc] initWithFrame:CGRectMake(20, 20, MAIN_SCREEN_W - 40, CGRectGetHeight(self.scrollView.frame) - 20)];
    }
    return _poetryLabel;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    }
    return _scrollView;
}

#pragma mark - private method
// start Animation
- (void)startPoetryLabelAnimation
{
    self.poetryLabel.attributedString = [self poetryString];
    self.poetryLabel.animationDelay = 0.07;
    self.poetryLabel.animationDuration = 0.5;
    self.poetryLabel.layoutTool.groupType = ZCLayoutGroupChar;
    
    // 调整frame
    CGRect stringRect = [self stringRectWithString:[self poetryString]];
    CGRect frame = self.poetryLabel.frame;
    frame.origin.x = (MAIN_SCREEN_W - CGRectGetWidth(stringRect)) / 2;
    frame.size.width = CGRectGetWidth(stringRect);
    self.poetryLabel.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(stringRect) + 60);
    [self.poetryLabel startAppearAnimation];
}

- (CGRect)stringRectWithString:(NSAttributedString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAIN_SCREEN_W - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:NULL];
    return rect;
}

- (NSAttributedString *)poetryString
{
    NSString *poetry = [NSString stringWithFormat:@"%@", self.poetry];
    poetry = [poetry stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 5;
    style.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:poetry attributes:@{NSParagraphStyleAttributeName:style, NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    return [str copy];
}


- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
