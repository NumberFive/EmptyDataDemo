//
//  WXHEmptyDataSetView.m
//  EmptyDataDemo
//
//  Created by 伍小华 on 2017/9/21.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "WXHEmptyDataSetView.h"
#import "WXHEmptyDataSetConfig.h"
#import "NSString+WXH.h"
#import <Masonry/Masonry.h>

@interface WXHEmptyDataSetView ()

@end

@implementation WXHEmptyDataSetView
- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.descriptLabel];
        
        self.clipsToBounds = YES;
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(grestureDidTap)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self refreshConstraints];
}

- (void)setupData:(WXHEmptyDataModel *)model
{
    self.emptyDataModel = model;
    
    self.backgroundColor = model.backgroundColor;
    self.backgroundImageView.image = [UIImage imageNamed:model.backgroundImageName];
    self.imageView.image = [UIImage imageNamed:model.imageName];
    
    self.titleLabel.textColor = model.titleColor;
    self.titleLabel.font = model.titleFont;
    self.titleLabel.attributedText = model.title;
    
    self.descriptLabel.textColor = model.descriptColor;
    self.descriptLabel.font = model.descriptFont;
    self.descriptLabel.attributedText = model.descript;
    
    [self refreshConstraints];
}
- (void)refreshConstraints
{
    UIImage *image = self.imageView.image;
    NSString *titleString = self.titleLabel.attributedText.string;
    NSString *descriptString = self.descriptLabel.attributedText.string;
    
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(image.size.width));
        make.height.equalTo(@(image.size.height));
        make.centerX.equalTo(self);
        
        if (titleString.length) {
            make.bottom.equalTo(self.titleLabel.mas_top).offset(-self.emptyDataModel.imageTitleSpace);
        } else {
            make.bottom.equalTo(self.descriptLabel.mas_top).offset(-self.emptyDataModel.imageTitleSpace);
        }
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.emptyDataModel.padding);
        make.right.equalTo(self).offset(-self.emptyDataModel.padding);
        
        CGFloat height = [titleString heightForFont:self.titleLabel.font width:(self.frame.size.width - 2*self.emptyDataModel.padding)];
        height = height > 0 ? height+5 : height;
        make.height.equalTo(@(height));
        make.centerY.equalTo(self);
    }];
    [self.descriptLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.emptyDataModel.padding);
        make.right.equalTo(self).offset(-self.emptyDataModel.padding);
        
        CGFloat height = [descriptString heightForFont:self.descriptLabel.font width:(self.frame.size.width - 2*self.emptyDataModel.padding)];
        height = height > 0 ? height+5 : height;
        make.height.equalTo(@(height));
        
        if (titleString.length) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(self.emptyDataModel.titleDescriptSpace);
        } else {
            make.centerY.equalTo(self);
        }
    }];
}

- (void)grestureDidTap
{
    SEL selector = NSSelectorFromString(@"emptyDataSetViewDidTap:");
    if ([self.responser respondsToSelector:selector]) {
        [self.responser performSelector:selector withObject:self afterDelay:0.0f];
    }
}
- (UIImageView *)backgroundImageView
{
    if(!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundImageView;
}
#pragma mark - Setter / Getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UILabel *)descriptLabel
{
    if (!_descriptLabel) {
        _descriptLabel = [[UILabel alloc] init];
        _descriptLabel.font = [UIFont systemFontOfSize:25.0];
        _descriptLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
        _descriptLabel.textAlignment = NSTextAlignmentCenter;
        _descriptLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptLabel.numberOfLines = 0;
    }
    return _descriptLabel;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"WXHEmptyDataSetView dealloc");
#endif
}
@end


