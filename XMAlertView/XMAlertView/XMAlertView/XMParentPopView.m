//
//  XMParentPopView.m
//  ESQuoteModule
//
//  Created by pwn on 2018/7/5.
//  Copyright © 2018年 esunny. All rights reserved.
//
#import "XMParentPopView.h"
#import "XMDefine.h"



@interface XMParentPopView ()<UIGestureRecognizerDelegate>

@end

@implementation XMParentPopView {
    CGFloat _contentHeight;
    CGSize contentSize;
    UITapGestureRecognizer *_tapGesture;
}

- (instancetype)initWithAlertStyle {
    self = [super init];
    if (self) {
        _tapToHide = false;
        [self customViewOfContentSize:defaultContentSize];
        [KEY_WINDOW addSubview:self];
    }
    return self;
}

- (void)customViewOfContentSize:(CGSize)size
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged:) name:kModuleAngleChanged object:nil];
    
    contentSize = size;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = COLOR_0_0_0_20;
    
    [self contentView];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        _contentView.center = self.center;
        _contentView.backgroundColor = COLOR_255_255_255;
        _contentView.clipsToBounds = true;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (void)addContentSubViews {
    
}

//K线模块横竖屏变化
//- (void)valueChanged:(NSNotification *)notification{
//    NSNumber *angleValue = [[NSUserDefaults standardUserDefaults] objectForKey:kModuleAngleValue];
//    if (angleValue.floatValue != 0) {
//        [UIView animateWithDuration:0.000000001 animations:^{
//            self.transform = CGAffineTransformMakeRotation(angleValue.floatValue);
//            self.bounds = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
//            //            self.contentView.hidden = YES;
//        } completion:^(BOOL finished) {
//            if (finished) {
//                self.contentView.center = CGPointMake(SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2);
//                //                self.contentView.hidden = NO;
//            }
//        }];
//    } else {
//        [UIView animateWithDuration:0.000000001 animations:^{
//            self.transform = CGAffineTransformMakeRotation(-angleValue.floatValue);
//            self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//            //            self.contentView.hidden = YES;
//        } completion:^(BOOL finished) {
//            if (finished) {
//                self.contentView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
//                //            self.contentView.hidden = NO;
//            }
//        }];
//    }
//
//}

- (void)hideView {
    [self hideAnimatedCompletion:nil];
}

- (void)angleChanged {
    if (self.allowHiddenLandscapeChanged) {
        [self hideAnimatedCompletion:nil];
    }
}

- (void)hideAnimatedCompletion:(void (^)(void))completion {
    [self removeFromSuperview];
    [self removeGestureRecognizer:_tapGesture];
    if(completion){
        completion();
    }
}

- (void)setTapToHide:(BOOL)tapToHide {
    _tapToHide = tapToHide;
    if (_tapToHide && !_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
        _tapGesture.delegate = self;
        [self addGestureRecognizer:_tapGesture];
    }
}

#pragma mark -- UIGestureRecognizer Delegate methods --
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint P = [touch locationInView:self];
    if (CGRectContainsPoint(self.contentView.frame, P)) {
        return NO;
    }
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kModuleAngleChanged object:nil];
}

@end

@implementation ESPopupViewProperty

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.buttonHeight = 48.0;
        self.cornerRadius = 15.0;
        self.titleFontSize = 14.0;
        self.detailFontSize = 13.0;
        self.itemFontSize = 13.0;
        self.ebackgroundColor = COLOR_255_255_255;
        self.titleColor = COLOR_35_34_39;
        self.detailColor = COLOR_82_82_82;
        self.splitColor = COLOR_35_34_39;
        self.splitWidth = 1/SCREEN_SCALE;
        self.itemNormalColor = COLOR_17_16_19;
        self.itemHighlightColor = COLOR_17_16_19;
        self.itemPressedColor = COLOR_17_16_19;
        self.topBottomMargin = 10;
        self.leftRightMargin = 10;
    }
    return self;
}

@end
