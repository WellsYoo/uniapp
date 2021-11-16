//
//  MTAppManager.m
//  MTAppCommunication
//
//  Created by JoyChiang on 13-3-13.
//  Copyright (c) 2013年 Meitu. All rights reserved.
//

#import "CGJAppManager.h"
#import "CGJAppRequest.h"
#import "EGAppClient.h"

#define kImagePasteboardType @"kImagePasteboard"

/******************
 *  美图秀秀
 ******************/
NSString *const MTXXScheme                = @"mtxx";                    // 美图秀秀urlScheme
NSString *const MTXXStoreId               = @"416048305";               // 美图秀秀appId
// 美化
NSString *const kMTXXMeiHua               = @"meihua";                  // 美化
NSString *const kMTXXMeiHua_Border        = @"meihua.border";           // 美化-边框
NSString *const kMTXXMeiHua_Mosaic        = @"meihua.mosaic";           // 美化-马赛克
NSString *const kMTXXMeiHua_Text          = @"meihua.text";             // 美化-文字
// 美容
NSString *const kMTXXMeiRong              = @"meirong";                 // 美容
// 贴纸
NSString *const kMTXXMeiHua_Sticker       = @"meihua.sticker";          // 贴纸

/******************
 *  美颜相机
 ******************/
NSString *const MYXJScheme                = @"myxjpush";                // 美颜相机urlScheme
NSString *const MYXJStoreId               = @"592331499";               // 美颜相机appId
NSString *const kMYXJ_GJMY                = @"myxj.gjmy_new";           // 美颜相机-高级美颜（带图）
NSString *const kMYXJ_Beayty              = @"beautify";                //打开美颜相机高级美颜（不带图）
NSString *const kMYXJ_Camera              = @"camera";                  //跳转到自拍
NSString *const kMYXJ_Photosticker        = @"photosticker";            //跳转大头贴贩卖机
NSString *const kMYXJ_Feedback            = @"feedback";                //feedback
NSString *const kMYXJ_Webview             = @"webview";                 //跳转新的 WebView, 参数:url(必选，缺省的话直接回调）
NSString *const kMYXJ_Disney              = @"disney";                  //跳转指定的萌拍素材,参数:materialID(素材ID，可选）
NSString *const kMYXJ_Beautymaster        = @"beautymaster";            //跳转颜值管家

/******************
 *  海报工厂
 ******************/
NSString *const HBGCScheme                = @"hbgc";                    // 海报工厂urlScheme
NSString *const HBGCStoreId               = @"875654777";               // 海报工厂appId
NSString *const kHBGC_ZZHB                = @"hbgc.zzhb";               // 海报工厂-制作海报

/******************
 *  美拍
 ******************/
NSString *const MeiPaiScheme              = @"meipai";                  // 美拍urlScheme
NSString *const MeiPaiStoreId             = @"606099659";               // 美拍appId

/******************
 *  潮自拍
 ******************/
NSString *const SelfieCityScheme          = @"selfiecity";              // 潮自拍urlScheme
NSString *const SelfieCityStoreId         = @"1014277964";              // 潮自拍appId
NSString *const kSelfieCityCamera         = @"selfiecity.camera";       // 潮自拍相机实时滤镜页
NSString *const kSelfieCity_AlbumFilter   = @"selfiecity.albumFilter";  // 潮自拍相册进入特效页
NSString *const kSelfieCity_GridPhoto     = @"selfiecity.gridphoto";    // 潮自拍多格拍照

/******************
 *  美妆
 ******************/
NSString *const MZXJScheme                = @"mzxj";                    // 美妆相机urlScheme
NSString *const MZXJStoreId               = @"973337925";               // 美妆相机appId
NSString *const kMZXJZhuangRong           = @"mzxj.makeup";             // 美妆-妆容
NSString *const kMZXJSeniorMakeup         = @"mzxj.seniormakeup";       // 美妆-高级美妆

/******************
 *  AirBrush
 ******************/
NSString *const AirBrushScheme            = @"airbrush";                // AirBrush urlScheme
NSString *const AirBrushStoreId           = @"998411110";               // AirBrush appId
NSString *const kAirBrushBeautyCenter     = @"beautycenter";            // AirBrush 编辑主页

