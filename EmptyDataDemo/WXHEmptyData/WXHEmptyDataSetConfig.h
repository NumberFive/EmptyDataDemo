//
//  WXHEmptyDataSetConfig.h
//  EmptyDataDemo
//
//  Created by 伍小华 on 2017/9/20.
//  Copyright © 2017年 wxh. All rights reserved.
//

#define SINGLE_INTERFACE(className) \
+ (className *)shared##className;

// @implementation
#define SINGLE_IMPLEMENTATION(className) \
\
static className *shared##className = nil; \
\
+ (className *)shared##className \
{ \
@synchronized(self) \
{ \
if (shared##className == nil) \
{ \
shared##className = [[self alloc] init]; \
} \
} \
\
return shared##className; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##className == nil) \
{ \
shared##className = [super allocWithZone:zone]; \
return shared##className; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXHEmptyDataSetView.h"

static NSString* const WXHEmptyDataStatusNormal = @"WXHEmptyDataStatusNormal";
static NSString* const WXHEmptyDataStatusNetError = @"WXHEmptyDataStatusNetError";
static NSString* const WXHEmptyDataStatusContent = @"WXHEmptyDataStatusContent";
static NSString* const WXHEmptyDataStatusCollect = @"WXHEmptyDataStatusCollect";

@interface WXHEmptyDataModel : NSObject
@property (nonatomic, strong) NSAttributedString *title;
@property (nonatomic, strong) NSAttributedString *descript;

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *backgroundImageName;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *descriptColor;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *descriptFont;

@property (nonatomic, assign) CGFloat imageTitleSpace;
@property (nonatomic, assign) CGFloat titleDescriptSpace;
@property (nonatomic, assign) CGFloat padding;
@end

@interface WXHEmptyDataSetConfig : NSObject
@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *descriptColor;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *descriptFont;

@property (nonatomic, assign) CGFloat imageTitleSpace;
@property (nonatomic, assign) CGFloat titleDescriptSpace;
@property (nonatomic, assign) CGFloat padding;

SINGLE_INTERFACE(WXHEmptyDataSetConfig)
+ (void)setModel:(WXHEmptyDataModel *)model forStatus:(NSString *)name;
+ (void)setModels:(NSArray<WXHEmptyDataModel *> *)models forStatus:(NSArray<NSString *> *)names;
+ (WXHEmptyDataModel *)getModelOfStatus:(NSString *)name;
@end
