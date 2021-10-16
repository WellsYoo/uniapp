//
//  NCWReallyManager.m
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/24.
//  Copyright © 2015年 91. All rights reserved.
//

#import "XSLReallyManager.h"

static XSLReallyManager *gNCWReallyManager = nil;
@implementation XSLReallyManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shouleBeReally = NO;
    }
    return self;
}

+ (XSLReallyManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (gNCWReallyManager == nil) {
            gNCWReallyManager = [[XSLReallyManager alloc] init];
        }
    });
    return gNCWReallyManager;
}

@end
