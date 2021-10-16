//
//  MTAreaManagerKit.m
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/18.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import "EGAreaManagerKit.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import "XSLPSManager.h"
#import "EGAreaRequestBasic.h"

#import "NSObject+MTAreaManagerUtil.h"

static NSString* const AREADATAMODEL_KEY = @"AreaDataModel";

@interface EGAreaManagerKit ()

@property (nonatomic, copy) MTAreaCompletionHandler completionHandler;

@end

@implementation EGAreaManagerKit

+ (instancetype)shared {
    
    static EGAreaManagerKit *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EGAreaManagerKit alloc] init];
    });
    return sharedInstance;
}

- (void)requestAreaWithCompletionHandler:(MTAreaCompletionHandler)handler {
    
    self.completionHandler = handler;
    
    
    //  是否需要GPS定位
    if ([MTAreaManagerSetting shared].needGPSLocation) {
        
        [XSLPSManager requestGPSWithCompletionHandler:^(MTGPSDataModel *gpsModel, BOOL isSuccess) {
            if (isSuccess) {
                [MTAreaManagerSetting shared].gpsDataModel = gpsModel;
            }
            
            [self requestArea];
        }];
    } else {
        [self requestArea];
    }
}

- (void)requestArea {
    
    NSURL *url = [NSURL URLWithString:[[MTAreaManagerSetting shared] serverUrl]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:[MTAreaManagerSetting shared].timeoutInterval];
    request.HTTPMethod = @"POST";
    
    NSDictionary *json = [[EGAreaRequestBasic shared] basicParametersForAreaRequest];
    NSData *postData = [json areaManager_postData];
    request.HTTPBody = postData;
    
    // 4.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            
            NSDictionary *data = dict[@"data"];
            
            if (data) {
                CCAreaDataModel *model = [[CCAreaDataModel alloc] initWithDictionary:data];
                
                if (self.completionHandler) {
                    self.completionHandler(model, MTAreaDataServerSource, YES);
                    self.completionHandler = nil;
                }
            } else {
                if (self.completionHandler) {
                    self.completionHandler(nil, MTAreaDataServerSource, NO);
                    self.completionHandler = nil;
                }
            }
            
        } else {
            if (self.completionHandler) {
                self.completionHandler(nil, MTAreaDataServerSource, NO);
                self.completionHandler = nil;
            }
        }
    }];
    
}

+ (CCAreaDataModel *)areaDataModelWithCountryCode:(NSString *)countryCode {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MTAreaConfiguration" ofType:@"plist"];
    NSDictionary *areaList = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    CCAreaDataModel *model = [[CCAreaDataModel alloc] initWithDictionary:areaList[countryCode]];
    model.countryCode = countryCode;
    return model;
}

+ (CCAreaDataModel *)fetchSystemArea {
    
    NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
    NSString *countryCode = [[locale objectForKey:NSLocaleCountryCode] uppercaseString];
    
    CCAreaDataModel *model = [self areaDataModelWithCountryCode:countryCode];
    
    return model;
}

+ (CCAreaDataModel *)fetchSIMCardArea {
    
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    NSString *countryCode = [carrier.isoCountryCode uppercaseString];
    
    if (countryCode.length) {
        CCAreaDataModel *model = [self areaDataModelWithCountryCode:countryCode];
        return model;
    } else {
        return nil;
    }
}

#pragma mark - MTAreaManagerKit Interface

+ (void)requestAreaWithAppId:(NSString *)appId
                    language:(NSString *)language
                      isTest:(BOOL)isTest
           completionHandler:(MTAreaCompletionHandler)handler {
    
    [EGAreaManagerKit requestAreaWithAppId:appId
                                  language:language
                                   channel:@"AppStore"
                                    isTest:isTest
                         uploadSimCardInfo:YES
                         completionHandler:handler];
}

+ (void)requestAreaWithAppId:(NSString *)appId
                    language:(NSString *)language
                     channel:(NSString *)channel
                      isTest:(BOOL)isTest
           completionHandler:(MTAreaCompletionHandler)handler {
    
    [EGAreaManagerKit requestAreaWithAppId:appId
                                  language:language
                                   channel:channel
                                    isTest:isTest
                         uploadSimCardInfo:YES
                         completionHandler:handler];
}

+ (void)requestAreaWithAppId:(NSString *)appId
                    language:(NSString *)language
                     channel:(NSString *)channel
                      isTest:(BOOL)isTest
           uploadSimCardInfo:(BOOL)uploadSimCardInfo
           completionHandler:(MTAreaCompletionHandler)handler {
    
    [MTAreaManagerSetting shared].appId    = appId;
    [MTAreaManagerSetting shared].language = language;
    [MTAreaManagerSetting shared].channel  = channel;
    [MTAreaManagerSetting shared].isTest   = @(isTest);
    if (uploadSimCardInfo) {
        [MTAreaManagerSetting shared].simCardCountryCode = [self fetchSIMCardArea].countryCode;
    }
    
    [[EGAreaManagerKit shared] requestAreaWithCompletionHandler:handler];
}

+ (void)fetchLocalAreaWithCompletionHandler:(MTAreaCompletionHandler)handler {
    
    //  取SIM卡地区信息
    CCAreaDataModel *model = [self fetchSIMCardArea];
    if (model) {
        if (handler) {
            handler(model, MTAreaDataSIMCardSource, YES);
        }
    } else {
        //  取系统地区
        model = [self fetchSystemArea];
        if (handler) {
            handler(model, MTAreaDataSystemSource, YES);
        }
    }
}

+ (void)fetchAreaWithDataSource:(MTAreaDataSource)dataSource
              completionHandler:(MTAreaCompletionHandler)handler {
    
    NSAssert(dataSource==MTAreaDataSystemSource || dataSource==MTAreaDataSIMCardSource,
             @"dataSource只能传入MTAreaDataSystemSource或者MTAreaDataSIMCardSource");
    
    CCAreaDataModel *model = nil;
    switch (dataSource) {
        case MTAreaDataSystemSource:
            model = [self fetchSystemArea];
            break;
        case MTAreaDataSIMCardSource:
            model = [self fetchSIMCardArea];
            break;
        default:
            break;
    }
    

    if (handler) {
        handler(model, dataSource, model != nil);
    }
}

@end
