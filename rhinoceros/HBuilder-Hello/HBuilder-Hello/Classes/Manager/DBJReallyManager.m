//
//  NCWReallyManager.m
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/24.
//  Copyright © 2015年 91. All rights reserved.
//

#import "DBJReallyManager.h"

static DBJReallyManager *gNCWReallyManager = nil;
@implementation DBJReallyManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shouleBeReally = NO;
    }
    return self;
}

+ (DBJReallyManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (gNCWReallyManager == nil) {
            gNCWReallyManager = [[DBJReallyManager alloc] init];
        }
    });
    return gNCWReallyManager;
}

@end
