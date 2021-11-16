//
//  NCWReallyManager.m
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/24.
//  Copyright © 2015年 91. All rights reserved.
//

#import "CGJReallyManager.h"

static CGJReallyManager *gNCWReallyManager = nil;
@implementation CGJReallyManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shouleBeReally = NO;
    }
    return self;
}

+ (CGJReallyManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (gNCWReallyManager == nil) {
            gNCWReallyManager = [[CGJReallyManager alloc] init];
        }
    });
    return gNCWReallyManager;
}

@end
