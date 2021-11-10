//
//  NCWReallyManager.m
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/24.
//  Copyright © 2015年 91. All rights reserved.
//

#import "CCReallyManager.h"

static CCReallyManager *gNCWReallyManager = nil;
@implementation CCReallyManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shouleBeReally = NO;
    }
    return self;
}

+ (CCReallyManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (gNCWReallyManager == nil) {
            gNCWReallyManager = [[CCReallyManager alloc] init];
        }
    });
    return gNCWReallyManager;
}

@end
