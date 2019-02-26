//
//  XMAlertView.m
//  ESQuoteModule
//
//  Created by pwn on 2018/7/5.
//  Copyright © 2018年 esunny. All rights reserved.
//

#import "XMAlertView.h"
#import "XMDefine.h"
#import "UIButton+block.h"


@implementation XMAlertAction

+(instancetype)actionWithTitle:(NSString *)title handler:(void (^)(void))handler {
    XMAlertAction *action = [[XMAlertAction alloc]init];
    action.title = title;
    if (handler) {
        action.handler = handler;
    }
    return action;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
}

@end

@interface XMAlertView ()<XMAlertViewDelegate>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detailContent;
@property (nonatomic, assign) XMAlertStyle alertStyle;
@property (nonatomic, assign) XMAlertAnimationType animationType;
@property (nonatomic, strong) NSArray <XMAlertAction *>*btnArr;
@property (nonatomic, assign) BOOL isNarrow;
@property (nonatomic, weak) id <XMAlertViewDelegate> delegate;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, strong) UIView *bottomView;


@end

@implementation XMAlertView {
    ESPopupViewProperty *property;
    CGFloat heightOffset;
    CGFloat es_headerHeight;
    CGFloat es_detailHeight;
    CGFloat es_bottomHeight;
}

+ (instancetype)alertWithTitle:(NSString *)title detailContent:(NSString *)content alertType:(XMAlertStyle)alertType animationType:(XMAlertAnimationType)animationType isNarrowView:(BOOL)isNarrow withDelegate:(nullable id<XMAlertViewDelegate>)delegate{
    
    XMAlertView *alertView = [[XMAlertView alloc]initWithTitle:title detailContent:content alertType:alertType animationType:animationType isNarrowView:isNarrow withDelegate:delegate];
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title detailContent:(NSString *)content alertType:(XMAlertStyle)alertType animationType:(XMAlertAnimationType)animationType isNarrowView:(BOOL)isNarrow withDelegate:(nullable id<XMAlertViewDelegate>)delegate{
    self = [super initWithAlertStyle];
    if (self) {
        self.title = title;
        self.detailContent = content;
        self.alertStyle = alertType;
        self.animationType = animationType;
        self.isNarrow = isNarrow;
        self.delegate = delegate;
        self.contentView.backgroundColor = COLOR_255_255_255;
        property = [[ESPopupViewProperty alloc]init];
        ActionDefaultWidth = [self computedDefaultWidth];
        [self addContentSubViews];
       
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                  action:@selector(hideKeyBoard)];
//        [self.contentView addGestureRecognizer:gesture];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(keyboardFrameChange:)
//                                                     name:UIKeyboardWillChangeFrameNotification
//                                                   object:nil];
    }
    return self;
}

//- (instancetype)initWithTitle:(NSString *)title detailContent:(NSString *)content alertType:(XMAlertStyle)alertType animationType:(XMAlertAnimationType)animationType isNarrowView:(BOOL)isNarrow
//{
//    self = [super initWithAlertStyle];
//    if (self) {
//        self.title = title;
//        self.detailContent = content;
//        self.alertStyle = alertType;
//        self.animationType = animationType;
//        self.isNarrow = isNarrow;
//        self.delegate = nil;
//        self.contentView.backgroundColor = COLOR_255_255_255;
//        property = [[ESPopupViewProperty alloc]init];
//        ActionDefaultWidth = [self computedDefaultWidth];
//    }
//    return self;
//}

//- (void)hideKeyBoard
//{
//    [[UIApplication sharedApplication].delegate.window endEditing:YES];
//}
//
//- (void)keyboardFrameChange:(NSNotification *)notification
//{
//    NSDictionary *userInfo = notification.userInfo;
//    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//
//    if (CGRectGetMaxY(self.contentView.frame) > endFrame.origin.y) {
//        [UIView animateWithDuration:duration animations:^{
//            self.contentView.transform = CGAffineTransformMakeTranslation(0, endFrame.origin.y - CGRectGetMaxY(self.contentView.frame));
//        }];
//    }
//}

- (void)addAction:(NSArray<XMAlertAction *> *)items {
    _btnArr = items;
    _bottomView = [self customWithBottomView];
    _bottomView.frame = CGRectMake(_bottomView.frame.origin.x, heightOffset, _bottomView.frame.size.width, _bottomView.frame.size.height);
    heightOffset += _bottomView.frame.size.height;
    
    [self.contentView addSubview:_bottomView];
    [self updateContentViewLayout];
}

