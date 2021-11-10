//
//  MTAreaManagerSetting.m
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/19.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import "MTAreaManagerSetting.h"

static NSString *const kMTAreaManagerDeviceToken    = @"MTAreaManagerDeviceToken";

static NSString *const kDefaultAreaManagerServerUrl = @"https://api.data.meitu.com/location";

@interface MTAreaManagerSetting ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation MTAreaManagerSetting

+ (instancetype)shared {
    
    static MTAreaManagerSetting *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MTAreaManagerSetting alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        //  设置默认值
        self.serverUrl       = kDefaultAreaManagerServerUrl;
        self.timeoutInterval = 30.f;
        self.needGPSLocation = YES;
    }
    return self;
}

#pragma mark - Setter、Getter

- (NSUserDefaults *)userDefaults {
    
    if (!_userDefaults) {
        _userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"MTAreaManagerKit"];
    }
    return _userDefaults;
}

- (void)setDeviceToken:(NSString *)deviceToken {
    
    [self.userDefaults setObject:deviceToken forKey:kMTAreaManagerDeviceToken];
    [self.userDefaults synchronize];
}

- (NSString *)deviceToken {
    
    return [self.userDefaults objectForKey:kMTAreaManagerDeviceToken];
}

@end
