//
//  NotificationCenterWidgetSdk.h
//  NotificationCenterWidgetSdk
//
//  Created by YWH on 15/12/8.
//  Copyright (c) 2015年 YWH. All rights reserved.
//

#ifndef NotificationCenterWidgetSdk_NotificationCenterWidgetSdk_h
#define NotificationCenterWidgetSdk_NotificationCenterWidgetSdk_h

#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

//通知中心的类型
typedef NS_ENUM(NSInteger, NCWType)
{
    MEPersonContactTypePhone = 0, //电话
    MEPersonContactTypeMSG = 1,   //短信
    NCWApplication         = 2  //应用
};



//通用颜色宏定义
//参数格式为：FFFFFF
#define colorWithRGB(rgbValue)  colorWithRGBA(rgbValue, 1.0)

//参数格式为：FFFFFF, 1.0
#define colorWithRGBA(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((0x##rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(0x##rgbValue & 0xFF)) / 255.0 alpha:alphaValue]


// 获取当前系统版本号
#define CURRENT_SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height    //获取屏幕高度
#define kScreenWidth     [UIScreen mainScreen].bounds.size.width   //获取屏幕宽度


#define kBundleName @"NotificationCenterResource.bundle"

//本地化宏
#define _(x) NSLocalizedString(x, @"")

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import "UIColor+NCWTool.h"
#import "CGJListHeadView.h"
#import "CGJtwareIconButton.h"
#import "CGJIconImageView.h"
#import "AMTagView.h"
#import "ESTabBarController.h"
#import "Masonry.h"

#endif


#define kURLSchemesPrefixTodayWidget    @"TodayAddContact://" //Contacts的target对应的widget回调
#define kSwitch                         @"showAddButton"
#define kFirstTimeLaunch                    @"firstTimeLaunch"
#define kNcwType  @"ncwType"       //类型标识字段
#define kIconResourceUrl @"http://exp.pgzs.com/support.ashx?act=710&ids="

//获取Bundle
#define kNCWBundleName   @"NotificationCenterResource.bundle"
#define kNCWBundlePath   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kNCWBundleName]
#define kNCWBundle       [NSBundle bundleWithPath:kNCWBundlePath]
#define kNCWBundleImage(ncwImageName) [UIImage imageWithContentsOfFile:[kNCWBundlePath stringByAppendingPathComponent:ncwImageName]]
#define kNCWLimitCount 20
#endif
