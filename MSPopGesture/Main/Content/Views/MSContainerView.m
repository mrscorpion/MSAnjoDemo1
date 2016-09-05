//
//  MSContainerView.m
//  MSPopGesture
//
//  Created by mr.scorpion on 16/5/5.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSContainerView.h"

@implementation MSContainerView
- (void)setCTFrame:(id)f
{
    ctFrame = f;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CTFrameDraw((CTFrameRef)ctFrame, context);
}
@end
