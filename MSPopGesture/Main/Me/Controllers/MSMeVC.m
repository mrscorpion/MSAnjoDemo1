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
#import <Masonry.h>
#import <DKNightVersion/DKNightVersion.h>

@interface MSMeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *dragView;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (strong, nonatomic) UIVisualEffectView *effectview;

@property (strong, nonatomic) UIView *BuddleView;
@property (nonatomic, retain) NSMutableArray *bubbleButtonArray;
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
    
    
    // 动态按钮Buddleview
    self.BuddleView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.signatureLabel.frame) + 10, MAIN_SCREEN_W - 40, 70)];
    self.BuddleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.BuddleView];
    [self addButtons];
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


/**
 *  Buddle Buttons
 */
- (void)addButtons
{
    NSArray *strings = @[@" iOS开发 ",  @" 诗歌 ", @" 篮球 ", @" 音乐 ", @" 泡妞，\(^o^)/~ ", @" ... "];
    
    // Create colors for buttons
//    UIColor *textColor = DKColorPickerWithKey(TEXT); //[UIColor whiteColor];
//    UIColor *bgColor = DKColorPickerWithKey(BG); //[UIColor blackColor];
    CGFloat fsize = 16.0;
    CGFloat cornerRadius = (3 * fsize / 4);
    CGFloat padding = 20;
    
    self.bubbleButtonArray = [@[] mutableCopy];
    
    // First check to see if there are already buttons there. If there aren't any
    // subviews to bubbleView, then add these buttons.
    if (self.BuddleView.subviews.count == 0)
    {
        // Create padding between sides of view and each button
        //  -- I recommend 10 for aesthetically pleasing results at a 14 fontSize
        int pad = padding;
        
        // Iterate over every string in the array to create the Bubble Button
        for (int xx = 0; xx < strings.count; xx++)
        {
            // Find the size of the button, turn it into a rect
            NSString *bub = [strings objectAtIndex:xx];
            // CGSize bSize = [bub sizeWithFont:[UIFont systemFontOfSize:fsize] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fsize]};
            NSStringDrawingOptions option = (NSStringDrawingOptions)(NSLineBreakByWordWrapping);
            CGSize bSize = [bub boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:option attributes:attribute context:nil].size;
            CGRect buttonRect = CGRectMake(pad, pad, bSize.width + fsize, bSize.height + fsize/2);
            
            // if new button will fit on screen, in row:
            //   - place it
            // else:
            //   - put on next row at beginning
            if (xx > 0)
            {
                UIButton *oldButton = [[self.BuddleView subviews] objectAtIndex:self.BuddleView.subviews.count - 1];
                if ((oldButton.frame.origin.x + (2*pad) + oldButton.frame.size.width + bSize.width + fsize) > self.BuddleView.frame.size.width) {
                    buttonRect = CGRectMake(pad, oldButton.frame.origin.y + oldButton.frame.size.height + pad, bSize.width + fsize, bSize.height + fsize/2);
                }
                else {
                    buttonRect = CGRectMake(oldButton.frame.origin.x + pad + oldButton.frame.size.width, oldButton.frame.origin.y, bSize.width + fsize, bSize.height + fsize/2);
                }
            }
            
            // Create button and make magic with the UI
            // -- Set the alpha to 0, cause we're gonna' animate them at the end
            UIButton *bButton = [[UIButton alloc] initWithFrame:buttonRect];
            [bButton setShowsTouchWhenHighlighted:NO];
            [bButton setTitle:bub forState:UIControlStateNormal];
            [bButton.titleLabel setFont:[UIFont systemFontOfSize:fsize]];
            // Set Night Mode
            // bButton.titleLabel.textColor =  textColor;
            // bButton.backgroundColor = bgColor;
            [bButton dk_setTitleColorPicker:DKColorPickerWithKey(TEXT) forState:UIControlStateNormal];
            [bButton dk_setBackgroundColorPicker:DKColorPickerWithKey(HIGHLIGHTED)];
            
            bButton.layer.cornerRadius = cornerRadius;
            bButton.alpha = 0;
            
            // Give it some data and a target
            bButton.tag = xx;
            [bButton addTarget:self action:@selector(clickedBubbleButton:) forControlEvents:UIControlEventTouchUpInside];
            
            // And finally add a shadow
            bButton.layer.shadowColor = [[UIColor blackColor] CGColor];
            bButton.layer.shadowOffset = CGSizeMake(0.0f, 2.5f);
            bButton.layer.shadowRadius = 5.0f;
            bButton.layer.shadowOpacity = 0.35f;
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bButton.bounds cornerRadius:(3*fsize/4)];
            bButton.layer.shadowPath = [path CGPath];
            
            // Add to the view, and to the array
            [self.BuddleView addSubview:bButton];
            [self.bubbleButtonArray addObject:bButton];
        }
        
        // Sequentially animate the buttons appearing in view
        // -- This is the interval between each button animating, not overall span
        // -- I recommend 0.034 for an nice, smooth transition
        [self addBubbleButtonsWithInterval:0.034];
    }
    // Now make them sucka's.
    //[self.BuddleView fillBubbleViewWithButtons:bubbleStringArray bgColor:bgColor textColor:textColor fontSize:10];
}
- (void)addBubbleButtonsWithInterval:(float)ftime
{
    // Make sure there are buttons to animate
    // Take the first button in the array, animate alpha to 1
    // Remove button from array
    // Recur. Lather, rinse, repeat until all are buttons are on screen
    if (self.bubbleButtonArray.count > 0)
    {
        UIButton *button = [self.bubbleButtonArray objectAtIndex:0];
        [UIView animateWithDuration:ftime animations:^{
            button.alpha = 1;
        } completion:^(BOOL fin){
            [self.bubbleButtonArray removeObjectAtIndex:0];
            [self addBubbleButtonsWithInterval:ftime];
        }];
    }
}
- (void)clickedBubbleButton:(UIButton *)button
{
    NSLog(@"click:%ld", button.tag);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
