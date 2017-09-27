//
//  ViewController.m
//  EmptyDataDemo
//
//  Created by 伍小华 on 2017/9/20.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import "ViewController.h"
#import "UIViewController+WXHEmptyDataSet.h"
#import <objc/runtime.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    [self.view addSubview:self.webView];
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    [self.webView loadHTMLString:@"测试" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我试试" forState:UIControlStateNormal];
    button.tag = 0;
    button.frame = CGRectMake(0, 0, 100, 50);
    button.backgroundColor = [UIColor brownColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self setupEmptyData];
}
- (void)buttonAction:(UIButton *)button
{
    button.tag = (button.tag+1) % 4;
    if (button.tag == 0) {
        
        self.dataArray = @[@"123",@"123",@"123",@"123"];
        [self setEmptyView:self.tableView dataStatus:WXHEmptyDataStatusNormal];
    } else if (button.tag == 1) {
        [self setEmptyView:self.tableView dataStatus:WXHEmptyDataStatusNetError];
    } else if (button.tag == 2) {
        [self setEmptyView:self.tableView dataStatus:WXHEmptyDataStatusCollect];
    } else if (button.tag == 3) {
        [self setEmptyView:self.tableView dataStatus:WXHEmptyDataStatusContent];
    }
}
- (void)setupEmptyData
{
    WXHEmptyDataModel *model1 = [[WXHEmptyDataModel alloc] init];
    model1.imageName = @"公用_网络不好.png";
    model1.title = [[NSMutableAttributedString alloc] initWithString:@"当前网络状况不好"];
    model1.descript = [[NSMutableAttributedString alloc] initWithString:@"你是不是上了个蜘蛛网了，请稍后点击屏幕刷新！"];
    
    WXHEmptyDataModel *model2 = [[WXHEmptyDataModel alloc] init];
    model2.imageName = @"公用_网络不好.png";
    model2.title = [[NSMutableAttributedString alloc] initWithString:@"收藏内容为空"];
    model2.descript = [[NSMutableAttributedString alloc] initWithString:@"你还没有收藏东西哦，赶紧去收藏吧！"];
    
    WXHEmptyDataModel *model3 = [[WXHEmptyDataModel alloc] init];
    model3.imageName = @"公用_网络不好.png";
    model3.backgroundColor = [UIColor whiteColor];
    model3.title = [[NSMutableAttributedString alloc] initWithString:@"练习记录为空"];
    model3.descript = [[NSMutableAttributedString alloc] initWithString:@"你没有做过这份练习，还没有练习记录，赶紧去练习吧！"];
    
//    [WXHEmptyDataSetConfig setModel:model1 forStatus:WXHEmptyDataStatusNetError];
//    [WXHEmptyDataSetConfig setModel:model2 forStatus:WXHEmptyDataStatusCollect];
//    [WXHEmptyDataSetConfig setModel:model3 forStatus:WXHEmptyDataStatusContent];
    [WXHEmptyDataSetConfig setModels:@[model1,model2,model3]
                           forStatus:@[WXHEmptyDataStatusNetError,WXHEmptyDataStatusCollect,WXHEmptyDataStatusContent]];
}

- (void)emptyDataSetViewDidTap:(WXHEmptyDataSetView *)emptyDataSetView responserView:(UIView *)view dataStatus:(NSString *)name
{
    NSLog(@"%s,dataStatus:%@", class_getName([view class]),name);
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}
#pragma mark - Setter / Getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 60;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.tableView reloadData];
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.scrollView.alwaysBounceVertical = YES;
    }
    return _webView;
}
@end
