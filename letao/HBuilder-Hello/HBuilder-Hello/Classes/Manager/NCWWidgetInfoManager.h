//
//  MEWidgetInfoManager.h
//  MobileExperience
//
//  Created by Liyu on 15/7/27.
//  Copyright (c) 2015年 NetDragon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCWWidgetPerson.h"
#import <AddressBook/AddressBook.h>
#import "NCWApplicationItem.h"

typedef void(^NCWApplicationInfoResponse)(NSDictionary *applicationInfor);
extern NSString *const ApplicationInfoKeyBundleId;
extern NSString *const ApplicationInfoKeyResId;
extern NSString *const ApplicationInfoKeyIconUrl;
extern NSString *const CloseWidgetGuideMaskNotification;
#define kAddressBookVisit       @"AddressBookVisitAllow"
#define kNotificationItemMaxNum 20

typedef NS_ENUM(NSInteger, MEABState)
{
    MEABStateUpdateSuccess = 0, //更新通讯录成功
    MEABStateUpdateFail = 1,    //更新通讯录失败
    MEABStateUpdateCancel = 2,  //取消更新通讯录
    MEABStateUnAvailable = 3,   //系统通讯录无法访问（没有开启访问权限）
    MEABStateAvailable = 4,     //系统通讯录可以访问
};

@interface NCWWidgetInfoManager : NSObject

@property (nonatomic,assign,readonly) BOOL haveCommited;
@property (nonatomic,strong,readonly) UIImage * defaultPortrait; //缺省头像
@property (nonatomic) ABAddressBookRef mainAddressBook;
@property (nonatomic,assign) MEABState upState;

AS_SINGLETON(MEWidgetInfoManager)
//打点开启widget
//- (void)commitRegisteWidget;

+ (NSString *)groupIdentifier;
/*
 *获取访问权限
 */

//- (void)visitAddressBook;


- (BOOL)isPersonNone;

/**
 *  添加联系人信息到widget
 *
 *  @param person 联系人对象
 *  @param save   是否写入联系人信息到widget，YES：立刻写入信息，NO：不写入信息，需要手动执行saveToWidget来写入信息
 *
 *  @return YES/NO
 */
- (BOOL)addNCWItemToWidget:(id)ncwItem saveToWidget:(BOOL)save;
/**
 *  添加应用信息到widget
 *
 *  @param applicatoin 选中应用
 *  @param save   是否写入联系人信息到widget，YES：立刻写入信息，NO：不写入信息，需要手动执行saveToWidget来写入信息
 *
 *  @return YES/NO
 */
//- (BOOL)addApplicationToWidget:(NCWApplicationItem *)application saveToWidget:(BOOL)save;


/**
 *  判断联系人是否已经保存在widget里面
 *
 *  @param person 联系人对象
 *
 *  @return 是否存在
 */
//- (BOOL)isPersonAtWidget:(MEWidgetPerson *)person;

/**
 *  根据recordID判断联系人是否已经保存在widget里面
 *
 *  @param recordID 联系人recordID
 *
 *  @return 是否存在
 */
//- (BOOL)isPersonAtWidgetByRecordID:(NSInteger)recordID;





/**
 *  从widget里删除联系人信息
 *
 *  @param person 联系人对象
 *  @param save   是否写入联系人信息到widget，YES：立刻写入信息，NO：不写入信息，需要手动执行saveToWidget来写入信息
 *
 *  @return YES/NO
 */
- (BOOL)deleteFromWidget:(id )person saveWidget:(BOOL)save;


/**
 *  根据recordID从widget里删除联系人信息，删除完立即将信息保存到widget里面
 *
 *  @param recordID 联系人recordID
 *
 *  @return YES/NO
 */
//- (BOOL)deletePersonFromWidgetByRecordID:(NSInteger)recordID;



/**
 *  对widget里面的通知项列表进行排序
 *
 *  @param list 排序完后的列表
 *
 *  @return YES/NO
 */
- (BOOL)sortNCWListWithNewList:(NSArray *)list;
/**
 *  将联系人信息写入widget
 *
 *  @return YES/NO
 */
- (BOOL)saveToWidget;
/**
 *  获取保存在widget里面的联系人对象列表
 *
 *  @return 列表
 */
- (NSArray *)personListAtWidget;
/**
 *  获取联系人头像
 *
 *  @param person 联系人对象
 *
 *  @return 头像 
 */
//- (UIImage *)personPortrait:(NCWWidgetPerson *)person;
/**
 *  检查刷新widget列表
 */
//- (void)checkAndUpdatePersonList;

/**
 *将UIView转为UIImage
 */
-(UIImage*)convertViewToImage:(UIView *) view;

/**
 *判断字符串是否都是汉字
 */
-(BOOL)onlyContainChineseCharacter:(NSString *) fullName;

/**
 *判断是否都是字母
 */
-(BOOL)onlyContainLetter:(NSString *)fullName;

/**
 *图标地址获取
 */
- (void)requestApplicationInfo:(NCWApplicationItem *)appItem complete:(NCWApplicationInfoResponse)applicationInfo;
- (void)clearRequestQueue;


//- (UIImage *)personProtraitByRecordID:(NSInteger)recordID;
@end
