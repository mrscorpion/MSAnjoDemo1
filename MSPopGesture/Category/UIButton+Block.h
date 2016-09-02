//
//  UIButton+Block.h
//  YouCupS
//
//  Created by mr.scorpion on 15/5/5.
//  Copyright (c) 2015年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TouchedBlock)(NSInteger tag);

@interface UIButton (Block)
/**
 *  使用关联来处理block传值
 *
 *  @param touchHandler block
 */
-(void)addActionHandler:(TouchedBlock)touchHandler;

/**
 *  添加不同状态的背景颜色
 */
-(void)setBackColor:(UIColor *)color withState:(UIControlState)state;
@end
