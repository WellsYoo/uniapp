//
//  MTAppClient.m
//  MTAppCommunication
//
//  Created by JoyChiang on 13-3-13.
//  Copyright (c) 2013年 Meitu. All rights reserved.
//

#import "EGAppClient.h"
#import "CGJAppRequest.h"

@implementation NSString (MTAppURL)

- (NSDictionary *)mtapp_parseURLParams {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    [pairs enumerateObjectsUsingBlock:^(NSString *pair, NSUInteger idx, BOOL *stop) {
        if (pair.length) {
            NSArray *comps = [pair componentsSeparatedByString:@"="];
            if ([comps count] == 1) {
                [result setObject:[NSNull null] forKey:comps[0]];
            } else if ([comps count] > 1) {
                [result setObject:[comps[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:comps[0]];
            }
        }
    }];
    
    return result;
}
@end

@implementation EGAppClient

+ (instancetype)client {
    return [[self alloc] init];
}

+ (instancetype)clientWithURLScheme:(NSString *)scheme {
    return [[self alloc] initWithURLScheme:scheme];
}

- (instancetype)initWithURLScheme:(NSString *)scheme {
    if (self = [super init]) {
        self.URLScheme = scheme;
    }
    return self;
}

- (NSInteger)NSErrorCodeForXMTErrorCode:(NSString *)code {
    return [code integerValue];
}

/**
 *	@brief	应用程序是否安装
 *
 *	@return	已安装返回YES，否则NO
 */
- (BOOL)isAppInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://Test", self.URLScheme]]];
}

/**
 *	@brief	在AppStore打开该应用
 *
 *	@return	可打开该应用返回YES，反则NO
 */
- (BOOL)openAppInAppStore {
    NSString *appId = nil;
    if ([self.URLScheme isEqualToString:MTXXScheme]) {
        appId = MTXXStoreId;
    } else if ([self.URLScheme isEqualToString:MTTTScheme]) {
        appId = MTTTStoreId;
    } else if ([self.URLScheme isEqualToString:MYXJScheme]) {
        appId = MYXJStoreId;
    } else if ([self.URLScheme isEqualToString:MeiPaiScheme]) {
        appId = MeiPaiStoreId;
    }else if ([self.URLScheme isEqualToString:AirBrushScheme]) {
        appId = AirBrushStoreId;
    }
    
    if (appId != nil) {
        NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", appId];
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    
    return NO;
}

/**
 *  @brief 判断当前客户端版本是否支持OpenApi
 *
 *  @return 支持返回YES，不支持返回NO
 */
- (BOOL)isSupportOpenApi {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@.open://Test", self.URLScheme]]];
}

- (BOOL)isSupportPerformAction:(NSString *)action {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", action]]];
}

- (BOOL)isSupportPerformURLString:(NSString *)urlString {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
}

- (void)performWithURLString:(NSString *)urlString
              requestMessage:(EGAppRequestMessage * _Nullable)requestMessage
                   onSuccess:(void(^)(EGAppResponseMessage *responseMessage))success
                   onFailure:(void(^)(NSError *failure))failure {
    NSParameterAssert(urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    if (url && [self isSupportPerformURLString:urlString]) {
        
        CGJAppRequest *request = [[CGJAppRequest alloc] init];
        NSString *action = [url host];
        self.URLScheme = [url scheme];
        NSMutableDictionary *requestData = [[NSMutableDictionary alloc] init];
        NSDictionary *tempRequestData = [[url query] mtapp_parseURLParams];
        
        if (tempRequestData) {
            [requestData addEntriesFromDictionary:tempRequestData];
        }
        if (requestMessage.requestData) {
            [requestData addEntriesFromDictionary:requestMessage.requestData];
        }
        EGAppRequestMessage *message = [[EGAppRequestMessage alloc] initWithImage:requestMessage.image requestData:requestData];
        request.client          = self;
        request.requestMessage  = message;
        request.action          = action;
        request.errorCalback    = failure;
        request.successCalback  = success;
        
        if (self.manager) {
            [self.manager sendRequest:request];
        } else {
            [[CGJAppManager sharedManager] sendRequest:request];
        }
    } else {
        if (failure) {
            NSError *error = [NSError errorWithDomain:@"urlString unSupportPerform" code:-1 userInfo:@{@"errorCode":@(-1),@"errorDomain":@"urlString unSupportPerform"}];
            failure(error);
        }
    }
}

/**
 *	@brief	启动并发送请求到外部程序
 *
 *	@param 	action 	请求名称
 *  @param  success 成功回调
 *  @param  failure 失败回调
 */
- (void)performAction:(NSString *)action
       requestMessage:(EGAppRequestMessage *)requestMessage
            onSuccess:(void(^)(EGAppResponseMessage *responseMessage))success
            onFailure:(void(^)(NSError *failure))failure {
    CGJAppRequest *request = [[CGJAppRequest alloc] init];
    request.client          = self;
    request.requestMessage  = requestMessage;
    request.action          = action;
    request.errorCalback    = failure;
    request.successCalback  = success;
    
    if (self.manager) {
        [self.manager sendRequest:request];
    } else {
        [[CGJAppManager sharedManager] sendRequest:request];
    }
}

/**
 *	@brief	启动并发送请求到外部程序
 *
 *	@param 	action 	请求名称
 *  @param  success 成功回调
 *  @param  failure 失败回调
 */
- (void)performAction:(NSString *)action
            onSuccess:(void(^)(EGAppResponseMessage *responseMessage))success
            onFailure:(void(^)(NSError *failure))failure {
    
    CGJAppRequest *request = [[CGJAppRequest alloc] init];
    request.client          = self;
    request.action          = action;
    request.errorCalback    = failure;
    request.successCalback  = success;
    
    if (self.manager) {
        [self.manager sendRequest:request];
    } else {
        [[CGJAppManager sharedManager] sendRequest:request];
    }
}

- (void)dealloc {
}

@end
