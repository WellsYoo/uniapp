//
//  MEWidgetInfoManager.m
//  MobileExperience
//
//  Created by Liyu on 15/7/27.
//  Copyright (c) 2015年 NetDragon. All rights reserved.
//

#import "NCWWidgetInfoManager.h"
#import <AddressBook/AddressBook.h>
#import "NCWDialog.h"
//#import "MEAddressBookManager.h"
//#import "BehaviorStat.h"

#define MEWidgetCacheDocument           @"Library/Caches/"
#define MEWidgetPersonInfoFileName      @"PersonInfo"

#define MEWidgetInfoEncodeRootKey       @"MEWidget"
#define MEWidgetPersonProtraitPrefix    @"MEWidgetPersonProtrait_record_"
#define MEWidgetPersonProtraitSuffix    @".png"

NSString *const ApplicationInfoKeyBundleId = @"ApplicationInfoKeyBundleId";
NSString *const ApplicationInfoKeyResId = @"ApplicationInfoKeyResId";
NSString *const ApplicationInfoKeyIconUrl = @"ApplicationInfoKeyIconUrl";
NSString *const CloseWidgetGuideMaskNotification = @"CloseWidgetGuideMaskNotification";

@interface NCWWidgetInfoManager()

@property (nonatomic) ABAddressBookRef addressBook;

@property (nonatomic,strong) NSMutableArray * personList;
@property (nonatomic,assign) BOOL needReloadData;

@property (nonatomic,strong) NSMutableArray * appInfoRequestQueue;
@property (nonatomic,strong) NSMutableArray * appBundleRequestQueue;

@end

@implementation NCWWidgetInfoManager
@synthesize haveCommited = _haveCommited;
@synthesize defaultPortrait = _defaultPortrait;

DEF_SINGLETON(MEWidgetInfoManager)

+ (NSString *)groupIdentifier
{
    NSString * mainIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString * groupIden = [NSString stringWithFormat:@"group.%@.launch",mainIdentifier];
    return groupIden;
}

- (instancetype) init
{
    self = [super init];
    if (self) {
//        [self checkAndUpdatePersonList];
//        __weak typeof(self)selfWR = self;
//        ABAddressBookRegisterExternalChangeCallback(selfWR.addressBook, addressCallback, (__bridge void *)(selfWR));
        //app信息获取队列
        self.appInfoRequestQueue = [NSMutableArray array];
        self.appBundleRequestQueue = [NSMutableArray array];
    }
    return self;
}

//- (void)visitAddressBook
//{
//        __weak typeof(self) selfWR = self;
//        ABAddressBookRequestAccessWithCompletion(selfWR.mainAddressBook, ^(bool granted, CFErrorRef error)
//            {
//            if (granted)
//            {
//                selfWR.upState = MEABStateAvailable;
//            }
//            else
//            {
//                selfWR.upState = MEABStateUnAvailable;
//            }
//        });
//}

- (UIImage *)defaultPortrait
{
    if (!_defaultPortrait) {
        _defaultPortrait = kNCWBundleImage(@"addressbook_default_portrait.png");
    }
    return _defaultPortrait;
}


- (ABAddressBookRef)addressBook
{
    if (_addressBook == nil) {
        if (CURRENT_SYSTEM_VERSION >= 6.0){
            _addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        }
    }
    return _addressBook;
}

//监听回调方法
//void addressCallback(ABAddressBookRef addressBook,CFDictionaryRef info,void *context)
//{
//    [NCWWidgetInfoManager sharedInstance].needReloadData = YES;
//}
//- (void)dealloc
//{
//    if (_addressBook != nil) {
//        CFRelease(_addressBook);
//    }
//    __weak typeof(self) selfWR = self;
//    ABAddressBookUnregisterExternalChangeCallback(selfWR.addressBook, addressCallback, (__bridge void *)(selfWR));
//}
//
//- (void)checkAndUpdatePersonList
//{
//    NSArray * personList = [NSArray arrayWithArray:self.personList];
//    for (id  person in personList) {
//        if ([person isKindOfClass:[NCWWidgetPerson class]] ) {
//            NCWWidgetPerson *tmpPerson = (NCWWidgetPerson *)person;
//            BOOL existed = [self isPersonExistedByRecordID:tmpPerson.recordID];
//            if (!existed) {
//                [self deleteFromWidget:tmpPerson saveWidget:YES];
//            }
//        }
//       
//    }
//}


