//
//  NCWReallyManager.m
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/24.
//  Copyright © 2015年 91. All rights reserved.
//

#import "NCWReallyManager.h"

static NCWReallyManager *gNCWReallyManager = nil;
@implementation NCWReallyManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shouleBeReally = NO;
    }
    return self;
}

+ (NCWReallyManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (gNCWReallyManager == nil) {
            gNCWReallyManager = [[NCWReallyManager alloc] init];
        }
    });
    return gNCWReallyManager;
}

@end
