//
//  WXHEmptyDataSetView.h
//  EmptyDataDemo
//
//  Created by 伍小华 on 2017/9/21.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXHEmptyDataModel;

@interface WXHEmptyDataSetView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptLabel;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign) id responser;
@property (nonatomic, weak  ) UIView *responserView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) WXHEmptyDataModel *emptyDataModel;
@property (nonatomic, strong) NSString *emptyDataStatusName;
- (void)setupData:(WXHEmptyDataModel *)model;
@end
