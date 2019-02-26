//
//  XMAlertView.h
//  ESQuoteModule
//
//  Created by pwn on 2018/7/5.
//  Copyright © 2018年 esunny. All rights reserved.
//

#import "XMParentPopView.h"

//弹框布局
typedef NS_ENUM(NSUInteger, XMAlertStyle) {
    XMAlertStyleAlert,      //中心位置
    XMAlertStyleActionSheet,        //底部bottom
};

//弹框动画方式
typedef NS_ENUM(NSUInteger, XMAlertAnimationType) {
    XMAlertAnimationDefault,          //无动画
    XMAlertAnimationBottomToCenter,  //从手机底部弹出
    XMAlertAnimationAlpha,     //透明度从0~1动画
    XMAlertAnimationPointSpread,     //从中心点向外扩展
};

#define ActionDefaultHeaderHeight  35
#define ActionDefaultContentHeight  56
#define ActionDefaultBottomHeight 48
#define ActionDefaultleft 10.0
#define AnimateDuration 0.3

typedef void(^handlerBlock)(void);

@interface XMAlertAction : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy) handlerBlock handler;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *highTitleColor;
@property (nonatomic, strong) UIColor *highBGColor;

+ (instancetype)actionWithTitle:(NSString *)title handler:(nullable void (^)(void))handler;

@end

@protocol XMAlertViewDelegate <NSObject>

@optional

#pragma 注意:上中下三个视图自定义可以修改高度,但不能修改宽度,宽度值默认ActionDefaultWidth,若想修改,在ActionDefaultWidth实现处修改,即在computedDefaultWidth方法中修改
#pragma 支持继承和delegate两种方法的自定义
/**
 自定义顶部视图内容
 */
- (void)customHeaderSubview:(UIView *)headView;
/**
 自定义中部视图内容
 */
- (void)customDetailSubview:(UIView *)detailView;
/**
 自定义底部视图内容
 */
- (void)customBottomSubview:(UIView *)bottomView;
/**
 顶部header高度
 */
- (CGFloat)heightForHeaderView;
/**
 中部detail高度
 */
- (CGFloat)heightForDetailView;
/**
 底部bottom高度
 */
- (CGFloat)heightForBottomView;

@end


@interface XMAlertView : XMParentPopView {
    
@public
    /**
     ActionDefaultWidth会根据XMAlertStyle自动选择一种宽度,详见computedDefaultWidth方法
     */
    CGFloat ActionDefaultWidth;
}
//默认不加
@property (nonatomic, assign) BOOL weatherAddLine;

/**
 isNarrow:(true:正常弹框宽度,false:底部弹框宽度)
 delegate:如不需实现代理方法，此参数填nil
 */
+(instancetype)alertWithTitle:(nullable NSString *)title detailContent:(nullable NSString *)content alertType:(XMAlertStyle)alertType animationType:(XMAlertAnimationType)animationType isNarrowView: (BOOL)isNarrow withDelegate:(nullable id<XMAlertViewDelegate>)delegate;

/**
 需要实现delegate方法时，使用此方法
 */

- (instancetype)initWithTitle:(NSString *)title detailContent:(NSString *)content alertType:(XMAlertStyle)alertType animationType:(XMAlertAnimationType)animationType isNarrowView:(BOOL)isNarrow withDelegate:(nullable id<XMAlertViewDelegate>)delegate;


///**
// 1、需要传参且不需要实现delegate； 2、必须手动调用addContentSubViews方法
//
// @param title 标题名称
// @param content detailViwe 自带Label。不需要填nil
// @param alertType 弹框位置
// @param animationType 弹框动画效果
// @param isNarrow false加宽
// @return view
// */
//- (instancetype)initWithTitle:(NSString *)title detailContent:(NSString *)content alertType:(XMAlertStyle)alertType animationType:(XMAlertAnimationType)animationType isNarrowView:(BOOL)isNarrow;

/**
 添加底部按钮
 */
- (void)addAction:(nullable NSArray <XMAlertAction *> *)items;

- (UIView *)customWithHeaderView;
- (UIView *)customWithDetailView;
- (UIView *)customWithBottomView;

/**
 
 自定义的detail的frame需要更新时，调用此方法
 目前只针对银期转账调用此方法
 
 */

- (void)refreshDeatailViewHeight:(CGFloat)height;

- (void)showAnimated;

@end


