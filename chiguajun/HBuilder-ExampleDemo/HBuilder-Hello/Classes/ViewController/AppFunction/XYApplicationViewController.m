//
//  ApplicationViewController.m
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "XYApplicationViewController.h"
#import "NCWWorkspace.h"

#import "CGJReallyManager.h"

#define kWechatBundleID @"com.tencent.xin"
#define kWeiboBundleID  @"com.sina.weibo"
#define kTaobaoBundleID @"com.taobao.taobao4iphone"
#define kAlipayBundleID @"com.alipay.iphoneclient"

@interface XYApplicationViewController ()
{
    NSMutableArray  *_appIdentifiers;
}
@end

@implementation XYApplicationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initAppItems
{
    [super initAppItems];

    
    
    
    _appIdentifiers = [NSMutableArray array];
    
    BOOL shouldBeReally = [[CGJReallyManager sharedInstance] shouleBeReally];
    if (shouldBeReally) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSDictionary *interfaces = [NSDictionary dictionaryWithContentsOfFile:[kNCWBundle pathForResource:@"NCWInterface" ofType:@""]];
        NSString *className = [interfaces objectForKey:@"WorkSpace"];
//        NSString *allApp = [interfaces objectForKey:@"allApp"];
        NSString *publicUrlScheme = [interfaces objectForKey:@"urlSchemes"];
        NSString *applicationsForUrlScheme = [interfaces objectForKey:@"applicationForUrlScheme"];
        NSString *appIdentifier = [interfaces objectForKey:@"appIdentifier"];
        NSString *appItemID = [interfaces objectForKey:@"appItemID"];
        NSString *locatizeName = [interfaces objectForKey:@"localizedName"];
        
        WFAppWorkspace *workspace = [NSClassFromString(className) performSelector:NSSelectorFromString(@"defaultWodfdsfasdfasdfrkspace")];
        NSArray *urlSchemes = [workspace performSelector:NSSelectorFromString(publicUrlScheme)];
//        NSArray *privateSchemes = [workspace performSelector:@selector(privateURLSchemes)];
        for (NSString *urlScheme in urlSchemes) {
            NSArray *applications = [workspace performSelector:NSSelectorFromString(applicationsForUrlScheme) withObject:urlScheme];
            [applications enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *bundleId = [obj performSelector:NSSelectorFromString(appIdentifier)];
                if (![bundleId hasPrefix:@"com.apple."]) {
                    
                    NSString *bundleName = [obj performSelector:NSSelectorFromString(locatizeName)];
                    NSString *itemId = [obj performSelector:NSSelectorFromString(appItemID)];
                    
                    if ([bundleId isEqualToString:kWechatBundleID]) {
                        [self addWechatAppItems];
                    }
                    if ([bundleId isEqualToString:kWeiboBundleID]) {
                        [self addWeiboAppItems];
                    }
                    if ([bundleId isEqualToString:kTaobaoBundleID]) {
                        [self addTaobaoAppItems];
                    }
                    if ([bundleId isEqualToString:kAlipayBundleID]) {
                        [self addAlipayAppItems];
                    }
                    if ([bundleId isEqualToString:[[NSBundle mainBundle] bundleIdentifier]]) {
                        [self addSelfItem];
                    }
                    
                    if (![_appIdentifiers containsObject:bundleId] && itemId && bundleId && bundleName) {
                        //获取icon
                        NSString *realUrlScheme = [NSString stringWithFormat:@"%@://", urlScheme];
                        if (itemId != nil && bundleId != nil && bundleName != nil && realUrlScheme != nil) {
                            NSDictionary *appDictionary = @{kAppID:itemId, kBundle:bundleId, kTitle:bundleName, kIcon:@"icon_default", kScheme:realUrlScheme};
                            YXpplicationItem *appItem = [[YXpplicationItem alloc] initWithDictionary:appDictionary];
                            appItem.isFromInstalled = YES;
                            
                            [_appIdentifiers addObject:bundleId];
                            [_tableData addObject:appItem];
                        }
                    }
                }

            }];
        }

#pragma clang diagnostic pop
    }else {
        [self addWechatAppItems];
        [self addWeiboAppItems];
        [self addTaobaoAppItems];
        [self addAlipayAppItems];
        [self addSelfItem];
    }
    
}

