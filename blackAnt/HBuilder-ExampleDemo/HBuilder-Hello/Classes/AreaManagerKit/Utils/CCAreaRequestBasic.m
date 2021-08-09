//
//  MTAreaRequestBasic.m
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/19.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import "CCAreaRequestBasic.h"

#import "MTAreaManagerSetting.h"

#import "UIDevice+MTAreaManager.h"
#import "NSObject+MTAreaManagerUtil.h"

@interface CCAreaRequestBasic ()

@property (nonatomic, copy) NSString *token;                    /**< token值 */
@property (nonatomic, copy) NSString *secret;                   /**< 密文 */
@property (nonatomic, copy) NSString *timestamp;                /**< 秒级时间戳 */

@property (nonatomic, copy) NSString *appId;                    /**< 应用id */
@property (nonatomic, copy) NSString *language;                 /**< 语言 */
@property (nonatomic, copy) NSNumber *isTest;                   /**< 是否测试环境 */
@property (nonatomic, copy) NSString *channel;                  /**< 渠道号 */
@property (nonatomic, copy) NSString *simCardCountryCode;       /**< SIM卡国家 */

@property (nonatomic, copy) NSString *appVersion;               /**< 应用版本 */
@property (nonatomic, copy) NSString *osVersion;                /**< 系统版本 */
@property (nonatomic, copy) NSString *device;                   /**< 设备型号 */

@property (nonatomic, copy) NSString *macAddress;               /**< 物理地址 */
@property (nonatomic, copy) NSString *idfa;                     /**< 设备标识符 */
@property (nonatomic, copy) NSString *info;                     /**< 加密后的信息 */

@property (nonatomic, copy) NSString *encryptionKey;            /**< 加密key */

@property (nonatomic, strong) NSNumber *epochSeconds;           /**< 时间戳 */
@property (nonatomic, strong) MTGPSDataModel *gpsDataModel;     /**< gps信息 */

@end

@implementation CCAreaRequestBasic

+ (instancetype)shared {
    
    static CCAreaRequestBasic *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCAreaRequestBasic alloc] init];
    });
    return sharedInstance;
}

- (NSDictionary *)basicParametersForAreaRequest {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];

    @try {
        [dict addEntriesFromDictionary:@{@"token"      : self.token,
                                         @"secret"     : self.secret,
                                         @"timestamp"  : self.timestamp,
                                         @"softid"     : self.appId,
                                         @"version"    : self.appVersion,
                                         @"osversion"  : self.osVersion,
                                         @"device"     : self.device,
                                         @"lang"       : self.language,
                                         @"info"       : self.info}];
        
        if (self.isTest && [self.isTest boolValue]) {
            dict[@"istest"] = @"1";
        }
        if (self.channel.length) {
            dict[@"channel"] = self.channel;
        }
        if (self.simCardCountryCode.length) {
            dict[@"country_code"] = self.simCardCountryCode;
        }
    }
    @catch (NSException *exception) {
        
    }
    
    return dict;
}

#pragma mark - Setter Getter

- (NSNumber *)epochSeconds {
    
    if (!_epochSeconds) {
        _epochSeconds = @([[NSDate date] timeIntervalSince1970]);
    }
    
    return _epochSeconds;
}

- (NSString *)token {
    
    if (!_token) {
        //  如果有设置推送token则取推送token，没有则取毫秒级时间戳
        _token = [MTAreaManagerSetting shared].deviceToken;
        if (_token == nil) {
            _token = [NSString stringWithFormat:@"%ld",(long)round([self.epochSeconds doubleValue] * 1000)];
        }
    }
    
    return _token;
}

- (NSString *)secret {
    
    if (!_secret) {
        _secret = [self.token areaManager_encryptUseDESWithKey:self.encryptionKey];
    }
    
    return _secret;
}

- (NSString *)encryptionKey {
    
    if (!_encryptionKey) {
        NSMutableString *key = [[NSMutableString alloc] init];
        
        NSString *md5 = [self.token areaManager_MD5];
        
        //  md5 取 2、4、7、9、12、22位
        NSArray *indexs = @[@2,@4,@7,@9,@12,@22];
        for (NSNumber *index in indexs) {
            [key appendFormat:@"%c",[md5 characterAtIndex:index.unsignedIntegerValue]];
        }
        
        //  取当前的时间中的小时（2位数）作为key的第7、8位；时区统一使用东八区
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setDateFormat:@"HH"];
        NSString *strHour = [dateFormatter stringFromDate:[NSDate date]];
        [key appendString:strHour];
        
        _encryptionKey = [NSString stringWithString:key];
    }
    
    return _encryptionKey;
}

- (NSString *)timestamp {
    
    if (!_timestamp) {
        _timestamp = [NSString stringWithFormat:@"%ld",(long)round([self.epochSeconds doubleValue])];
    }
    
    return _timestamp;
}

- (NSString *)appId {
    
    if (!_appId) {
        _appId = [[MTAreaManagerSetting shared] appId];
    }
    
    return _appId;
}

- (NSString *)appVersion {
    
    if (!_appVersion) {
        _appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    }
    
    return _appVersion;
}

- (NSString *)osVersion {
    
    if (!_osVersion) {
        _osVersion = [[UIDevice currentDevice] systemVersion];
    }
    
    return _osVersion;
}

- (NSString *)language {
    
    if (!_language) {
        _language = [[MTAreaManagerSetting shared] language];
    }
    
    return _language;
}

- (NSNumber *)isTest {
    
    if (!_isTest) {
        _isTest = [[MTAreaManagerSetting shared] isTest];
    }
    
    return _isTest;
}

- (NSString *)channel {
    
    if (!_channel) {
        _channel = [[MTAreaManagerSetting shared] channel];
    }
    
    return _channel;
}

- (NSString *)simCardCountryCode {
    
    _simCardCountryCode = [[MTAreaManagerSetting shared] simCardCountryCode];
    
    return _simCardCountryCode;
}

- (NSString *)device {
    
    if (!_device) {
        _device = [[UIDevice currentDevice] areaManager_devicePlatform];
    }
    
    return _device;
}

- (NSString *)idfa {
    
    if (!_idfa) {
        _idfa = [UIDevice areaManager_IDFA];
    }
    
    return _idfa;
}

- (MTGPSDataModel *)gpsDataModel {
    
    _gpsDataModel = [[MTAreaManagerSetting shared] gpsDataModel];
    
    return _gpsDataModel;
}

- (NSString *)info {
    
    if (!_info) {
        NSDictionary *infoDic = @{@"idfa"   : self.idfa,
                                  @"mac"    : @"",
                                  @"lat"    : self.gpsDataModel ? @(self.gpsDataModel.latitude) : @"",
                                  @"lng"    : self.gpsDataModel ? @(self.gpsDataModel.longitude) : @""};
        
        NSString *jsonString = [infoDic areaManager_jsonString];        
        _info = [jsonString areaManager_encryptUseDESWithKey:self.encryptionKey];
        
    }
    return _info;
}

@end
