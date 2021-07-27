//
//  MTAreaRequestBasic.h
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/19.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTAreaRequestBasic : NSObject

+ (instancetype)shared;

/**
 *	@brief  获取请求参数
 *
 *	@return 参数字典
 */
- (NSDictionary *)basicParametersForAreaRequest;

@end
