//
//  UIView+MTUtil.h
//  MTTransferPictures
//
//  Created by mtgao on 2018/7/5.
//  Copyright © 2018年 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTUtil)
//给UIView设置指定边的边框
+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
@end
