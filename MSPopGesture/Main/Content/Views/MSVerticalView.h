//
//  MSVerticalView.h
//  MSPopGesture
//
//  Created by mr.scorpion on 16/5/5.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface MSVerticalView : UIView
@property (nonatomic) BOOL limitLine;
@property (strong, nonatomic) NSMutableArray* frames;
@property (nonatomic) CGSize textSize;
@property (nonatomic, strong) NSAttributedString *attString;

- (NSString *)getTruncatedStringIfNeeded:(NSAttributedString *)attString;
- (void)buildFrames;
@end
