//
//  DefineAlertView.m
//  XMAlertView
//
//  Created by pwn on 2019/2/26.
//  Copyright © 2019 pwn. All rights reserved.
//

#import "DefineAlertView.h"
#import <WebKit/WebKit.h>

@implementation DefineAlertView

- (UIView *)customWithHeaderView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ActionDefaultWidth, 40)];
    headView.backgroundColor = [UIColor redColor];
    return headView;
}

- (UIView *)customWithDetailView
{
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ActionDefaultWidth, 200)];
    detailView.backgroundColor = [UIColor greenColor];
    
    NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bear" ofType:@"gif"]];
    WKWebView *imageView = [[WKWebView alloc]initWithFrame:CGRectMake(20, 20, ActionDefaultWidth-40, 160)];
    [imageView loadData:gifData MIMEType:@"image/gif" characterEncodingName:nil baseURL:nil];
    [detailView addSubview:imageView];
    
    return detailView;
}

- (UIView *)customWithBottomView
{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ActionDefaultWidth, 80)];
    bottomView.backgroundColor = [UIColor blueColor];
    return bottomView;
}

@end
