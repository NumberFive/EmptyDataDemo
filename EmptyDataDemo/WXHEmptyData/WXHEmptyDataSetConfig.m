//
//  WXHEmptyDataSetConfig.m
//  EmptyDataDemo
//
//  Created by 伍小华 on 2017/9/20.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import "WXHEmptyDataSetConfig.h"
@implementation WXHEmptyDataModel
@end

@interface WXHEmptyDataSetConfig ()
@property (nonatomic, strong) NSMutableDictionary *dataStatusDic;
@end
@implementation WXHEmptyDataSetConfig
SINGLE_IMPLEMENTATION(WXHEmptyDataSetConfig)
- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor    = [UIColor clearColor];
        self.titleColor         = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        self.descriptColor      = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
        
        self.titleFont          = [UIFont systemFontOfSize:30.0];
        self.descriptFont       = [UIFont systemFontOfSize:20.0];
        
        self.imageTitleSpace    = 10.0;
        self.titleDescriptSpace = 10.0;
        self.padding            = 20.0;
    }
    return self;
}

- (void)setModel:(WXHEmptyDataModel *)model forStatus:(NSString *)name
{
    if (name && model) {
        model.backgroundColor       = model.backgroundColor     == nil ? self.backgroundColor     : model.backgroundColor;
        model.titleColor            = model.titleColor          == nil ? self.titleColor          : model.titleColor;
        model.descriptColor         = model.descriptColor       == nil ? self.descriptColor       : model.descriptColor;
        model.titleFont             = model.titleFont           == nil ? self.titleFont           : model.titleFont;
        model.descriptFont          = model.descriptFont        == nil ? self.descriptFont        : model.descriptFont;
        model.imageTitleSpace       = model.imageTitleSpace     == 0.0 ? self.imageTitleSpace     : model.imageTitleSpace;
        model.titleDescriptSpace    = model.titleDescriptSpace  == 0.0 ? self.titleDescriptSpace  : model.titleDescriptSpace;
        model.padding               = model.padding             == 0.0 ? self.padding             : model.padding;
        [self.dataStatusDic setObject:model forKey:name];
    }
}
- (WXHEmptyDataModel *)getModelOfStatus:(NSString *)name
{
    return [self.dataStatusDic objectForKey:name];
}

+ (void)setModels:(NSArray<WXHEmptyDataModel *> *)models forStatus:(NSArray<NSString *> *)names
{
    WXHEmptyDataSetConfig *config = [WXHEmptyDataSetConfig sharedWXHEmptyDataSetConfig];
    if (models.count == names.count) {
        NSInteger index = 0;
        for (WXHEmptyDataModel *model in models) {
            [config setModel:model forStatus:names[index]];
            index++;
        }
    }
}
+ (void)setModel:(WXHEmptyDataModel *)model forStatus:(NSString *)name
{
    WXHEmptyDataSetConfig *config = [WXHEmptyDataSetConfig sharedWXHEmptyDataSetConfig];
    [config setModel:model forStatus:name];
}
+ (WXHEmptyDataModel *)getModelOfStatus:(NSString *)name
{
    WXHEmptyDataSetConfig *config = [WXHEmptyDataSetConfig sharedWXHEmptyDataSetConfig];
    return [config getModelOfStatus:name];
}
#pragma mark - Setter / Getter
- (NSMutableDictionary *)dataStatusDic
{
    if (!_dataStatusDic) {
        _dataStatusDic = [NSMutableDictionary dictionary];
    }
    return _dataStatusDic;
}
@end
