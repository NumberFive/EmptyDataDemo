//
//  UIViewController+WXHEmptyDataSet.h
//  EmptyDataDemo
//
//  Created by 伍小华 on 2017/9/20.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXHEmptyDataSetConfig.h"

@interface UIViewController (WXHEmptyDataSet)

- (void)setEmptyView:(UIView *)view dataStatus:(NSString *)name;
- (void)emptyDataSetViewDidTap:(WXHEmptyDataSetView *)emptyDataSetView
                 responserView:(UIView *)view
                    dataStatus:(NSString *)name;
@end
