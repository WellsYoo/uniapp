//
//  MTAreaDataModel.h
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/18.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief  七大洲分类
 */
typedef NS_ENUM(NSUInteger, MTAreaContinent) {
    MTAreaUnknownContinent = 0, /**< 获取不到 */
    MTAreaAsia,                 /**< 亚洲 */
    MTAreaAfrica,               /**< 非洲 */
    MTAreaNorthAmerica,         /**< 北美洲 */
    MTAreaSouthAmerica,         /**< 南美洲 */
    MTAreaAntarctica,           /**< 南极洲 */
    MTAreaEurope,               /**< 欧洲 */
    MTAreaAustralia             /**< 大洋洲 */
};

@interface MTAreaDataModel : NSObject <NSCoding>

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (nonatomic, assign) MTAreaContinent continent;    /**< 大洲类型 */
@property (nonatomic, copy) NSString *continentCn;          /**< 洲名（中文） */
@property (nonatomic, copy) NSString *continentEn;          /**< 洲名（英文） */

@property (nonatomic, copy) NSString *countryCn;            /**< 国家（中文） */
@property (nonatomic, copy) NSString *countryEn;            /**< 国家（英文） */
@property (nonatomic, copy) NSString *countryCode;          /**< 国家简码 */

@property (nonatomic, copy) NSString *detailedArea;         /**< 详细区域,需要后台控制才能下发该字段 */
@property (nonatomic, copy) NSString *detailedAreaCode;     /**< 详细区域编码,需要后台控制才能下发该字段 */

@end