/******************
 *  美图贴贴
 ******************/
NSString *const MTTTScheme                = @"mttt";                    // 美图贴贴urlScheme
NSString *const MTTTStoreId               = @"477678113";               // 美图贴贴appId
// 单张拼图
NSString *const kMTTT_DZPT                = @"mttt.dzpt";               // 美图贴贴-单张拼图

//////////////////////////////////////////////////////////////////////////////////////////////////

NSString *const MTErrorDomain            = @"com.meitu.manager.error";
NSString *const MTClientErrorDomain      = @"com.meitu.client.error";

// x-callback-url strings
static NSString *const kXMTPrefix           = @"x-";
//static NSString *const kXMTHost             = @"x-callback-url";
static NSString *const kXMTSource           = @"x-source";
static NSString *const kXMTSourceBundleId   = @"x-source-bundleId";
static NSString *const kXMTSourceAppVersion = @"x-source-appVersion";
static NSString *const kXMTScheme           = @"x-scheme";
static NSString *const kXMTSuccess          = @"x-success";
static NSString *const kXMTError            = @"x-error";
static NSString *const kXMTCancel           = @"x-cancel";
static NSString *const kXMTErrorCode        = @"error-Code";
static NSString *const kXMTErrorMessage     = @"errorMessage";

// MT strings
static NSString *const kMTPrefix            = @"MTAPP";
static NSString *const kXMTCustomParams     = @"MTCustomParams";
static NSString *const kMTResponse          = @"MTRequestResponse";
static NSString *const kMTRequest           = @"MTRequestID";
static NSString *const kMTResponseType      = @"MTResponseType";
static NSString *const kMTErrorDomain       = @"errorDomain";
static NSString *const kMTPasteboard        = @"MTPasteboard";
static NSString *const kMTActions           = @"MTExternalActions";
static NSString *const kMTAppCommVersion    = @"MTAppCommVersion";

typedef NS_ENUM(NSUInteger, MTResponseType) {
    MTResponseTypeSuccess,
    MTResponseTypeFailure,
    MTResponseTypeCancel
};

//////////////////////////////////////////////////////////////////////////////////////////////////

@implementation NSDictionary (Extensions)
- (NSString *)mtam_URLQueryString {
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in [self allKeys]) {
        if ([string length]) {
            [string appendString:@"&"];
        }
        CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)[[self objectForKey:key] description],
                                                                      NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                      kCFStringEncodingUTF8);
        [string appendFormat:@"%@=%@", key, escaped];
        CFRelease(escaped);
    }
    return string;
}
@end

@implementation NSString (Extensions)

- (NSDictionary *)parseURLParams {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    [pairs enumerateObjectsUsingBlock:^(NSString *pair, NSUInteger idx, BOOL *stop) {
        NSArray *comps = [pair componentsSeparatedByString:@"="];
        if ([comps count] == 2) {
            [result setObject:[comps[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:comps[0]];
        }
    }];
    
    return result;
}

- (NSString *)stringByAppendingURLParams:(NSDictionary *)params {
    NSMutableString *result = [NSMutableString string];
    [result appendString:self];
    
    if ([result rangeOfString:@"?"].location != NSNotFound) {
        if (![result hasSuffix:@"&"])
        [result appendString:@"&"];
    } else {
        [result appendString:@"?"];
    }
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *escapedObj = obj;
        if ([obj isKindOfClass:[NSString class]]) {
            escapedObj = [obj mtam_URLEncodedString];
        }
        [result appendFormat:@"%@=%@&", key, escapedObj];
    }];
    
    return result;
}

- (BOOL)isGreaterThanOrEqualTo:(NSString *)v{
    return [self compare:v options:NSNumericSearch] != NSOrderedAscending;
}

- (NSString *)mtam_URLEncodedString {
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8);
    return result;
}

- (NSString*)mtam_URLDecodedString {
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)self,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8);
    return result;
}

@end

//////////////////////////////////////////////////////////////////////////////////////////