- (BOOL)isPersonExistedByRecordID:(NSInteger)recordID
{
    if (recordID == 0) {
        return NO;
    }

    //获取联系人
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(self.mainAddressBook, (int)recordID);
    BOOL existed = NO;
    if (record) {
        existed = YES;
    }
    return existed;
}



- (ABAddressBookRef)mainAddressBook
{
    if (_mainAddressBook == nil) {
        _mainAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    }
    return _mainAddressBook;
}

//- (BOOL)haveCommited
//{
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    BOOL commited = [[userDefaults objectForKey:@"MEWidgetRegCommited"] boolValue];
//    return commited;
//}
//
//- (void)commitRegisteWidget
//{
//    NSUserDefaults * widgetDefaults = [[NSUserDefaults alloc] initWithSuiteName:[NCWWidgetInfoManager groupIdentifier]];
//    BOOL opened = [[widgetDefaults objectForKey:@"MEWidgetRegisted"] boolValue];
//    if (!opened) {
//        return;
//    }
////    [BehaviorStat CommitEvent:EVENT_AB_WIDGET_SCROLL_OPEN];
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:@(YES) forKey:@"MEWidgetRegCommited"];
//    [userDefaults synchronize];
//}

- (BOOL)isPersonNone
{
    NSArray *list = [self __widgetPersonInfoList];
    if (list && list.count > 0)
    {
        return  YES;
    }
    
    return  NO;
}

- (NSMutableArray *)personList
{
    if (!_personList) {
        _personList = [[NSMutableArray alloc] init];
        NSArray * infoList = [self __widgetPersonInfoList];
        for (NSDictionary * item in infoList) {
            NCWType type = [[item objectForKey:kNcwType] integerValue];
            switch (type) {
                case MEPersonContactTypePhone:
                case MEPersonContactTypeMSG:
                {
                    NCWWidgetPerson * person = [[NCWWidgetPerson alloc] initWithData:item];
                    if (person) {
                        [_personList addObject:person];
                    }
                    
                    break;
                }
                case NCWApplication:
                {
                    NCWApplicationItem *appItem = [[NCWApplicationItem alloc] initWithDictionary:item];
                    if (appItem) {
                        [_personList addObject:appItem];
                    }
                    break;
                }
                default:
                    break;
            };
        }
    }
    return _personList;
}

- (BOOL)saveToWidget
{
    NSMutableArray * infoList = [[NSMutableArray alloc] init];
    for (id item in self.personList) {
        if ([item isKindOfClass:[NCWWidgetPerson class]]) {
            NCWWidgetPerson *person = (NCWWidgetPerson *)item;
            NSDictionary * personInfo = [person personInfoForWidget];
            [infoList addObject:personInfo];
        }else {
            NCWApplicationItem *appItem = (NCWApplicationItem *)item;
            NSDictionary *appInfo = [appItem applicationInfoForWidget];
            [infoList addObject:appInfo];
        }
    }
    NSURL * contentURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:[NCWWidgetInfoManager groupIdentifier]];
    NSURL * infoURL = [contentURL URLByAppendingPathComponent:MEWidgetCacheDocument];
    infoURL = [infoURL URLByAppendingPathComponent:MEWidgetPersonInfoFileName];
    BOOL succeed = [infoList writeToURL:infoURL atomically:YES];
    return succeed;
}

- (NSArray *)personListAtWidget
{
    if (self.needReloadData) {
//        [self checkAndUpdatePersonList];
        self.needReloadData = NO;
    }
    return [NSArray arrayWithArray:self.personList];
}

- (BOOL)addNCWItemToWidget:(id)ncwItem saveToWidget:(BOOL)save
{
    if (!ncwItem) return NO;
    BOOL contain = [self __widgetContainsNcwItem:ncwItem];
    BOOL succeed = YES;
    if (!contain)
    {
        //添加联系人对象到列表
        [self.personList addObject:ncwItem];
    }
    if (contain && [ncwItem isKindOfClass:[NCWWidgetPerson class]] ) {
        [NCWDialog toast:@"您已添加过此号码！"];
    }
    if (save) {
       succeed = [self saveToWidget];
    }
    return succeed;
}


- (BOOL)deleteFromWidget:(id )ncwItem saveWidget:(BOOL)save
{
    if (!ncwItem) return NO;
    BOOL succeed;
    __block NSInteger index = -1;
    [self.personList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NCWWidgetPerson class]]&&[ncwItem isKindOfClass:[NCWWidgetPerson class]]) {
            
            NCWWidgetPerson * tmpPerson = (NCWWidgetPerson *)obj;
            if ( [tmpPerson isEqualToPerson:(NCWWidgetPerson *)ncwItem]) {
                index = idx;
                *stop = YES;
            }

        }else if([obj isKindOfClass:[NCWApplicationItem class]]&&[ncwItem isKindOfClass:[NCWApplicationItem class]]){
            if ([obj isEqual:ncwItem]) {
                index = idx;
                *stop = YES;
            }
        }
    }];
    if (index != -1) {
        [self.personList removeObjectAtIndex:index];
    }
    
    if (save) {
        succeed = [self saveToWidget];
    }
    return succeed;
}


