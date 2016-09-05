//
//  MSVerticalVC.m
//  MSPopGesture
//
//  Created by mr.scorpion on 16/9/5.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSVerticalVC.h"
#import "MSVerticalView.h"
#import <DKNightVersion/DKNightVersion.h>

@interface MSVerticalVC ()
@property (nonatomic, strong) MSVerticalView *verticalView;
@end

@implementation MSVerticalVC
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // color setting
    self.view.backgroundColor = [UIColor blackColor];
    
    // Vertical View
    MSVerticalView *verticalView = [[MSVerticalView alloc] initWithFrame:self.view.bounds];
    self.verticalView = verticalView;
    verticalView.backgroundColor = [UIColor clearColor];
    verticalView.limitLine = YES;
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"  《临江仙·忘川殇》\n       陌上清歌舒缱绻，花开静默成行。\n       徒留背影向昏黄，三生石已裂，浅刻是荒凉。\n \n       苦等千年终未遇，回眸世事沧桑。\n       前尘滚滚忘川殇，奈何桥下水，一碗孟婆汤。\n                                                                                       || 文/泊"];
    [verticalView setAttString:[self buildAttrString:string.string withFont:@"FZHPFW—GB1-0" fontSize:17 lineSpace:0.5 fontColor:[UIColor whiteColor] delLine:NO]]; // @"FZY4FW—GB1-0"
    [self.view addSubview:verticalView];
    
    // Gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toNext)];
    [self.view addGestureRecognizer:tap];
}

- (NSMutableAttributedString *)buildAttrString:(NSString *)content withFont:(NSString *)fontName fontSize:(CGFloat)fontSize lineSpace:(CGFloat)lineSpace fontColor:(UIColor *)textColor delLine:(BOOL)delLine
{
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)fontName, fontSize, NULL); // CTFontCreateWithName((CFStringRef)@"FZBWKSFW--GB1-0", 22.0f, NULL);
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content attributes:@{
                                              //文字的方向
                                              (NSString *)kCTVerticalFormsAttributeName : @(YES),
                                              (NSString *)kCTFontAttributeName : (__bridge id)fontRef,
                                              (NSString *)kCTForegroundColorAttributeName :(id)textColor.CGColor
                                              }];
    
    // line break
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByWordWrapping; // 换行模式
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    // 行间距
    CTParagraphStyleSetting LineSpacing;
    CGFloat spacing = lineSpace;  // 指定间距
    LineSpacing.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    LineSpacing.value = &spacing;
    LineSpacing.valueSize = sizeof(CGFloat);
    
    CTParagraphStyleSetting settings[] = {lineBreakMode,LineSpacing};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 2);   // 第二个参数为settings的长度
    [attString addAttribute:(NSString *)kCTParagraphStyleAttributeName value:(__bridge id)paragraphStyle range:NSMakeRange(0, attString.length)];
    if (delLine)
    {
        NSNumber *underline = [NSNumber numberWithInt:kCTTextAlignmentCenter];
        [attString addAttribute:(id)kCTUnderlineStyleAttributeName value:underline range:NSMakeRange(0, attString.length) ];
    }
    return attString;
}

#pragma mark - Actions
- (void)toNext
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
