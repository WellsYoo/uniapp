//
//  MPITextBorder.m
//  MeituMV
//
//  Created by Tpphha on 2018/8/14.
//  Copyright © 2018年 美图网. All rights reserved.
//

#import "MPITextBackground.h"
#import "MPITextEqualityHelpers.h"
#import "MPITextHashing.h"

@implementation MPITextBackground

+ (instancetype)backgroundWithFillColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    MPITextBackground *one = [self new];
    one.fillColor = color;
    one.cornerRadius = cornerRadius;
    one.lineJoin = kCGLineJoinRound;
    return one;
}

- (CGRect)backgroundRectForTextContainer:(NSTextContainer *)textContainer
                            proposedRect:(CGRect)proposedRect
                          characterRange:(NSRange)characterRange {
    return UIEdgeInsetsInsetRect(proposedRect, self.insets);
}

- (NSUInteger)hash {
#pragma clang diagnostic push
#pragma clang diagnostic warning "-Wpadded"
    struct {
        CGFloat strokeWidth;
        NSUInteger strokeColorHash;
        NSUInteger lineJoin;
        UIEdgeInsets insets;
        CGFloat cornerRadius;
        NSUInteger fillColorHash;
#pragma clang diagnostic pop
    } data = {
        _strokeWidth,
        [_strokeColor hash],
        _lineJoin,
        _insets,
        _cornerRadius,
        [_fillColor hash]
    };
    return MPITextHashBytes(&data, sizeof(data));
}

- (BOOL)isEqual:(MPITextBackground *)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:self.class]) {
        return NO;
    }
    
    return
    ABS(self.strokeWidth - object.strokeWidth) < FLT_EPSILON &&
    MPITextObjectIsEqual(self.strokeColor, object.strokeColor) &&
    self.lineJoin == object.lineJoin &&
    UIEdgeInsetsEqualToEdgeInsets(self.insets, object.insets) &&
    ABS(self.cornerRadius - object.cornerRadius) < FLT_EPSILON &&
    MPITextObjectIsEqual(self.fillColor, object.fillColor);
}

@end
