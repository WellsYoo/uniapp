//
//  UIDevice+MTIdentifier.m
//  MTTransferPictures
//
//  Created by YWH on 2018/3/9.
//  Copyright © 2018年 meitu. All rights reserved.
//

#import "UIDevice+MTUtil.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (MTUtil)
- (NSString *)mt_idfvString {
    NSString *idfv = @"";
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        idfv = [[UIDevice currentDevice].identifierForVendor UUIDString];
    }

    return idfv;
}

- (NSString *) mt_getSysInfoByName:(char *)typeSpecifier {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *) mt_platform {
    return [self mt_getSysInfoByName:"hw.machine"];
}
@end
