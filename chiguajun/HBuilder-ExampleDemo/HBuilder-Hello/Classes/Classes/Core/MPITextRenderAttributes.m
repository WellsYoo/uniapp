//
//  MPITextRenderAttributes.m
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import "MPITextRenderAttributes.h"

#import "MPITextEqualityHelpers.h"
#import "MPITextHashing.h"

@implementation MPITextRenderAttributes

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return self;
}

- (NSUInteger)hash {
#pragma clang diagnostic push
#pragma clang diagnostic warning "-Wpadded"
    struct {
        NSUInteger attrStringHash;
        NSLineBreakMode lineBreakMode;
        NSUInteger maximumNumberOfLines;
        NSUInteger exclusionPathsHash;
        NSUInteger truncationAttrStringHash;
#pragma clang diagnostic pop
    } data = {
        [self.attributedText hash],
        self.lineBreakMode,
        self.maximumNumberOfLines,
        [self.exclusionPath hash],
        [self.truncationAttributedText hash]
    };
    return MPITextHashBytes(&data, sizeof(data));
}

- (BOOL)isEqual:(MPITextRenderAttributes *)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:self.class]) {
        return NO;
    }
    
    return
    MPITextObjectIsEqual(self.attributedText, object.attributedText) &&
    MPITextObjectIsEqual(self.exclusionPath, object.exclusionPath) &&
    self.lineBreakMode == object.lineBreakMode &&
    self.maximumNumberOfLines == object.maximumNumberOfLines &&
    MPITextObjectIsEqual(self.truncationAttributedText, object.truncationAttributedText);
}

@end
