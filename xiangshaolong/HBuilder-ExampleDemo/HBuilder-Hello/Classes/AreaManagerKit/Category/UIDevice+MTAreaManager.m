//
//  UIDevice+MTAreaManager.m
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/22.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import "UIDevice+MTAreaManager.h"
#import <AdSupport/AdSupport.h>
#include <sys/sysctl.h>

@implementation UIDevice (MTAreaManager)

+ (NSString *)areaManager_IDFA {
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:
                                 @"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    } else {
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        if (asIdentifierMClass == nil) {
            return @"";
        } else {
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            if (asIM == nil) {
                return @"";
            }
            else {
                if (asIM.advertisingTrackingEnabled) {
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else {
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

#pragma mark sysctlbyname utils

- (NSString *)areaManager_getSysInfoByName:(char *)typeSpecifier {
    
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *)areaManager_devicePlatform {
    
    return [self areaManager_getSysInfoByName:"hw.machine"];
}

@end
