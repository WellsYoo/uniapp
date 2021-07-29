//
//  UIDevice+MTAreaManager.h
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/22.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (MTAreaManager)

/**
 *	@brief  设备标识符
 */
+ (NSString *)areaManager_IDFA;

/**
 *	@brief  机型信息
 */
- (NSString *)areaManager_devicePlatform;

@end
