//
//  NCWApplicationModel.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/25.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBundle @"bundleId"
#define kTitle  @"title"
#define kIcon   @"icon"
#define kScheme @"schemeUrl"
#define kAppID  @"appId"
#define kItems  @"items"
#define kImage  @"imageData"
#define kCheck  @"checked"
#define kCommon @"common"
#define kSystem @"system"
#define kLoaded @"loaded"
#define kInstalled @"installed"
#define kTitleIndex  @"titleIndex"


@interface DBJApplicationItem : NSObject
{
    NSString *_title;
    NSString *_iconUrl;
    NSString *_schemeUrl;
    NSString *_titleIndex;
    NSString *_bundleId;
    NSString *_appId;
    NSMutableArray *_subItems;
    
    BOOL      _isChecked;   //是否已选中
    BOOL      _isExpress;   //是否展开
    BOOL      _isCommon;    //是否常用
    BOOL      _isSystemApp; //是否系统应用
    BOOL      _isFromInstalled; //是否系统应用
    BOOL      _isLoaded;      //是否已读取完成json
    
    NSData *_imageData;
}

@property(nonatomic, retain) NSString        *bundleId;
@property(nonatomic, retain) NSString        *appId;
@property(nonatomic, retain) NSString        *title;
@property(nonatomic, retain) NSString        *iconUrl;
@property(nonatomic, retain) NSString        *schemeUrl;
@property(nonatomic, retain) NSString        *titleIndex;
@property(nonatomic, retain) NSData          *imageData;
@property(nonatomic, retain) NSMutableArray  *subItems;
@property(nonatomic, assign) BOOL             isChecked;
@property(nonatomic, assign) BOOL             isExpress;
@property(nonatomic, assign) BOOL             isCommon;
@property(nonatomic, assign) BOOL             isSystemApp;
@property(nonatomic, assign) BOOL             isFromInstalled;
@property(nonatomic, assign) BOOL             isLoaded;
@property(nonatomic, assign) NCWType           ncwType; //类型

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)appItemsWithArray:(NSArray *)array;

- (NSDictionary *)applicationInfoForWidget;

@end
