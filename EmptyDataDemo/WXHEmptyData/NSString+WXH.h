//
//  NSString+WXH.h
//  EmptyDataDemo
//
//  Created by 伍小华 on 2017/9/21.
//  Copyright © 2017年 wxh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (WXH)
- (CGFloat)widthForFont:(UIFont *)font;
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;
@end
