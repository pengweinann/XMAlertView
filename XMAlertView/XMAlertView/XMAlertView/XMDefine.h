//
//  XMDefine.h
//  XMAlertView
//
//  Created by pwn on 2019/2/26.
//  Copyright © 2019 pwn. All rights reserved.
//

#ifndef XMDefine_h
#define XMDefine_h

#define ButtonWidth 80
#define ButtonHeight 28

//一般用此宏来创建颜色
#define RGBA_COLOR(r, g, b, a)   ([UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a])
#define RGB_COLOR(r, g, b)       (RGBA_COLOR(r, g, b, 1.0))
#define COLOR_255_255_255   ([UIColor whiteColor])

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SCALE            ([UIScreen mainScreen].scale)

#define defaultContentSize CGSizeMake(SCREEN_WIDTH / 375.0 * 260, SCREEN_HEIGHT / 667.0 * 140)

#define KEY_WINDOW              ([UIApplication sharedApplication].keyWindow)

#define kModuleAngleChanged         @"kModuleAngleChanged"      //横屏竖屏

#define COLOR_0_0_0_20      RGBA_COLOR(0, 0, 0, 0.2)
#define COLOR_35_34_39      RGB_COLOR(35 , 34, 39)
#define COLOR_82_82_82      RGB_COLOR(82 , 82, 82)
#define COLOR_17_16_19      RGB_COLOR(17 , 16, 19)
#define COLOR_182_34_47     RGB_COLOR(182, 34, 47)
#define COLOR_235_235_235   RGB_COLOR(235,235,235)
#define COLOR_180_180_180   RGB_COLOR(180,180,180)


#endif /* XMDefine_h */
