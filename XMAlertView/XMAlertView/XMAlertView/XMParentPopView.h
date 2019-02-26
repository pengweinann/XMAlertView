//
//  XMParentPopView.h
//  ESQuoteModule
//
//  Created by pwn on 2018/7/5.
//  Copyright © 2018年 esunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMParentPopView : UIView

/**
 点击空白区域，弹框是否消失，默认为false
 */
@property (nonatomic, assign) BOOL tapToHide;

/**
 屏幕旋转是否隐藏弹框
 默认是NO，不隐藏，YES是隐藏
 */
@property (nonatomic, assign) BOOL allowHiddenLandscapeChanged;

//显示，隐藏
- (void)hideAnimatedCompletion:(void (^)(void))completion;

-(instancetype)initWithAlertStyle; //针对提示弹框的 method
- (instancetype)initWithContentSize:(CGSize)size;
@property (nonatomic, strong) UIView *contentView;

- (void)addContentSubViews;

@end

@interface ESPopupViewProperty: NSObject

//点击按钮的高度
@property (nonatomic, assign) CGFloat buttonHeight;
//圆角半径
@property (nonatomic, assign) CGFloat cornerRadius;

//标题字体大小
@property (nonatomic, assign) CGFloat titleFontSize;
//内容字体大小
@property (nonatomic, assign) CGFloat detailFontSize;
//点击按钮字体大小
@property (nonatomic, assign) CGFloat itemFontSize;

//弹窗背景色
@property (nonatomic, strong) UIColor* ebackgroundColor;
//标题文本颜色
@property (nonatomic, strong) UIColor* titleColor;
//内容文本颜色
@property (nonatomic, strong) UIColor* detailColor;
//边框、分割线颜色
@property (nonatomic, strong) UIColor* splitColor;
//边框宽度
@property (nonatomic, assign) CGFloat splitWidth;

//普通按钮颜色
@property (nonatomic, strong) UIColor* itemNormalColor;
//高亮按钮颜色
@property (nonatomic, strong) UIColor* itemHighlightColor;
//选中按钮颜色
@property (nonatomic, strong) UIColor* itemPressedColor;

//上下间距
@property (nonatomic, assign) CGFloat topBottomMargin;
//左右间距
@property (nonatomic, assign) CGFloat leftRightMargin;


@end
