//
//  ViewController.m
//  XMAlertView
//
//  Created by pwn on 2019/2/26.
//  Copyright © 2019 pwn. All rights reserved.
//

#import "ViewController.h"
#import "XMAlertView.h"
#import "DefineAlertView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *typeArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _typeArr = @[@"默认style1",@"默认style2",@"只有头部",@"只有中部",@"只有底部",@"自定义弹框"];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _typeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alertCell" forIndexPath:indexPath];
    cell.textLabel.text = _typeArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            XMAlertView *view = [XMAlertView alertWithTitle:@"title" detailContent:@"诛侯伐爵,just a gun,biu~biu~" alertType:XMAlertStyleAlert animationType:XMAlertAnimationPointSpread isNarrowView:true withDelegate:nil];
            XMAlertAction *actionCancel = [XMAlertAction actionWithTitle:@"取消" handler:^{
                //处理取消事件
                NSLog(@"cancel");
            }];
            XMAlertAction *acitonOk = [XMAlertAction actionWithTitle:@"确定" handler:^{
                //处理确认事件
                NSLog(@"OK");
            }];
            [view addAction:@[actionCancel, acitonOk]];
        }
            break;
        case 1:
        {
            XMAlertView *view = [XMAlertView alertWithTitle:@"title" detailContent:@"诛侯伐爵,just a gun,biu~biu~" alertType:XMAlertStyleActionSheet animationType:XMAlertAnimationPointSpread isNarrowView:true withDelegate:nil];
            XMAlertAction *actionCancel = [XMAlertAction actionWithTitle:@"取消" handler:^{
                //处理取消事件
                NSLog(@"cancel");
            }];
            XMAlertAction *acitonOk = [XMAlertAction actionWithTitle:@"确定" handler:^{
                //处理确认事件
                NSLog(@"OK");
            }];
            [view addAction:@[actionCancel, acitonOk]];
            
        }
            break;
        case 2:
        {
            XMAlertView *view = [XMAlertView alertWithTitle:@"title" detailContent:nil alertType:XMAlertStyleAlert animationType:XMAlertAnimationPointSpread isNarrowView:true withDelegate:nil];
            view.tapToHide = true;
            [view addAction:nil];
            
        }
            break;
        case 3:
        {
            XMAlertView *view = [XMAlertView alertWithTitle:nil detailContent:@"诛侯伐爵,just a gun,biu~biu~" alertType:XMAlertStyleAlert animationType:XMAlertAnimationPointSpread isNarrowView:true withDelegate:nil];
            view.tapToHide = true;
            [view addAction:nil];
        }
            break;
        case 4:
        {
            XMAlertView *view = [XMAlertView alertWithTitle:nil detailContent:nil alertType:XMAlertStyleAlert animationType:XMAlertAnimationPointSpread isNarrowView:true withDelegate:nil];
            view.tapToHide = true;
            XMAlertAction *actionCancel = [XMAlertAction actionWithTitle:@"取消" handler:^{
                //处理取消事件
                NSLog(@"cancel");
            }];
            XMAlertAction *acitonOk = [XMAlertAction actionWithTitle:@"确定" handler:^{
                //处理确认事件
                NSLog(@"OK");
            }];
            [view addAction:@[actionCancel, acitonOk]];
        }
            break;
        case 5:
        {
            DefineAlertView *view = [[DefineAlertView alloc]initWithTitle:nil detailContent:nil alertType:XMAlertStyleAlert animationType:XMAlertAnimationPointSpread isNarrowView:true withDelegate:nil];
            view.tapToHide = true;
            XMAlertAction *actionCancel = [XMAlertAction actionWithTitle:@"取消" handler:^{
                //处理取消事件
                NSLog(@"cancel");
            }];
            XMAlertAction *acitonOk = [XMAlertAction actionWithTitle:@"确定" handler:^{
                //处理确认事件
                NSLog(@"OK");
            }];
            [view addAction:@[actionCancel, acitonOk]];
        }
            break;
            
        default:
            break;
    }
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"alertCell"];
    }
    return _tableView;
}


@end