- (BOOL)sortNCWListWithNewList:(NSArray *)list
{
    if (list.count != self.personList.count) {
        return NO;
    }
    [self.personList removeAllObjects];
    [self.personList addObjectsFromArray:list];
    BOOL succeed = [self saveToWidget];
    return succeed;
}

//- (UIImage *)personPortrait:(NCWWidgetPerson *)person
//{
//    if (!person || person.recordID == 0) {
//        return nil;
//    }
//    UIImage * image = [self personProtraitByRecordID:person.recordID];
//    return image;
//}
//


- (UIImage *)personProtraitByRecordID:(NSInteger)recordID
{
    if (recordID == 0) {
        return nil;
    }
//    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
//        self.upState = MEABStateUnAvailable;
//        return nil;
//    }
    //获取联系人
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(self.mainAddressBook, (int)recordID);
    if (record == nil) {
        return nil;
    }
    CFDataRef dataRef = ABPersonCopyImageDataWithFormat(record, kABPersonImageFormatThumbnail);
    NSData * imageData = (__bridge NSData *)dataRef;
    if (imageData == nil) {
        return nil;
    }
    UIImage * thumb = [UIImage imageWithData:imageData];
    return thumb;
    
}

#pragma mark - private methods

- (BOOL)__widgetContainsNcwItem:(id)ncwItem
{
    __block BOOL contain = NO;
    [self.personList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NCWWidgetPerson class]]&&[ncwItem isKindOfClass:[NCWWidgetPerson class]]) {
            NCWWidgetPerson * tmpPerson = (NCWWidgetPerson *)obj;
            if ([tmpPerson isEqualToPerson:(NCWWidgetPerson *)ncwItem]) {
                contain = YES;
                *stop = YES;
            }
        }else if([obj isKindOfClass:[NCWApplicationItem class]]&&[ncwItem isKindOfClass:[NCWApplicationItem class]])
        {
            NCWApplicationItem * tmpApp = (NCWApplicationItem *)obj;
            if ([tmpApp isEqual:ncwItem]) {
                contain = YES;
                *stop = YES;
            }
        }
    }];
    return contain;
}



- (NSArray *)__widgetPersonInfoList
{
    NSURL * contentURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:[NCWWidgetInfoManager groupIdentifier]];
    NSURL * infoURL = [contentURL URLByAppendingPathComponent:MEWidgetCacheDocument];
    infoURL = [infoURL URLByAppendingPathComponent:MEWidgetPersonInfoFileName];
    NSArray * list = [NSArray arrayWithContentsOfURL:infoURL];
    return list;
}


-(UIImage *)convertViewToImage:(UIView *) view
{
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}








