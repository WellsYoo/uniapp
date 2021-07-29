//
//  NSObject+MTAreaManagerUtil.m
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/22.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import "NSObject+MTAreaManagerUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSObject (MTAreaManagerUtil)

- (NSString *)areaManager_jsonString {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
        return jsonString;

    } else {
        return nil;
    }
}

@end

@implementation NSString (MTAreaManagerUtil)

- (NSString *)areaManager_MD5 {
    
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return [output lowercaseString];
}

- (NSString *)areaManager_encryptUseDESWithKey:(NSString *)key {
    
    NSUInteger dataLength = ((self.length-1)/8+1)*8;
    
    unsigned char textBytes[dataLength];
    memset(textBytes, 0, dataLength);
    for (int i = 0; i < self.length; i++) {
        textBytes[i] = [self characterAtIndex:i];
    }
    
    unsigned char buffer[1024];
    Byte iv[] = {0,0,0,0,0,0,0,0};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          textBytes,
                                          dataLength,
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSMutableString *ciphertext = [[NSMutableString alloc] init];
    
    if (cryptStatus == kCCSuccess) {
        
        for (int i = 0; i < dataLength; i++) {
            [ciphertext appendFormat:@"%02x",buffer[i]];
        }
        
    }
    return ciphertext;
}

@end

@implementation NSDictionary (MTAreaManagerUtil)

- (NSData *)areaManager_postData {
    
    NSMutableArray *parameterArr = [[NSMutableArray alloc] init];
    for (NSString *key in [self allKeys]) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,self[key]];
        [parameterArr addObject:str];
    }
    NSString *strURL = [parameterArr componentsJoinedByString:@"&"];
    NSData *postData = [strURL dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return postData;
}

@end