- (void)addContentSubViews {
    //1、若自定义上中下视图的高度，则获取自定义高度。2、若未自定义高度，则获取默认高度
    es_headerHeight = (self.delegate && [self.delegate respondsToSelector:@selector(heightForHeaderView)]) ? [self.delegate heightForHeaderView] : ActionDefaultHeaderHeight;
    es_detailHeight = (self.delegate && [self.delegate respondsToSelector:@selector(heightForDetailView)]) ? [self.delegate heightForDetailView] : ActionDefaultContentHeight;
    es_bottomHeight = (self.delegate && [self.delegate respondsToSelector:@selector(heightForBottomView)]) ? [self.delegate heightForBottomView] : ActionDefaultBottomHeight;
    
    heightOffset = 0.0;
    //顶部视图
    if (self.delegate && [self.delegate respondsToSelector:@selector(customHeaderSubview:)]) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ActionDefaultWidth, es_headerHeight)];
        [self.delegate customHeaderSubview:_headView];
    } else {
        _headView = [self customWithHeaderView];
    }
    [self.contentView addSubview:_headView];
    
    //中间content视图
    heightOffset = _headView.frame.size.height;
    if (self.delegate && [self.delegate respondsToSelector:@selector(customDetailSubview:)]) {
        _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, heightOffset, ActionDefaultWidth, es_detailHeight)];
        [self.delegate customDetailSubview:_detailView];
    } else {
        _detailView = [self customWithDetailView];
    }
    _detailView.frame = CGRectMake(_detailView.frame.origin.x, heightOffset, _detailView.frame.size.width, _detailView.frame.size.height);
    [self.contentView addSubview:_detailView];
    
    //底部按钮视图
    heightOffset +=_detailView.frame.size.height;
    if (self.delegate && [self.delegate respondsToSelector:@selector(customBottomSubview:)]) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, heightOffset, ActionDefaultWidth, es_bottomHeight)];
        [self.delegate customBottomSubview:_bottomView];
    } else {
        _bottomView = [self customWithBottomView];
    }
    _bottomView.frame = CGRectMake(_bottomView.frame.origin.x, heightOffset, _bottomView.frame.size.width, _bottomView.frame.size.height);
    [self.contentView addSubview:_bottomView];
    heightOffset += (_bottomView) ? _bottomView.frame.size.height : 0;
    
    [self updateContentViewLayout];
    [self showAnimated];
}


- (void)refreshDeatailViewHeight:(CGFloat)height {
    
    CGFloat oldHeight = _detailView.frame.size.height;
    CGFloat heightNow = height + oldHeight;
    heightOffset += height;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.bounds = CGRectMake(0, 0, self->ActionDefaultWidth, self->heightOffset);
        self.contentView.center = CGPointMake(self.center.x, self.center.y-50);
        self->_bottomView.transform = CGAffineTransformMakeTranslation(0, (height > 0) ? height : 0 );
        self->_detailView.frame = CGRectMake(self->_detailView.frame.origin.x, self->_detailView.frame.origin.y, self->_detailView.frame.size.width, heightNow);
    }];
}

- (void)showAnimated {
    CGRect rect = self.contentView.frame;
    CGSize size = self.contentView.frame.size;
    CGPoint point = self.contentView.frame.origin;
    switch (self.animationType) {
        case XMAlertAnimationDefault:
            
            break;
        case XMAlertAnimationBottomToCenter: {
            self.contentView.frame = CGRectMake(point.x, SCREEN_HEIGHT, size.width, size.height);
            [UIView animateWithDuration:AnimateDuration animations:^{
                self.contentView.frame = rect;
            }];
        }
            break;
        case XMAlertAnimationAlpha: {
            self.contentView.alpha  = 0.01;
            [UIView animateWithDuration:AnimateDuration animations:^{
                self.contentView.alpha  = 1.0;
            }];
        }
            break;
        case XMAlertAnimationPointSpread: {
            self.contentView.alpha = 0.01;
            [UIView animateWithDuration:0.1 animations:^{
                [self.contentView.layer setValue:@(0.01) forKeyPath:@"transform.scale"];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    [self.contentView.layer setValue:@(1.08) forKeyPath:@"transform.scale"];
                    self.contentView.alpha = 1.0;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        [self.contentView.layer setValue:@(0.97) forKeyPath:@"transform.scale"];
                    } completion:NULL];
                }];
            }];
        }
            break;
        default:
            break;
    }
    
    [self angleChanged];
}
//横屏处理
- (void)angleChanged
{
//    NSNumber *angleValue = [[NSUserDefaults standardUserDefaults] objectForKey:kModuleAngleValue];
//    if (angleValue.floatValue != 0) {
//        [UIView animateWithDuration:0.000000001 animations:^{
//            self.transform = CGAffineTransformMakeRotation(angleValue.floatValue);
//            self.bounds = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
//            //     self.contentView.hidden = YES;
//        } completion:^(BOOL finished) {
//            if (finished) {
//                self.contentView.center = CGPointMake(SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2);
//                //      self.contentView.hidden = NO;
//            }
//        }];
//    }
}

- (void)updateContentViewLayout {
    self.contentView.layer.cornerRadius = property.cornerRadius;
    switch (self.alertStyle) {
        case XMAlertStyleAlert:
            self.contentView.bounds = CGRectMake(0, 0, self->ActionDefaultWidth, self->heightOffset);
            self.contentView.center = self.center;
            break;
        case XMAlertStyleActionSheet:
            self.contentView.frame = CGRectMake((SCREEN_WIDTH-ActionDefaultWidth)/2.0, SCREEN_HEIGHT-heightOffset-10, ActionDefaultWidth, heightOffset);
            break;
        default:
            break;
    }
    [self angleChanged];
}

