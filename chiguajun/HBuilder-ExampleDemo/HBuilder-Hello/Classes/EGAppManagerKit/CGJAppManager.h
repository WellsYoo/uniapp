//
//  MTAppManager.h
//  MTAppCommunication
//
//  Created by JoyChiang on 13-3-13.
//  Copyright (c) 2013年 Meitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <Foundation/Foundation.h>
#import "MTAppMessage.h"

#define MTAppCommunicationVersion @"3.0"

//////////////////////////////////////////////////////////////////////////////////////////////////
/******************
 *  美图秀秀
 ******************/
extern NSString *const MTXXScheme;                  // 美图秀秀urlScheme
extern NSString *const MTXXStoreId;                 // 美图秀秀appId
// 美化
extern NSString *const kMTXXMeiHua;                 // 美化
extern NSString *const kMTXXMeiHua_Border;          // 美化-边框
extern NSString *const kMTXXMeiHua_Mosaic;          // 美化-马赛克
extern NSString *const kMTXXMeiHua_Text;            // 美化-文字

// 美容
extern NSString *const kMTXXMeiRong;                // 美容

//贴纸
extern NSString *const kMTXXMeiHua_Sticker;         //贴纸

/******************
 *  美颜相机
 ******************/
extern NSString *const MYXJScheme;                  // 美颜相机urlScheme
extern NSString *const MYXJStoreId;                 // 美颜相机appId
extern NSString *const kMYXJ_GJMY;                  // 美颜相机-高级美颜(带图）
extern NSString *const kMYXJ_Beayty;                //打开美颜相机高级美颜（不带图）
extern NSString *const kMYXJ_Camera;                //跳转到自拍
extern NSString *const kMYXJ_Photosticker;          //跳转大头贴贩卖机
extern NSString *const kMYXJ_Feedback;              //跳转意见反馈
extern NSString *const kMYXJ_Webview;               //跳转新的 WebView, 参数:url(必选，缺省的话直接回调）
extern NSString *const kMYXJ_Disney;                //转指定的萌拍素材,参数:materialID(素材ID，可选）
extern NSString *const kMYXJ_Beautymaster;          //跳转颜值管家

/******************
 *  海报工厂
 ******************/
extern NSString *const HBGCScheme;                  // 海报工厂urlScheme
extern NSString *const HBGCStoreId;                 // 海报工厂appId
extern NSString *const kHBGC_ZZHB;                  // 海报工厂-制作海报

/******************
 *  潮自拍
 ******************/
extern NSString *const SelfieCityScheme;            // 潮自拍urlScheme
extern NSString *const SelfieCityStoreId;           // 潮自拍appId
extern NSString *const kSelfieCityCamera;           // 潮自拍相机实时滤镜页
extern NSString *const kSelfieCity_AlbumFilter;     // 潮自拍相册进入特效页
extern NSString *const kSelfieCity_GridPhoto;       // 潮自拍多格拍照

/******************
 *  美妆
 ******************/
extern NSString *const MZXJScheme;                  // 美妆相机urlScheme
extern NSString *const MZXJStoreId;                 // 美妆相机appId
extern NSString *const kMZXJZhuangRong;             // 美妆-妆容
extern NSString *const kMZXJSeniorMakeup;           // 美妆-高级美妆

/******************
 *  美拍
 ******************/
extern NSString *const MeiPaiScheme;                // 美拍urlScheme
extern NSString *const MeiPaiStoreId;               // 美拍appId

/******************
 *  AirBrush
 ******************/
extern NSString *const AirBrushScheme;              // AirBrush urlScheme
extern NSString *const AirBrushStoreId;             // AirBrush appID
extern NSString *const kAirBrushBeautyCenter;       // AirBrush 编辑主页

/******************
 *  美图贴贴
 ******************/
extern NSString *const MTTTScheme;                  // 美图贴贴urlScheme
extern NSString *const MTTTStoreId;                 // 美图贴贴appId
// 单张拼图
extern NSString *const kMTTT_DZPT;                  // 美图贴贴-单张拼图

//////////////////////////////////////////////////////////////////////////////////////////////////

