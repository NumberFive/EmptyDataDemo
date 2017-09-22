//
//  UIViewController+WXHEmptyDataSet.m
//  EmptyDataDemo
//
//  Created by 伍小华 on 2017/9/20.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <objc/runtime.h>
#import <WebKit/WebKit.h>
#import "UIViewController+WXHEmptyDataSet.h"

static char const * const kEmptyViewDic = "kEmptyViewDic";
@interface UIViewController ()
@property (nonatomic, strong) NSMutableDictionary *emptyViewDic;
@end

@implementation UIViewController (WXHEmptyDataSet)
- (void)setEmptyView:(UIView *)view dataStatus:(NSString *)name
{
    if (view && name) {
        NSString *viewKey = [NSString stringWithFormat:@"%p",view];
        WXHEmptyDataSetView *emptyView = self.emptyViewDic[viewKey];
        
        if (name == nil || [name isEqualToString:WXHEmptyDataStatusNormal]) {
            if (emptyView) {
                [emptyView removeFromSuperview];
                [self.emptyViewDic removeObjectForKey:viewKey];
            }
        } else {
            
            WXHEmptyDataModel *model = [WXHEmptyDataSetConfig getModelOfStatus:name];
            
            if (!emptyView) {
                emptyView = [[WXHEmptyDataSetView alloc] init];
                
                UIView *superView = view;
                if ([view isKindOfClass:[WKWebView class]]) {
                    WKWebView *webView = (WKWebView *)view;
                    superView = webView.scrollView;
                } else if ([view isKindOfClass:[UIWebView class]]) {
                    UIWebView *webView = (UIWebView *)view;
                    superView = webView.scrollView;
                }
                [superView insertSubview:emptyView atIndex:INT_MAX];
                [self.emptyViewDic setObject:emptyView forKey:viewKey];
            }
            
            emptyView.responser = self;
            emptyView.responserView = view;
            emptyView.emptyDataStatusName = name;
            [emptyView setupData:model];
            
            [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.equalTo(view);
                make.center.equalTo(view);
            }];
        }
    }
}

- (void)emptyDataSetViewDidTap:(WXHEmptyDataSetView *)view
{
    [self emptyDataSetViewDidTap:view
                   responserView:view.responserView
                      dataStatus:view.emptyDataStatusName];
}
- (void)emptyDataSetViewDidTap:(WXHEmptyDataSetView *)emptyDataSetView
                 responserView:(UIView *)view
                    dataStatus:(NSString *)name
{
    
}

#pragma mark - Setter / Getter
- (NSMutableDictionary *)emptyViewDic
{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, kEmptyViewDic);
    if (!dic) {
        [self setEmptyViewDic:[NSMutableDictionary dictionary]];
    }
    return dic;
}

- (void)setEmptyViewDic:(NSMutableDictionary *)emptyViewDic
{
    objc_setAssociatedObject(self, kEmptyViewDic, emptyViewDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
