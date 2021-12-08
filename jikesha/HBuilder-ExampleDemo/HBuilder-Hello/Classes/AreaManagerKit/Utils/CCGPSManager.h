//
//  MTGPSManager.h
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/18.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTGPSDataModel.h"

typedef void(^MTGPSCompletionHandler)(MTGPSDataModel *gpsModel, BOOL isSuccess);

@interface CCGPSManager : NSObject

/**
 *	@brief  请求gps位置信息
 *
 *	@param handler	完成回调
 */
+ (void)requestGPSWithCompletionHandler:(MTGPSCompletionHandler)handler;

@end
