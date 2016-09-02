//
//  UIButton+Block.m
//  YouCupS
//
//  Created by mr.scorpion on 15/5/5.
//  Copyright (c) 2015年 mr.scorpion. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>
static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (Block)
/**
 *  使用关联来处理block传值
 *
 *  @param touchHandler block
 */
- (void)addActionHandler:(TouchedBlock)touchHandler
{
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionTouched:(UIButton *)btn
{
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}

/**
 *  添加不同状态的背景颜色
 */
- (void)setBackColor:(UIColor *)color withState:(UIControlState)state
{
    [self setBackgroundImage:[self creatImageWithColor:color] forState:state];
}

- (UIImage *)creatImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