@implementation CGJAppManager {
    NSMutableDictionary *_sessions; /**< 存储应用程序请求 */
    NSMutableDictionary *_actions;  /**< 存储应用程序事件 */
    NSMutableDictionary *_xActions;
}

+ (CGJAppManager *)sharedManager {
    __strong static CGJAppManager *sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[CGJAppManager alloc] init];
    });
    
    return sharedObj;
}

- (instancetype)init {
    if (self = [super init]) {
        _sessions = [[NSMutableDictionary alloc] init];
        _actions  = [[NSMutableDictionary alloc] init];
        _xActions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/**
 *	@brief	处理URL解析和调用不同的处理程序和委托方法，需要在application:openURL:sourceApplication:annotation:中调用。
 *
 *	@param 	url 	url地址
 *
 *	@return	成功返回YES，失败返回NO。
 */
- (BOOL)handleOpenURL:(NSURL *)url {
    if (![url.scheme isEqualToString:self.callbackURLScheme]) {
        return NO;
    }
    
    // 如果url是回调地址(x-callback-url)，响应解析该地址获取外部程序返回的信息
    NSString *action = [url host];
    if ([action isEqualToString:@"x-callback-url"]) {  //兼容旧版本，取path中第一个为action
        action = [[url path] substringFromIndex:1];
    }
    
    NSDictionary *parameters = [url.query parseURLParams];
    NSDictionary *actionParamters = [self removeProtocolParamsFromDictionary:parameters];
    
    // 检查是否是该程序上一次所调用外部程序回传的事件
    if ([action isEqualToString:kMTResponse]) {
        NSString *requestID = parameters[kMTRequest];
        CGJAppRequest *request = _sessions[requestID];
        if (request) {
            // 获取该平台目前所支持的所有api
            NSString *xSource = parameters[kXMTScheme];
            if (xSource) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                _xActions[xSource] = pasteboard.strings;
            }
            
            // 判断是否操作成功
            MTResponseType responseType = [parameters[kMTResponseType] intValue];
            switch (responseType) {
                    case MTResponseTypeSuccess:
                    if (request.successCalback) {
                        // 获取剪切板图片数据
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        NSData *imageData = [pasteboard dataForPasteboardType:kImagePasteboardType];
                        NSDictionary *inputParams = [[parameters[kXMTCustomParams] mtam_URLDecodedString] parseURLParams];
                        EGAppResponseMessage *message = [[EGAppResponseMessage alloc] init];
                        message.responseData = [inputParams copy];
                        if (imageData) {
                            UIImage *image = [UIImage imageWithData:imageData];
                            message.image = image;
                        }
                        else {
                            message.image = pasteboard.image;
                        }
                        request.successCalback(message);
                    }
                    break;
                    
                    case MTResponseTypeFailure:
                    if (request.errorCalback) {
                        NSInteger errorCode = [request.client NSErrorCodeForXMTErrorCode:parameters[kXMTErrorCode]];
                        NSString *errorDomain = parameters[kMTErrorDomain] ? parameters[kMTErrorDomain] : MTClientErrorDomain;
                        NSError *error = [NSError errorWithDomain:errorDomain
                                                             code:errorCode
                                                         userInfo:@{NSLocalizedDescriptionKey: parameters[kXMTErrorMessage]}];
                        
                        request.errorCalback(error);
                    }
                    break;
                    
                    case MTResponseTypeCancel:
                    if (request.successCalback) {
                        request.successCalback(nil);
                    }
                    break;
                    
                default:
                    [_sessions removeObjectForKey:requestID];
                    return NO;
                    
                    break;
            }
            
            [_sessions removeObjectForKey:requestID];
            
            return YES;
        }
        
        return NO;
    }
    
    // 响应外部程序发起的事件
    if (_actions[action] || [self.delegate appCommunicationSupportsAction:action]) {
        if (![actionParamters[kMTAppCommVersion] isGreaterThanOrEqualTo:@"2.0"]) {
            if (parameters[kXMTError]) {
                NSError *error = [NSError errorWithDomain:MTErrorDomain
                                                     code:MTErrorNotSupportedVersion
                                                 userInfo:@{NSLocalizedDescriptionKey: @"NotSupportedVersion"}];
                NSDictionary *errorParams = @{ kXMTErrorCode: @([error code]),
                                               kXMTErrorMessage: [error localizedDescription],
                                               kMTErrorDomain: [error domain]
                                               };
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[parameters[kXMTError] stringByAppendingURLParams:errorParams]]];
            }
        } else {
            MTAppSuccessBlock success = ^(EGAppResponseMessage *responseMessage, BOOL cancelled) {
                if (cancelled) {
                    if (parameters[kXMTCancel]) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:parameters[kXMTCancel]]];
                    }
                } else if (parameters[kXMTSuccess]) {
                    // 粘贴图片数据
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    [pasteboard setPersistent:YES];
                    [pasteboard setValue:_actions forPasteboardType:[self localizedAppName]];
                    if (responseMessage.image) {
                        [pasteboard setImage:responseMessage.image];
                        NSData *imageData = UIImageJPEGRepresentation(responseMessage.image, 1.f);
                        [pasteboard setData:imageData forPasteboardType:kImagePasteboardType];
                    }
                    NSString *finalUrl = parameters[kXMTSuccess];
                    if (responseMessage.responseData && responseMessage.responseData.count > 0) {
                        
                        NSMutableDictionary *responseMessageData = [[NSMutableDictionary alloc] init];
                        [responseMessageData addEntriesFromDictionary:responseMessage.responseData];
                        [responseMessageData setValue:[self appVersion] forKey:kXMTSourceAppVersion];
                        [responseMessageData setValue:[self bundleId] forKey:kXMTSourceBundleId];
                        [responseMessageData setValue:[self localizedAppName] forKey:kXMTSource];
                        
                        NSString *paramString = [[responseMessageData mtam_URLQueryString] mtam_URLEncodedString];
                        
                        if (paramString) {
                            finalUrl = [finalUrl stringByAppendingURLParams:@{kXMTCustomParams:paramString}];
                        }
                    }
                    //
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:finalUrl]];
                }
            };
            
            MTAppFailureBlock failure = ^(NSError *error) {
                if (parameters[kXMTError]) {
                    NSDictionary *errorParams = @{ kXMTErrorCode: @([error code]),
                                                   kXMTErrorMessage: [error localizedDescription],
                                                   kMTErrorDomain: [error domain]
                                                   };
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[parameters[kXMTError] stringByAppendingURLParams:errorParams]]];
                }
            };
            
            // 优先使用block方式响应处理，之后再使用delegate方式
            if (_actions[action]) {
                // 获取剪切板图片数据
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                MTAppActionHandlerBlock actionHandler = _actions[action];
                NSDictionary *inputParams = [[parameters[kXMTCustomParams] mtam_URLDecodedString] parseURLParams];
                NSData *imageData = [pasteboard dataForPasteboardType:kImagePasteboardType];
                EGAppRequestMessage *requestMessage = [[EGAppRequestMessage alloc] init];
                requestMessage.requestData = inputParams;
                requestMessage.image = pasteboard.image;
                if (imageData) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    requestMessage.image = image;
                    actionHandler(requestMessage, success, failure);
                }
                else {
                    actionHandler(requestMessage, success, failure);
                }
                return YES;
            } else if ([self.delegate appCommunicationSupportsAction:action]) {
                [self.delegate handleAction:action
                                 parameters:actionParamters
                                  onSuccess:success
                                  onFailure:failure];
                
                return YES;
            }
        }
    } else {
        // 程序内部未实现delegate或没有响应该action的方法
        if (parameters[kXMTError]) {
            // 发送该平台所支持的api接口
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setPersistent:YES];
            [pasteboard setStrings:[_actions allKeys]];
            
            NSDictionary *errorParams = @{ kXMTErrorCode: @(MTErrorNotSupportedAction),
                                           kXMTErrorMessage: [NSString stringWithFormat:NSLocalizedString(@"'%@' is not an x-callback-url action supported by %@", nil), action, [self localizedAppName]],
                                           kMTErrorDomain: MTErrorDomain,
                                           kXMTScheme: self.callbackURLScheme
                                           };
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[parameters[kXMTError] stringByAppendingURLParams:errorParams]]];
            
            return YES;
        }
    }
    
    return NO;
}

