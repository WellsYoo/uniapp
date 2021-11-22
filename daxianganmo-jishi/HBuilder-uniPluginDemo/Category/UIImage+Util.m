//
//  UIImage+Util.m
//  MTTransferPictures
//
//  Created by YWH on 2018/4/3.
//  Copyright © 2018年 meitu. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 0.5f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}
@end