- (void)addWechatAppItems
{
    //微信
    if ([_appIdentifiers containsObject:kWechatBundleID]) {
        return;
    }
    NSDictionary *wechatSelf = @{kBundle:kWechatBundleID, kTitle:@"微信", kIcon:@"weixin", kScheme:@"weixin://"};
    NSDictionary *wechatFirend = @{kBundle:kWechatBundleID, kTitle:@"朋友圈", kIcon:@"weixin_firend", kScheme:@"weixin://dl/moments"};
    NSDictionary *wechatScan = @{kBundle:kWechatBundleID, kTitle:@"扫一扫", kIcon:@"weixin_scan", kScheme:@"weixin://dl/scan"};
    NSDictionary *wechatFunction = @{kBundle:kWechatBundleID, kTitle:@"功能插件", kIcon:@"weixin_function", kScheme:@"weixin://dl/features"};
    NSDictionary *wechatGongz = @{kBundle:kWechatBundleID, kTitle:@"公众号", kIcon:@"weixin_gongzh", kScheme:@"weixin://dl/officialaccounts"};
    NSDictionary *wechatGame = @{kBundle:kWechatBundleID, kTitle:@"游戏", kIcon:@"weixin_game", kScheme:@"weixin://dl/games"};
    NSDictionary *wechatInfo = @{kBundle:kWechatBundleID, kTitle:@"个人信息", kIcon:@"weixin_info", kScheme:@"weixin://dl/profile"};
    NSDictionary *wechatFeedback = @{kBundle:kWechatBundleID, kTitle:@"反馈", kIcon:@"weixin_feedback", kScheme:@"weixin://dl/feedback"};
    NSDictionary *wechatSetting = @{kBundle:kWechatBundleID, kTitle:@"设置", kIcon:@"weixin_setting", kScheme:@"weixin://dl/settings"};
    NSDictionary *wechatGeneral = @{kBundle:kWechatBundleID, kTitle:@"通用设置", kIcon:@"weixin_general", kScheme:@"weixin://dl/general"};
    NSDictionary *wechatChatSetting = @{kBundle:kWechatBundleID, kTitle:@"消息设置", kIcon:@"weixin_feedback", kScheme:@"weixin://dl/notifications"};
    NSDictionary *wechat = @{kBundle:kWechatBundleID, kTitle:@"微信", kIcon:@"weixin", kScheme:@"wechat",
                             kItems:@[wechatSelf, wechatFirend, wechatScan, wechatGame, wechatFunction, wechatGongz,
                                      wechatSetting, wechatInfo, wechatFeedback, wechatGeneral, wechatChatSetting]};
    YXpplicationItem *wechatItem = [[YXpplicationItem alloc] initWithDictionary:wechat];
    wechatItem.isCommon = YES;
    
    [_appIdentifiers addObject:kWechatBundleID];
    [_tableData addObject:wechatItem];
}

- (void)addWeiboAppItems
{
    //微博
    if ([_appIdentifiers containsObject:kWeiboBundleID]) {
        return;
    }
    NSDictionary *weiboSelf = @{kBundle:kWeiboBundleID, kTitle:@"微博", kIcon:@"weibo", kScheme:@"weibo://"};
    NSDictionary *weiboSend = @{kBundle:kWeiboBundleID, kTitle:@"发微博", kIcon:@"weibo_send", kScheme:@"weibo://compose"};
    NSDictionary *weiboHot = @{kBundle:kWeiboBundleID, kTitle:@"热门微博", kIcon:@"weibo_hot", kScheme:@"sinaweibo://fragmentpage?containerid=102803&amp;needlocation=1"};
    NSDictionary *weiboPhoto = @{kBundle:kWeiboBundleID, kTitle:@"发照片", kIcon:@"weibo_photo",
                                 kScheme:@"sinaweibo://compose?content_type=1&isWidget=1&lunicode=10000301&widgetActionType=2"};
    NSDictionary *weiboVideo = @{kBundle:kWeiboBundleID, kTitle:@"发视频", kIcon:@"weibo_video",
                                 kScheme:@"sinaweibo://compose?content_type=8&isWidget=1&lunicode=10000301&widgetActionType=3"};
    NSDictionary *weiboSearch = @{kBundle:kWeiboBundleID, kTitle:@"搜微博", kIcon:@"weibo_search", kScheme:@"sinaweibo://searchall"};
    NSDictionary *weiboScan = @{kBundle:kWeiboBundleID, kTitle:@"扫一扫", kIcon:@"weibo_scan", kScheme:@"sinaweibo://qrcode"};
    NSDictionary *weibo = @{kBundle:kWeiboBundleID, kTitle:@"微博", kIcon:@"weibo", kScheme:@"weibo", kItems:@[weiboSelf, weiboSend, weiboHot, weiboPhoto,
                                                                                                              weiboVideo, weiboSearch, weiboScan]};
    YXpplicationItem *weiboItem = [[YXpplicationItem alloc] initWithDictionary:weibo];
    weiboItem.isCommon = YES;
    
    [_appIdentifiers addObject:kWeiboBundleID];
    [_tableData addObject:weiboItem];
}

