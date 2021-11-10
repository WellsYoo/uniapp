//
//  MPITextBorder.h
//  MeituMV
//
//  Created by Tpphha on 2018/8/14.
//  Copyright © 2018年 美图网. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPITextBackground : NSObject

@property (nonatomic) CGFloat strokeWidth;                    ///< border line width
@property (nullable, nonatomic, strong) UIColor *strokeColor; ///< border line color
@property (nonatomic) CGLineJoin lineJoin;                    ///< border line join
@property (nonatomic) UIEdgeInsets insets;                    ///< border insets for text bounds
@property (nonatomic) CGFloat cornerRadius;                   ///< border corder radius
@property (nullable, nonatomic, strong) UIColor *fillColor;   ///< inner fill color

+ (instancetype)backgroundWithFillColor:(nullable UIColor *)color cornerRadius:(CGFloat)cornerRadius;

/**
 If the background across multiple lines, this method will be called multiple times.

 @param textContainer textContainer
 @param proposedRect proposed rect.
 @param characterRange characterRange.
 @return The rect to be applied.
 */
- (CGRect)backgroundRectForTextContainer:(NSTextContainer *)textContainer
                            proposedRect:(CGRect)proposedRect
                          characterRange:(NSRange)characterRange NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
