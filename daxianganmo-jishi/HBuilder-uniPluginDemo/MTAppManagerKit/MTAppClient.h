//
//  MTAppClient.h
//  MTAppCommunication
//
//  Created by JoyChiang on 13-3-13.
//  Copyright (c) 2013年 Meitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTAppManager.h"
#import <Foundation/Foundation.h>
#import "MTAppMessage.h"

NS_ASSUME_NONNULL_BEGIN
@interface MTAppClient : NSObject

@property(nonatomic, copy) NSString *URLScheme;     /**< 应用程序URL Scheme */
@property(nonatomic, strong) MTAppManager *manager; /**< 应用程序管理器 */


// 初始化方法
+ (instancetype)client;
+ (instancetype)clientWithURLScheme:(NSString *)scheme;
- (instancetype)initWithURLScheme:(NSString *)scheme;

- (NSInteger)NSErrorCodeForXMTErrorCode:(NSString *)code;

/**
 *	@brief	应用程序是否安装
 *
 *	@return	已安装返回YES，否则NO
 */
- (BOOL)isAppInstalled;

/**
 *	@brief	在AppStore打开该应用
 *
 *	@return	可打开该应用返回YES，反则NO
 */
- (BOOL)openAppInAppStore;

/**
 *  @brief 判断当前客户端版本是否支持OpenApi
 *
 *  @return 支持返回YES，不支持返回NO
 */
- (BOOL)isSupportOpenApi;

/** @brief 判断客户端是否支持此功能
 *
 *
 *  @param action 跳转的动作模块的协议
 *
 *  @return YES 支持  NO 不支持
 */
- (BOOL)isSupportPerformAction:(NSString *)action;

/**
 是否支持打开URL链接

 @param urlString URL字符串
 @return YES 支持  NO 不支持
 */
- (BOOL)isSupportPerformURLString:(NSString *)urlString;

/**
 通过URLString打开应用

 @param urlString 打开的scheme url字符串
 @param requestMessage 携带的参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)performWithURLString:(NSString *)urlString
              requestMessage:(MTAppRequestMessage * _Nullable)requestMessage
                   onSuccess:(void(^)(MTAppResponseMessage *responseMessage))success
                   onFailure:(void(^)(NSError *failure))failure;

/**
 *	@brief	启动并发送请求到外部程序
 *
 *	@param 	action 	请求名称
 *  @param  success 成功回调
 *  @param  failure 失败回调
 */
- (void)performAction:(NSString *)action
            onSuccess:(void(^)(MTAppResponseMessage *responseMessage))success
            onFailure:(void(^)(NSError *failure))failure;

/**
 *	@brief	启动并发送请求到外部程序
 *
 *	@param 	action 	请求名称
 *  @param  success 成功回调
 *  @param  failure 失败回调
 *	@param 	requestMessage 其中 图片  不能为nil，否则直接执行failure
 */
- (void)performAction:(NSString *)action
       requestMessage:(MTAppRequestMessage *)requestMessage
            onSuccess:(void(^)(MTAppResponseMessage *responseMessage))success
            onFailure:(void(^)(NSError *failure))failure;

NS_ASSUME_NONNULL_END

@end
