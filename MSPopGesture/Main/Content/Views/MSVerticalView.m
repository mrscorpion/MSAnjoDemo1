//
//  MSVerticalView.m
//  MSPopGesture
//
//  Created by mr.scorpion on 16/5/5.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSVerticalView.h"
#import "MSContainerView.h"

@implementation MSVerticalView
#pragma mark - Initialize
- (void)buildFrames
{
    CGFloat columnWidth = 40;
    self.frames = [NSMutableArray array];
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect textFrame = CGRectMake(0, 0, 20, self.bounds.size.height);
    CGPathAddRect(path, NULL, textFrame);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
    int textPos = 0;
    int columnIndex = 0;
    while (textPos < [_attString length]){
        CGPoint colOffset = CGPointMake(columnIndex * columnWidth, 0);
        CGRect colRect = CGRectMake(0, 0 , columnWidth, self.bounds.size.height);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, colRect);
        // use the column path
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
        CFRange frameRange = CTFrameGetVisibleStringRange(frame);
        // create an empty column view
        MSContainerView *content = [[MSContainerView alloc] initWithFrame: CGRectMake(0, 0, columnWidth, self.bounds.size.height)];
        content.backgroundColor = [UIColor clearColor];
        content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
        // set the column view contents and add it as subview
        [content setCTFrame:(__bridge id)frame];
        [self.frames addObject: (__bridge id)frame];
        [self addSubview: content];
        // prepare for next frame
        textPos += frameRange.length;
        //CFRelease(frame);
        CFRelease(path);
        columnIndex++;
    }
    self.bounds = CGRectMake(0, 0, columnIndex * columnWidth, self.bounds.size.height);
}

#pragma mark - Setter and Getter
- (NSString *)getTruncatedStringIfNeeded:(NSAttributedString *)attString
{
    NSDictionary *attrDic = [NSDictionary dictionaryWithObjectsAndKeys:@(kCTFrameProgressionRightToLeft |kCTFrameProgressionTopToBottom),(NSString *)kCTFrameProgressionAttributeName, nil];
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0,  self.bounds.size.width, self.bounds.size.height));
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), path, (CFDictionaryRef)attrDic);
    CFRange frameRange = CTFrameGetVisibleStringRange(frame);
    CGFloat length = frameRange.length;
    if (attString.length > length)
    {
        NSString *substr = [attString.string substringToIndex:length - 1];
        NSString *result = [NSString stringWithFormat:@"%@\n……", substr];
        return result;
    }
    return attString.string;
}

- (void)setAttString:(NSAttributedString *)attString
{
    _attString = attString;
    NSDictionary *attrDic = [NSDictionary dictionaryWithObjectsAndKeys:@(kCTFrameProgressionRightToLeft | kCTFrameProgressionTopToBottom),(NSString *)kCTFrameProgressionAttributeName, nil];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
    CGSize viewSize = self.bounds.size;
    CFRange fitRange;
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [_attString length]), (CFDictionaryRef)attrDic, CGSizeMake(CGFLOAT_MAX, viewSize.height), &fitRange);
    self.textSize = size;
    self.bounds = CGRectMake(0, 0, size.width, viewSize.height);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    NSDictionary *attrDic = [NSDictionary dictionaryWithObjectsAndKeys:@(kCTFrameProgressionRightToLeft |kCTFrameProgressionTopToBottom),(NSString *)kCTFrameProgressionAttributeName, nil];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0,  self.bounds.size.width, self.bounds.size.height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, [_attString length]), path, (CFDictionaryRef)attrDic);
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}
@end