- (void)addTaobaoAppItems
{
    //淘宝
    if ([_appIdentifiers containsObject:kTaobaoBundleID]) {
        return;
    }
    NSDictionary *taobaoSelf = @{kBundle:kTaobaoBundleID, kTitle:@"淘宝", kIcon:@"taobao", kScheme:@"taobao://"};
    NSDictionary *taobaoWaimai = @{kBundle:kTaobaoBundleID, kTitle:@"外卖", kIcon:@"taobao_waimai", kScheme:@"taobao://s.taobao.com/?q=%e5%a4%96%e5%8d%96"};
    NSDictionary *taobaoSecond = @{kBundle:kTaobaoBundleID, kTitle:@"秒杀", kIcon:@"taobao_second", kScheme:@"taobao://s.taobao.com/?q=%e7%a7%92%e6%9d%80"};
    NSDictionary *taobaoJu = @{kBundle:kTaobaoBundleID, kTitle:@"聚划算", kIcon:@"taobao_ju", kScheme:@"taobao://s.taobao.com/?q=%e8%81%9a%e5%88%92%e7%ae%97"};
    NSDictionary *taobaoClothes = @{kBundle:kTaobaoBundleID, kTitle:@"洗衣", kIcon:@"taobao_clothes", kScheme:@"taobao://s.taobao.com/?q=%e6%b4%97%e8%a1%a3"};
    NSDictionary *taobaoHome = @{kBundle:kTaobaoBundleID, kTitle:@"家政", kIcon:@"taobao_home", kScheme:@"taobao://s.taobao.com/?q=%e5%ae%b6%e6%94%bf"};
    NSDictionary *taobao = @{kBundle:kTaobaoBundleID, kBundle:kTaobaoBundleID, kTitle:@"淘宝", kIcon:@"taobao", kScheme:@"taobao",
                             kItems:@[taobaoSelf, taobaoWaimai, taobaoSecond, taobaoJu,
                                      taobaoClothes, taobaoHome]};
    YXpplicationItem *taobaoItem = [[YXpplicationItem alloc] initWithDictionary:taobao];
    taobaoItem.isCommon = YES;
    
    [_appIdentifiers addObject:kTaobaoBundleID];
    [_tableData addObject:taobaoItem];
}

- (void)addAlipayAppItems
{
    //支付宝 //10000003手机充值 //10000011 购彩大厅
    if ([_appIdentifiers containsObject:kAlipayBundleID]) {
        return;
    }
    NSDictionary *alipaySelf = @{kBundle:kAlipayBundleID, kTitle:@"支付宝", kIcon:@"alipay", kScheme:@"alipay://"};
    NSDictionary *alipayPackage = @{kBundle:kAlipayBundleID, kTitle:@"卡包", kIcon:@"alipay_package", kScheme:@"alipay://platformapi/startapp?saId=88888888"};
    NSDictionary *alipayRed = @{kBundle:kAlipayBundleID, kTitle:@"红包", kIcon:@"alipay_redpackage", kScheme:@"alipay://platformapi/startapp?saId=88886666"};
    NSDictionary *alipayQrcode = @{kBundle:kAlipayBundleID, kTitle:@"付款码", kIcon:@"alipay_qrcode", kScheme:@"alipay://platformapi/startapp?saId=20000056"};
    NSDictionary *alipayHeart = @{kBundle:kAlipayBundleID, kTitle:@"爱心捐", kIcon:@"alipay_heart", kScheme:@"alipay://platformapi/startapp?saId=10000009"};
//    NSDictionary *alipayScret = @{kBundle:kAlipayBundleID, kTitle:@"手机密保", kIcon:@"alipay_scret", kScheme:@"alipay://platformapi/startapp?saId=10000008"};
    NSDictionary *alipayScan = @{kBundle:kAlipayBundleID, kTitle:@"扫码", kIcon:@"alipay_scan", kScheme:@"alipayqr://platformapi/startapp?saId=10000007"};
    NSDictionary *alipaySound = @{kBundle:kAlipayBundleID, kTitle:@"声波付", kIcon:@"alipay_sound", kScheme:@"alipay://platformapi/startapp?saId=10000014"};
    NSDictionary *alipay = @{kBundle:kAlipayBundleID, kTitle:@"支付宝", kIcon:@"alipay", kScheme:@"alipay",
                             kItems:@[alipaySelf, alipayPackage, alipayRed, alipayQrcode,
                                      alipayHeart, /*alipayScret,*/ alipayScan, alipaySound]};
    YXpplicationItem *alipayItem = [[YXpplicationItem alloc] initWithDictionary:alipay];
    alipayItem.isCommon = YES;
    
    [_appIdentifiers addObject:kAlipayBundleID];
    [_tableData addObject:alipayItem];
}

- (void)addSelfItem
{
    if ([_appIdentifiers containsObject:[[NSBundle mainBundle] bundleIdentifier]]) {
        return;
    }
    NSDictionary *appSelf = @{kBundle:[[NSBundle mainBundle] bundleIdentifier], kTitle:@"快手", kIcon:@"icon_self", kScheme:@"TodayAddContact://addPerson"};
    YXpplicationItem *selfItem = [[YXpplicationItem alloc] initWithDictionary:appSelf];
    
    [_appIdentifiers addObject:[[NSBundle mainBundle] bundleIdentifier]];
    [_tableData addObject:selfItem];
}

@end