@protocol MTAppManagerDelegate;
@class CGJAppRequest;

extern NSString *const MTErrorDomain;
extern NSString *const MTClientErrorDomain;

typedef NS_ENUM(NSInteger, MTError) {
    MTErrorAppNotInstalled      = 1,
    MTErrorNotSupportedAction   = 2,
    MTErrorNotSupportedVersion  = 3
};

typedef void(^MTAppFailureBlock)(NSError *error);
typedef void(^MTAppSuccessBlock)(EGAppResponseMessage *responseMessage, BOOL cancelled);
typedef void(^MTAppActionHandlerBlock)(EGAppRequestMessage *requestMessage, MTAppSuccessBlock success, MTAppFailureBlock failure);

@interface CGJAppManager : NSObject

@property(nonatomic, copy) NSString *callbackURLScheme;         /**< 应用程序回调URL Scheme */
@property(nonatomic, assign) id<MTAppManagerDelegate> delegate; /**< 处理外部程序返回结果代理 */

+ (CGJAppManager *)sharedManager;

/**
 *	@brief	处理URL解析和调用不同的处理程序和委托方法，需要在application:openURL:sourceApplication:annotation:中调用。
 *
 *	@param 	url 	url地址
 *
 *	@return	成功返回YES，失败返回NO。
 */
- (BOOL)handleOpenURL:(NSURL *)url;

/**
 *	@brief	发送请求到外部程序
 *
 *	@param 	request 	请求对象
 */
- (void)sendRequest:(CGJAppRequest *)request;

/**
 *	@brief	响应action事件
 *
 *	@param 	action 	事件名称 需要调用的app功能模块 @see 文件顶部以k开头定义的常量，如：kMTXXMeiHua，kkSelfieCityCamera等
 *	@param 	handler 响应回调处理
 */
- (void)handleAction:(NSString *)action withBlock:(MTAppActionHandlerBlock)handler;

/**
 *	@brief	是否支持程序内部打开AppStore
 *
 *	@return	支持返回YES，否则返回NO
 */
+ (BOOL)isSupportSKStoreProductViewController;

/**
 *	@brief	根据addId打开相应的app
 *
 *	@param 	appId 	应用在appStore的ID
 *	@param 	viewController 	用于驱起SKStoreProductViewController的viewController
 */
+ (void)openAppWithId:(NSString *)appId viewController:(UIViewController *)viewController;

/**
 *	@brief	根据addId打开相应的app
 *
 *	@param 	appId 	应用在appStore的ID
 *	@param 	viewController 	用于驱起SKStoreProductViewController的viewController
 *	@param 	delegate 	SKStoreProductViewControllerDelegate
 */
+ (void)openAppWithId:(NSString *)appId
       viewController:(UIViewController *)viewController
             delegate:(id<SKStoreProductViewControllerDelegate>)delegate;

/**
 *	@brief	隐藏当前有弹出的所有UIAlertView和UIActionSheet
 *
 *	@param 	subviews 	子视图集合
 */
+ (void)hideAllAlertView:(NSArray *)subviews;

@end

/////////////////////////////////////////////////////////////////////////////////////

@protocol MTAppManagerDelegate <NSObject>

/**
 *	@brief	是否支持action事件
 *
 *	@param 	action 	事件名称
 *
 *	@return	支持返回YES，否则返回NO。不支持时，performAction将不会被调用。
 */
- (BOOL)appCommunicationSupportsAction:(NSString *)action;

/**
 *  调用app模块功能的回调函数，action指定事件未设置回调block时，通过delete执行此接口
 *
 *  @param action     需要调用的app功能模块 @see 文件顶部以k开头定义的常量，如：kMTXXMeiHua，kkSelfieCityCamera等
 *  @param parameters 处理
 *  @param success    处理成功的回调块
 *  @param failure    处理失败的回调块
 */
- (void)handleAction:(NSString *)action
          parameters:(NSDictionary *)parameters
           onSuccess:(MTAppSuccessBlock)success
           onFailure:(MTAppFailureBlock)failure;

@end