/**
 *	@brief	发送请求到外部程序
 *
 *	@param 	request 	请求对象
 */
- (void)sendRequest:(CGJAppRequest *)request {
    // 应用程序未安装
    if (![request.client isAppInstalled]) {
        if (request.errorCalback) {
            NSError *error = [NSError errorWithDomain:MTErrorDomain
                                                 code:MTErrorAppNotInstalled
                                             userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:NSLocalizedString(@"App with scheme '%@' is not installed in this device", nil), request.client.URLScheme]}];
            request.errorCalback(error);
        }
        return;
    }
    
    // 判断该请求所对应平台是否支持该事件
    NSArray *actions = _xActions[request.client.URLScheme];
    if (actions) {
        if (actions.count) {
            __block BOOL existAction = NO;
            [actions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isEqualToString:request.action]) {
                    existAction = YES;
                    *stop = YES;
                }
            }];
            if (!existAction) {
                if (request.errorCalback) {
                    NSError *error = [NSError errorWithDomain:MTErrorDomain
                                                         code:MTErrorNotSupportedAction
                                                     userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:NSLocalizedString(@"App with scheme '%@' is not supported this action : %@", nil), request.client.URLScheme, request.action]}];
                    request.errorCalback(error);
                }
                return;
            }
        } else {
            if (request.errorCalback) {
                NSError *error = [NSError errorWithDomain:MTErrorDomain
                                                     code:MTErrorNotSupportedAction
                                                 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:NSLocalizedString(@"App with scheme '%@' is not supported this action : %@", nil), request.client.URLScheme, request.action]}];
                request.errorCalback(error);
            }
            return;
        }
    }
    
    // 配置即将调用的外部程序url及参数
    NSString *finalUrl = [NSString stringWithFormat:@"%@://%@?", request.client.URLScheme, request.action];
    finalUrl = [finalUrl stringByAppendingURLParams:@{kXMTSource:[self localizedAppName]}];// 拼接应用程序名称
    finalUrl = [finalUrl stringByAppendingURLParams:@{kMTAppCommVersion:MTAppCommunicationVersion}];
    if (request.requestMessage.requestData && request.requestMessage.requestData.count > 0) {
        NSMutableDictionary *requestData = [[NSMutableDictionary alloc] init];
        [requestData addEntriesFromDictionary:request.requestMessage.requestData];
        [requestData setValue:[self appVersion] forKey:kXMTSourceAppVersion];
        [requestData setValue:[self bundleId] forKey:kXMTSourceBundleId];
        [requestData setValue:[self localizedAppName] forKey:kXMTSource];
        NSString *paramString = [[requestData mtam_URLQueryString] mtam_URLEncodedString];
        if (paramString) {
            finalUrl = [finalUrl stringByAppendingURLParams:@{kXMTCustomParams:paramString}];
        }
    }
    
    // 配置回调url地址及参数
    if (self.callbackURLScheme) {
        NSString *callbackUrl = [NSString stringWithFormat:@"%@://%@?", self.callbackURLScheme, kMTResponse];
        callbackUrl = [callbackUrl stringByAppendingURLParams:@{kMTRequest:request.requestID}];
        
        NSMutableDictionary *callbackUrlParams = [NSMutableDictionary dictionary];
        if (request.successCalback) {
            callbackUrlParams[kXMTSuccess] = [callbackUrl stringByAppendingURLParams:@{kMTResponseType:@(MTResponseTypeSuccess)}];
            callbackUrlParams[kXMTCancel] = [callbackUrl stringByAppendingURLParams:@{kMTResponseType:@(MTResponseTypeCancel)}];
        }
        
        if (request.errorCalback) {
            callbackUrlParams[kXMTError] = [callbackUrl stringByAppendingURLParams:@{kMTResponseType:@(MTResponseTypeFailure)}];
        }
        
        finalUrl = [finalUrl stringByAppendingURLParams:callbackUrlParams];
    } else if (request.successCalback || request.errorCalback) {
        // 未定义程序回调URL Scheme
    }
    
    _sessions[request.requestID] = request;
    
    // 粘贴图片数据
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setPersistent:YES];
    if (request.requestMessage.image) {
        [pasteboard setImage:request.requestMessage.image];
        NSData *imageData = UIImageJPEGRepresentation(request.requestMessage.image, 1.f);
        [pasteboard setData:imageData forPasteboardType:kImagePasteboardType];
    }
    
    BOOL isOpenSuccess = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:finalUrl]];
    
    //打开不成功
    if (!isOpenSuccess) {
        NSError *error = [NSError errorWithDomain:MTErrorDomain
                                             code:MTErrorNotSupportedAction
                                         userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:NSLocalizedString(@"App with scheme '%@' is not supported this action : %@", nil), request.client.URLScheme, request.action]}];
        request.errorCalback(error);
    }
}

