//
//  MTAreaManagerSetting.h
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/19.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTGPSDataModel.h"

@interface MTAreaManagerSetting : NSObject

@property (nonatomic, copy) NSString *appId;                    /**< 应用id */
@property (nonatomic, copy) NSString *language;                 /**< app语言 */
@property (nonatomic, copy) NSNumber *isTest;                   /**< 是否测试环境 */
@property (nonatomic, copy) NSString *serverUrl;                /**< 服务器地址 */
@property (nonatomic, copy) NSString *deviceToken;              /**< 推送token，默认nil */
@property (nonatomic, copy) NSString *channel;                  /**< 渠道号 */
@property (nonatomic, copy) NSString *simCardCountryCode;       /**< SIM卡国家 */

@property (nonatomic, assign) NSTimeInterval timeoutInterval;   /**< 超时时间，默认30s */
@property (nonatomic, assign) BOOL needGPSLocation;             /**< 是否需要GPS定位，默认YES */

@property (nonatomic, strong) MTGPSDataModel *gpsDataModel;     /**< GPS数据 */

+ (instancetype)shared;

@end
