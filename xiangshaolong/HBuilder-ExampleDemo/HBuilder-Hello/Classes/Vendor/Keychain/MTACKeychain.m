//
//  MTACKeychain.m
//  MTACKeychain
//
//  Created by MTAC Soffes on 5/19/10.
//  Copyright (c) 2010-2014 MTAC Soffes. All rights reserved.
//

#import "MTACKeychain.h"
#import "MTACKeychainQuery.h"

NSString *const kMTACKeychainErrorDomain = @"com.samsoffes.samkeychain";
NSString *const kMTACKeychainAccountKey = @"acct";
NSString *const kMTACKeychainCreatedAtKey = @"cdat";
NSString *const kMTACKeychainClassKey = @"labl";
NSString *const kMTACKeychainDescriptionKey = @"desc";
NSString *const kMTACKeychainLabelKey = @"labl";
NSString *const kMTACKeychainLastModifiedKey = @"mdat";
NSString *const kMTACKeychainWhereKey = @"svce";

#if __IPHONE_4_0 && TARGET_OS_IPHONE
static CFTypeRef MTACKeychainAccessibilityType = NULL;
#endif

@implementation MTACKeychain

+ (nullable NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account {
    return [self passwordForService:serviceName account:account error:nil];
}


+ (nullable NSString *)passwordForService:(NSString *)serviceName
                                  account:(NSString *)account
                                    error:(NSError *__autoreleasing *)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch:error];
    return query.password;
}


+ (nullable NSString *)passwordForService:(NSString *)serviceName
                                  account:(NSString *)account
                              accessGroup:(NSString *)accessGroup
                                    error:(NSError *__autoreleasing *)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.accessGroup = accessGroup;
    [query fetch:error];
    return query.password;
}

+ (nullable NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account {
    return [self passwordDataForService:serviceName account:account error:nil];
}

+ (nullable NSData *)passwordDataForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch:error];
    
    return query.passwordData;
}
+ (nullable NSData *)passwordDataForService:(NSString *)serviceName
                                    account:(NSString *)account
                                accessGroup:(NSString *)accessGroup
                                      error:(NSError **)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.accessGroup = accessGroup;
    [query fetch:error];
    
    return query.passwordData;
}

+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account {
    return [self deletePasswordForService:serviceName account:account error:nil];
}


+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    return [query deleteItem:error];
}

+ (BOOL)deletePasswordForService:(NSString *)serviceName
                         account:(NSString *)account
                     accessGroup:(NSString *)accessGroup
                           error:(NSError *__autoreleasing *)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.accessGroup = accessGroup;
    return [query deleteItem:error];
}

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account {
    return [self setPassword:password forService:serviceName account:account error:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError *__autoreleasing *)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.password = password;
    return [query save:error];
}

+ (BOOL)setPassword:(NSString *)password
         forService:(NSString *)serviceName
            account:(NSString *)account
        accessGroup:(NSString *)accessGroup
              error:(NSError *__autoreleasing *)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.password = password;
    query.accessGroup = accessGroup;
    return [query save:error];
}

+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account {
    return [self setPasswordData:password forService:serviceName account:account error:nil];
}


+ (BOOL)setPasswordData:(NSData *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.passwordData = password;
    return [query save:error];
}


+ (BOOL)setPasswordData:(NSData *)password
             forService:(NSString *)serviceName
                account:(NSString *)account
            accessGroup:(NSString *)accessGroup
                  error:(NSError **)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    query.account = account;
    query.passwordData = password;
    query.accessGroup = accessGroup;
    return [query save:error];
}

+ (nullable NSArray *)allAccounts {
    return [self allAccounts:nil];
}


+ (nullable NSArray *)allAccounts:(NSError *__autoreleasing *)error {
    return [self accountsForService:nil error:error];
}


+ (nullable NSArray *)accountsForService:(nullable NSString *)serviceName {
    return [self accountsForService:serviceName error:nil];
}


+ (nullable NSArray *)accountsForService:(nullable NSString *)serviceName error:(NSError *__autoreleasing *)error {
    MTACKeychainQuery *query = [[MTACKeychainQuery alloc] init];
    query.service = serviceName;
    return [query fetchAll:error];
}


#if __IPHONE_4_0 && TARGET_OS_IPHONE
+ (CFTypeRef)accessibilityType {
    return MTACKeychainAccessibilityType;
}


+ (void)setAccessibilityType:(CFTypeRef)accessibilityType {
    CFRetain(accessibilityType);
    if (MTACKeychainAccessibilityType) {
        CFRelease(MTACKeychainAccessibilityType);
    }
    MTACKeychainAccessibilityType = accessibilityType;
}
#endif

@end