/**
 *	@brief	响应action事件
 *
 *	@param 	action 	事件名称
 *	@param 	handler 响应回调处理
 */
- (void)handleAction:(NSString *)action withBlock:(MTAppActionHandlerBlock)handler {
    _actions[action] = [handler copy];
}

- (NSDictionary *)removeProtocolParamsFromDictionary:(NSDictionary *)dictionary {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    // 移除所有回调参数及响应参数值
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![key hasPrefix:kXMTPrefix] && ![key hasPrefix:kMTPrefix]) {
            [result setObject:obj forKey:key];
        }
    }];
    
    if (dictionary[kXMTSource]) {
        result[kXMTSource] = dictionary[kXMTSource];
    }
    
    return result;
}

/**
 *	@brief	通过应用程序Bundle获取App名称
 *
 *	@return	返回App名称
 */
- (NSString *)localizedAppName {
    NSString *appName = [[NSBundle mainBundle] localizedInfoDictionary][@"CFBundleDisplayName"];
    if (!appName) {
        appName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
    }
    
    return appName ? : @"";
}

- (NSString *)bundleId {
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    return bundleId ?:@"";
}

- (NSString *)appVersion {
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return appVersion ?:@"";
}
///////////////////////////////////////////////////////////////////////////////////////////////////

/**
 *	@brief	是否支持程序内部打开AppStore
 *
 *	@return	支持返回YES，否则返回NO
 */
