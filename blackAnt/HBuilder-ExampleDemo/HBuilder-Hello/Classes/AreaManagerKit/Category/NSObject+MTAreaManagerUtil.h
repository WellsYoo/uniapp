//
//  NSObject+MTAreaManagerUtil.h
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/22.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MTAreaManagerUtil)

/**
 *	@brief  Json_Encode
 */
- (NSString *)areaManager_jsonString;

@end

@interface NSString (MTAreaManagerUtil)

/**
 *	@brief  MD5加密
 */
- (NSString *)areaManager_MD5;

/**
 *	@brief  DES加密
 *
 *	@param key	密钥
 *
 *	@return 密文
 */
- (NSString *)areaManager_encryptUseDESWithKey:(NSString *)key;

@end

@interface NSDictionary (MTAreaManagerUtil)

/**
 *	@brief  json转化为post请求数据
 */
- (NSData *)areaManager_postData;

@end


