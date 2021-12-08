//
//  MTAppRequest.m
//  MTAppCommunication
//
//  Created by JoyChiang on 13-3-13.
//  Copyright (c) 2013年 Meitu. All rights reserved.
//

#import "CGJAppRequest.h"

@interface CGJAppRequest()

@property(nonatomic, copy, readwrite) NSString *requestID;

@end

/////////////////////////////////////////////////////////////////////////////////////

@implementation CGJAppRequest

- (instancetype)init {
    if (self = [super init]) {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        _requestID = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
        CFRelease(uuid);
    }
    return self;
}

- (void)dealloc {
}

@end