-(BOOL)onlyContainChineseCharacter:(NSString *) fullName{
    if (fullName &&[fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0) {
        NSString *trimWhitespaceString = [fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *trimPunctuationString = [trimWhitespaceString stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
        NSUInteger length = [trimPunctuationString length];
        if (![trimPunctuationString isEqualToString:trimWhitespaceString]) {
            return NO;
        }
        for (int i = 0; i<length; i++) {
           
            int c = [trimPunctuationString characterAtIndex:i];
            if (ispunct(c)) {
                return NO;
            }
             NSString *temp = [trimPunctuationString substringWithRange:NSMakeRange(i,1)];
            if ([temp isEqualToString:@" "]) {
                continue;
            }
            const char *u8Temp = [temp UTF8String];
            if (u8Temp == NULL|| 3!=strlen(u8Temp)){
                return NO;
            }
        }
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)onlyContainLetter:(NSString *)fullName{
    if (fullName && [fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0) {
        NSUInteger length = [fullName length];
        for (int i = 0; i<length; i++) {
            char commitChar = [fullName characterAtIndex:i];
            if (commitChar == 32) {
                continue;
            }
            if(!(((commitChar>96)&&(commitChar<123))||((commitChar>64)&&(commitChar<91)))){
                return NO;
            }
        }
        return YES;
    }else{
        return  NO;
    }
}

NSString *const ApplicationRequestQueueAppItem = @"ApplicationRequestQueueAppItem";
NSString *const ApplicationRequestQueueBlock = @"ApplicationRequestQueueBlock";
- (void)requestApplicationInfo:(NCWApplicationItem *)appItem complete:(NCWApplicationInfoResponse)applicationInfo
{
    NSDictionary *queue = @{ApplicationRequestQueueAppItem:appItem,
                            ApplicationRequestQueueBlock:applicationInfo};
    if (![self.appBundleRequestQueue containsObject:appItem.bundleId]) {
        [self.appBundleRequestQueue addObject:appItem.bundleId];
        [self.appInfoRequestQueue addObject:queue];
        if (self.appInfoRequestQueue.count <= 10) {
            [self startRequest:queue];
        }
    }
}

- (void)startRequest:(NSDictionary *)requestInfo
{
    NCWApplicationItem *appItem = [requestInfo objectForKey:ApplicationRequestQueueAppItem];
    NCWApplicationInfoResponse responseBlock = (NCWApplicationInfoResponse)[requestInfo objectForKey:ApplicationRequestQueueBlock];
    if ([appItem.appId integerValue] && !appItem.isLoaded) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
//            NSString *requestUrl = [NSString stringWithFormat:@"%@%@", kIconResourceUrl, appItem.appId];
//            @try {
//                NSURL *url = [NSURL URLWithString:requestUrl];
//                NSData *json = [NSData dataWithContentsOfURL:url];
//                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:NULL];
//                NSDictionary *result = [dict objectForKey:@"Result"];
//                NSArray *items = [result objectForKey:@"items"];
//                NSString *imageUrl = [[items firstObject] objectForKey:@"icon"];
//                NSString *bundleId = [[items firstObject] objectForKey:@"identifer"];
//                NSString *resId = [[items firstObject] objectForKey:@"resId"];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (bundleId && imageUrl && resId) {
//                        [self.appInfoRequestQueue removeObject:requestInfo];
//                        [self.appBundleRequestQueue removeObject:appItem.bundleId];
//                        NSDictionary *appInfo = @{ApplicationInfoKeyBundleId: bundleId,
//                                                  ApplicationInfoKeyResId: resId,
//                                                  ApplicationInfoKeyIconUrl: imageUrl};
//                        responseBlock(appInfo);
//                    }else {
//                        responseBlock(nil);
//                    }
//                    [self contiuneRequestQueue];
//                });
//            }
//            @catch (NSException *exception) {
//                
//            }
//            @finally {
//                
//            }
            
            //修改成用post请求
            NSURL *url = [NSURL URLWithString:@"http://exp.pgzs.com/support.ashx?act=710"];
            NSString *param = [NSString stringWithFormat:@"{\"ids\":\"%@;\"}", appItem.appId];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            request.timeoutInterval = 5;
            request.HTTPMethod = @"POST";
            request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
//            [request setValue:@"pgzs.com-com.alexaner.ncw" forHTTPHeaderField:@"User-Agent"];
            
            NSOperationQueue *queue = [NSOperationQueue mainQueue];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:queue
            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                @try {
                    NSArray *items = [[result objectForKey:@"Result"] objectForKey:@"items"];
                    NSString *imageUrl = [[items firstObject] objectForKey:@"icon"];
                    NSString *bundleId = [[items firstObject] objectForKey:@"identifer"];
                    NSString *resId = [[items firstObject] objectForKey:@"resId"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (bundleId && imageUrl && resId) {
                            [self.appInfoRequestQueue removeObject:requestInfo];
                            [self.appBundleRequestQueue removeObject:appItem.bundleId];
                            NSDictionary *appInfo = @{ApplicationInfoKeyBundleId: bundleId,
                                                      ApplicationInfoKeyResId: resId,
                                                      ApplicationInfoKeyIconUrl: imageUrl};
                            responseBlock(appInfo);
                        }else {
                            responseBlock(nil);
                        }
                        [self contiuneRequestQueue];
                    });

                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
            }];
        });
    }else {
        [self.appBundleRequestQueue removeObject:appItem.bundleId];
        [self.appInfoRequestQueue removeObject:requestInfo];
    }
}

- (void)contiuneRequestQueue
{
    if (self.appInfoRequestQueue.count > 10) {
        NSDictionary *requestInfo = [self.appInfoRequestQueue objectAtIndex:10];
        [self startRequest:requestInfo];
    }
}

- (void)clearRequestQueue
{
    [self.appBundleRequestQueue removeAllObjects];
    [self.appInfoRequestQueue removeAllObjects];
}

@end
