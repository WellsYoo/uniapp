//
//  NCWApplicationModel.m
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/25.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "DBJApplicationItem.h"

@implementation DBJApplicationItem
@synthesize bundleId = _bundleId;
@synthesize title = _title;
@synthesize iconUrl = _iconUrl;
@synthesize schemeUrl = _schemeUrl;
@synthesize titleIndex = _titleIndex;
@synthesize appId = _appId;
@synthesize subItems = _subItems;
@synthesize imageData = _imageData;
@synthesize isChecked = _isChecked;
@synthesize isExpress = _isExpress;
@synthesize isCommon = _isCommon;
@synthesize isSystemApp = _isSystemApp;
@synthesize isFromInstalled = _isFromInstalled;
@synthesize isLoaded = _isLoaded;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.bundleId = [dictionary objectForKey:kBundle];
        self.appId = [dictionary objectForKey:kAppID];
        self.title = [dictionary objectForKey:kTitle];
        self.iconUrl = [dictionary objectForKey:kIcon];
        self.schemeUrl = [dictionary objectForKey:kScheme];
        self.imageData = [dictionary objectForKey:kImage];
        self.isSystemApp = [[dictionary objectForKey:kSystem] boolValue];
        self.isFromInstalled = [[dictionary objectForKey:kInstalled] boolValue];
        self.isCommon = [[dictionary objectForKey:kCommon] boolValue];
        self.isLoaded = [[dictionary objectForKey:kLoaded] boolValue];
        self.subItems = [NSMutableArray array];
        self.ncwType = NCWApplication;
        
        NSArray *appItems = [dictionary objectForKey:kItems];
        for (NSDictionary *item in appItems) {
            DBJApplicationItem *appItem = [[DBJApplicationItem alloc] initWithDictionary:item];
            [self.subItems addObject:appItem];
        }
    }
    return self;
}

+ (NSMutableArray *)appItemsWithArray:(NSArray *)array
{
    NSMutableArray *appItems = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        DBJApplicationItem *appItem = [[DBJApplicationItem alloc] initWithDictionary:dictionary];
        [appItems addObject:appItem];
    }
    return appItems;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self) {
        self.bundleId = [coder decodeObjectForKey:kBundle];
        self.appId = [coder decodeObjectForKey:kAppID];
        self.title = [coder decodeObjectForKey:kTitle];
        self.iconUrl = [coder decodeObjectForKey:kIcon];
        self.schemeUrl = [coder decodeObjectForKey:kScheme];
        self.titleIndex = [coder decodeObjectForKey:kTitleIndex];
        self.imageData = [coder decodeObjectForKey:kImage];
        self.subItems = [coder decodeObjectForKey:kItems];
        self.isChecked = [coder decodeBoolForKey:kCheck];
        self.isCommon = [coder decodeBoolForKey:kCommon];
        self.isSystemApp = [coder decodeBoolForKey:kSystem];
        self.isFromInstalled = [coder decodeBoolForKey:kInstalled];
        self.isLoaded = [coder decodeBoolForKey:kLoaded];
        self.ncwType = [coder decodeIntegerForKey:kNcwType];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_bundleId forKey:kBundle];
    [aCoder encodeObject:_appId forKey:kAppID];
    [aCoder encodeObject:_title forKey:kTitle];
    [aCoder encodeObject:_iconUrl forKey:kIcon];
    [aCoder encodeObject:_schemeUrl forKey:kScheme];
    [aCoder encodeObject:_titleIndex forKey:kTitleIndex];
    [aCoder encodeObject:_subItems forKey:kItems];
    [aCoder encodeObject:_imageData forKey:kImage];
    [aCoder encodeBool:_isChecked forKey:kCheck];
    [aCoder encodeBool:_isCommon forKey:kCommon];
    [aCoder encodeBool:_isSystemApp forKey:kSystem];
    [aCoder encodeBool:_isFromInstalled forKey:kInstalled];
    [aCoder encodeBool:_isLoaded forKey:kLoaded];
    [aCoder encodeInteger:_ncwType forKey:kNcwType];
}

- (NSDictionary *)applicationInfoForWidget
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:_bundleId forKey:kBundle];
    [dictionary setValue:_appId forKey:kAppID];
    [dictionary setValue:_title forKey:kTitle];
    [dictionary setValue:_iconUrl forKey:kIcon];
    [dictionary setValue:_schemeUrl forKey:kScheme];
    [dictionary setValue:_titleIndex forKey:kTitleIndex];
    [dictionary setValue:_imageData forKey:kImage];
    [dictionary setValue:_subItems forKey:kItems];
    [dictionary setValue:[NSNumber numberWithBool:_isChecked] forKey:kCheck];
    [dictionary setValue:[NSNumber numberWithBool:_isCommon] forKey:kCommon];
    [dictionary setValue:[NSNumber numberWithBool:_isSystemApp] forKey:kSystem];
    [dictionary setValue:[NSNumber numberWithBool:_isFromInstalled] forKey:kInstalled];
    [dictionary setValue:[NSNumber numberWithBool:_isLoaded] forKey:kLoaded];
    [dictionary setValue:@(_ncwType) forKey:kNcwType];
    
    NSDictionary *applicationInfo = [NSDictionary dictionaryWithDictionary:dictionary];
    return applicationInfo;
}


- (BOOL)isEqual:(id)object
{
    if (object == self) {
        return YES;
    }
    
    if (!object || ![object isKindOfClass:[self class]]) {
        return NO;
    }
    DBJApplicationItem * tempItem =(DBJApplicationItem*)object;
//    if ([tempItem.bundleId isEqualToString:[[NSBundle mainBundle] bundleIdentifier]]) {
//        if ([tempItem.bundleId isEqualToString:self.bundleId]) {
//            return YES;
//        }
//    }
    NSString *identifer = [NSString stringWithFormat:@"%@%@",self.bundleId, self.schemeUrl];
    NSString *tempIdentifer = [NSString stringWithFormat:@"%@%@", tempItem.bundleId, tempItem.schemeUrl];
    if (![identifer isEqualToString:tempIdentifer]) {
        return NO;
    }
    return YES;
}
@end
