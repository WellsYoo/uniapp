//
//  MPITextRendererKey.m
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import "MPITextRendererKey.h"
#import <iostream>
#import "MPITextRenderAttributes.h"
#import "MPITextHashing.h"
#import "MPITextEqualityHelpers.h"

@implementation MPITextRendererKey {
    std::mutex _m;
}

- (instancetype)initWithAttributes:(MPITextRenderAttributes *)attributes constrainedSize:(CGSize)constrainedSize {
    self = [super init];
    if (self) {
        _attributes = attributes;
        _constrainedSize = constrainedSize;
    }
    return self;
}

- (NSUInteger)hash
{
    std::lock_guard<std::mutex> _l(_m);
#pragma clang diagnostic push
#pragma clang diagnostic warning "-Wpadded"
    struct {
        size_t attributesHash;
        CGSize constrainedSize;
#pragma clang diagnostic pop
    } data = {
        _attributes.hash,
        _constrainedSize
    };
    return MPITextHashBytes(&data, sizeof(data));
}

- (BOOL)isEqual:(MPITextRendererKey *)object
{
    if (self == object) {
        return YES;
    }
    
    // NOTE: Skip the class check for this specialized, internal Key object.
    
    // Lock both objects, avoiding deadlock.
    std::lock(_m, object->_m);
    std::lock_guard<std::mutex> lk1(_m, std::adopt_lock);
    std::lock_guard<std::mutex> lk2(object->_m, std::adopt_lock);
    
    return
    MPITextObjectIsEqual(_attributes, object->_attributes)  &&
    CGSizeEqualToSize(_constrainedSize, object->_constrainedSize);
}



@end
