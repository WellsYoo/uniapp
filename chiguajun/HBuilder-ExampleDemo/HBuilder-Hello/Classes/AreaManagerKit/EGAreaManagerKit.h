//
//  MTAreaManagerKit.h
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/18.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CGJAreaDataModel.h"
#import "MTAreaManagerSetting.h"

/**
 *	@brief 地区数据来源
 */
typedef NS_ENUM(NSUInteger, MTAreaDataSource) {
    MTAreaDataUnknownSource = 0,    /**< 未知来源 */
    MTAreaDataSystemSource,         /**< 数据来自系统 */
    MTAreaDataSIMCardSource,        /**< 数据来自SIM卡 */
    MTAreaDataServerSource          /**< 数据来自服务端 */
};

/**
 *	@brief 完成回调
 *
 *	@param areaModel	地区信息
 *	@param dataSource	数据来源
 *	@param isSuccess	是否成功获取
 */
typedef void(^MTAreaCompletionHandler)(CGJAreaDataModel *areaModel, MTAreaDataSource dataSource, BOOL isSuccess);

@interface EGAreaManagerKit : NSObject

/**
 *	@brief  请求服务器地区信息,没有上传渠道号默认AppStore,默认上传sim卡国家信息
 *
 *	@param appId	应用id
 *  (编号查询 http://wiki.meitu.com/APP%E8%BD%AF%E4%BB%B6%E7%BC%96%E5%8F%B7%E5%88%97%E8%A1%A8 )
 *	@param language	语言
 *  (语言标准 http://wiki.meitu.com/%E5%90%84%E8%AF%AD%E8%A8%80%E7%AE%80%E7%A7%B0%E6%A0%87%E5%87%86 )
 *	@param isTest	是否测试环境
 *  @param handler  完成回调
 */
+ (void)requestAreaWithAppId:(NSString *)appId
                    language:(NSString *)language
                      isTest:(BOOL)isTest
           completionHandler:(MTAreaCompletionHandler)handler;

/**
 *	@brief  请求服务器地区信息,默认上传sim卡国家信息
 *
 *	@param appId	应用id
 *  (编号查询 http://wiki.meitu.com/APP%E8%BD%AF%E4%BB%B6%E7%BC%96%E5%8F%B7%E5%88%97%E8%A1%A8 )
 *	@param language	语言
 *  (语言标准 http://wiki.meitu.com/%E5%90%84%E8%AF%AD%E8%A8%80%E7%AE%80%E7%A7%B0%E6%A0%87%E5%87%86 )
 *  @param channel  渠道号
 *	@param isTest	是否测试环境
 *  @param handler  完成回调
 */
+ (void)requestAreaWithAppId:(NSString *)appId
                    language:(NSString *)language
                     channel:(NSString *)channel
                      isTest:(BOOL)isTest
           completionHandler:(MTAreaCompletionHandler)handler;

/**
 *	@brief  请求服务器地区信息
 *
 *	@param appId	应用id
 *  (编号查询 http://wiki.meitu.com/APP%E8%BD%AF%E4%BB%B6%E7%BC%96%E5%8F%B7%E5%88%97%E8%A1%A8 )
 *	@param language	语言
 *  (语言标准 http://wiki.meitu.com/%E5%90%84%E8%AF%AD%E8%A8%80%E7%AE%80%E7%A7%B0%E6%A0%87%E5%87%86 )
 *  @param channel  渠道号
 *	@param isTest	是否测试环境
 *  @param uploadSimCardInfo 是否上传SIM卡国家信息
 *  @param handler  完成回调
 */
+ (void)requestAreaWithAppId:(NSString *)appId
                    language:(NSString *)language
                     channel:(NSString *)channel
                      isTest:(BOOL)isTest
           uploadSimCardInfo:(BOOL)uploadSimCardInfo
           completionHandler:(MTAreaCompletionHandler)handler;

/**
 *	@brief 获取本地地区信息，优先级  SIM卡 > 系统地区
 *
 *	@param handler	完成回调
 */
+ (void)fetchLocalAreaWithCompletionHandler:(MTAreaCompletionHandler)handler;

/**
 *	@brief 根据类型获取地区信息
 *
 *	@param dataSource	只能传入MTAreaDataSystemSource或者MTAreaDataSIMCardSource
 *	@param handler		完成回调
 */
+ (void)fetchAreaWithDataSource:(MTAreaDataSource)dataSource
              completionHandler:(MTAreaCompletionHandler)handler;

@end