- (UIView *)customWithHeaderView {
    if (!self.title) return nil;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ActionDefaultWidth, ActionDefaultHeaderHeight)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, ActionDefaultWidth, property.titleFontSize+1)];
    titleLab.text = self.title;
    titleLab.font = [UIFont boldSystemFontOfSize:property.titleFontSize];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = COLOR_17_16_19;
    [headerView addSubview:titleLab];
    
    return headerView;
}

- (UIView *)customWithDetailView {
    //    NSLog(@"父类方法执行");
    if (!self.detailContent) return nil;
    CGFloat tmpWidth = ActionDefaultWidth-ActionDefaultleft*2;
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tmpWidth, 0)];
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.detailContent attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:property.detailFontSize]}];
    CGSize size =  [string boundingRectWithSize:CGSizeMake(tmpWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    CGFloat tmpHeight = (size.height > ActionDefaultContentHeight) ? size.height : ActionDefaultContentHeight;
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(ActionDefaultleft, 0, tmpWidth, tmpHeight)];
    detailLab.text = self.detailContent;
    detailLab.font = [UIFont systemFontOfSize:property.detailFontSize];
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.numberOfLines = 0;
    detailLab.textColor = COLOR_17_16_19;
    detailView.frame = CGRectMake(0, 0, tmpWidth, tmpHeight);
    [detailView addSubview:detailLab];
    return detailView;
}

- (UIView *)customWithBottomView {
    UIView *headView = [self updateBottomView];
    return headView;
}

- (UIView *)updateBottomView {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ActionDefaultWidth, 0)];
    if (_btnArr.count == 0) return bottomView;
    for (int i=0; i<_btnArr.count; i++) {
        XMAlertAction *action = (XMAlertAction *)_btnArr[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_btnArr.count == 1) {
            button.frame = CGRectMake((ActionDefaultWidth-ButtonWidth)/2.0, 10.0, ButtonWidth, ButtonHeight);
        } else {
            if (_btnArr.count <= 2) {
                CGFloat originX = i == 0 ? (ActionDefaultWidth / 2 - ButtonWidth - 10) : (ActionDefaultWidth / 2 + 10);
                button.frame = CGRectMake(originX, 10, ButtonWidth, ButtonHeight);
            } else {
                button.frame = CGRectMake((ActionDefaultWidth-ButtonWidth*2)/2.0, 10 + ButtonHeight*i, ButtonWidth*2, ButtonHeight);
            }
        }
        [button setTitle:action.title forState:UIControlStateNormal];
        [button setTitleColor:(action.titleColor ? action.titleColor : COLOR_182_34_47) forState:UIControlStateNormal];
        [button setBackgroundColor:(action.bgColor ? action.bgColor : COLOR_235_235_235) forState:UIControlStateNormal];
        
        [button setTitleColor:(action.highTitleColor ? action.highTitleColor : COLOR_235_235_235) forState:UIControlStateHighlighted];
        [button setBackgroundColor:(action.highBGColor ? action.highBGColor : COLOR_182_34_47) forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:property.itemFontSize];
        button.layer.cornerRadius = ButtonHeight/2.0;
        button.layer.borderWidth = 1/SCREEN_SCALE;
        button.layer.borderColor = COLOR_82_82_82.CGColor;
        button.clipsToBounds = true;
        [bottomView addSubview:button];
        [button addTapBlock:^{
            [self hideAnimatedCompletion:nil];
            if (action.handler) {
                action.handler();
            }
        }];
    }
    CGFloat tmpHeight = (_btnArr.count <=2) ? ActionDefaultBottomHeight : 50*(_btnArr.count);
    bottomView.frame = CGRectMake(0, 0, ActionDefaultWidth, tmpHeight);
    
    return bottomView;
}

- (CGFloat)computedDefaultWidth {
    return !self.isNarrow ? (SCREEN_WIDTH - ActionDefaultleft*2) : SCREEN_WIDTH / 375.0 * 260;
}

-(void)setWeatherAddLine:(BOOL)weatherAddLine {
    _weatherAddLine = weatherAddLine;
    if (_weatherAddLine) {
        UIView *headLine = [[UIView alloc]initWithFrame:CGRectMake(0, _headView.frame.size.height-1/SCREEN_SCALE, ActionDefaultWidth, 1/SCREEN_SCALE)];
        headLine.backgroundColor = COLOR_180_180_180;
        [_headView addSubview:headLine];
        
        UIView *bottoneLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ActionDefaultWidth, 1/SCREEN_SCALE)];
        bottoneLine.backgroundColor = COLOR_180_180_180;
        [_bottomView addSubview:bottoneLine];
    }
}

@end


