//
//  UIButton+block.h
//  ESBaseUIModule
//
//  Created by pwn on 2018/7/6.
//  Copyright © 2018年 esunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (block)

@property(nonatomic ,copy)void(^block)(void);

-(void)addTapBlock:(void(^)(void))block;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