+ (BOOL)isSupportSKStoreProductViewController
{
    Class storeProductViewControllerClass = NSClassFromString(@"SKStoreProductViewController");
    if (storeProductViewControllerClass != nil) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *	@brief	根据addId打开相应的app
 *
 *	@param 	appId 	程序id
 */
+ (void)openAppWithId:(NSString *)appId viewController:(UIViewController *)viewController {
    [CGJAppManager openAppWithId:appId viewController:viewController delegate:nil];
}

+ (void)openAppWithId:(NSString *)appId
       viewController:(UIViewController *)viewController
             delegate:(id<SKStoreProductViewControllerDelegate>)delegate
{
    if ([[self class] isSupportSKStoreProductViewController] && viewController) {
        SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
        [storeProductViewController setDelegate:delegate];
        
        [viewController presentViewController:storeProductViewController animated:YES completion:nil];
        
        [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:appId} completionBlock:^(BOOL result, NSError *error) {
            if (error) {
                NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", appId];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }
        }];
    } else {
        NSString *urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", appId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

/**
 *	@brief	隐藏当前有弹出的所有UIAlertView和UIActionSheet
 *
 *	@param 	subviews 	子视图集合
 */
+ (void)hideAllAlertView:(NSArray *)subviews
{
    Class AVClass = [UIAlertView class];
    Class ASClass = [UIActionSheet class];
    for (UIView *subview in subviews){
        if ([subview isKindOfClass:AVClass]) {
            [(UIAlertView *)subview dismissWithClickedButtonIndex:[(UIAlertView *)subview cancelButtonIndex] animated:NO];
        } else if ([subview isKindOfClass:ASClass]) {
            [(UIActionSheet *)subview dismissWithClickedButtonIndex:[(UIActionSheet *)subview cancelButtonIndex] animated:NO];
        } else {
            [[self class] hideAllAlertView:subview.subviews];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////

@end
