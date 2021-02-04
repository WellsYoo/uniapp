//
//  MEWidgetPerson.h
//  MobileExperienceStore
//
//  Created by Liyu on 15/7/31.
//  Copyright (c) 2015年 91. All rights reserved.
//

#define kWidgetPersonFirstName      @"WidgetPersonFirstName"
#define kWidgetPersonLastName       @"WidgetPersonLastName"
#define kWidgetPersonCompany        @"WidgetPersonCompany"
#define kWidgetPersonRecordID       @"WidgetPersonRecordID"
#define kWidgetPersonPhoneNumber    @"WidgetPersonPhoneNumber"
#define kWidgetPersonImageData      @"WigetPersonImageData"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>


@interface NCWWidgetPerson : NSObject

//@property (nonatomic,strong) UIImage  * protraitImage; //头像
@property (nonatomic,copy) NSString   * firstName; //
@property (nonatomic,copy) NSString   * lastName; //
@property (nonatomic,copy) NSString   * company;  //
@property (nonatomic,assign) NCWType    contactType; //号码用途
@property (nonatomic,copy) NSString   * phoneNumber; //
//@property (nonatomic,assign)NSInteger   recordID;  //联系人唯一标识符,有联系人权限才能获取到
@property (nonatomic,copy,readonly) NSString * fullName; //全名
@property (nonatomic,copy)NSString    *phoneNumberType;
@property (nonatomic, strong)NSData   *imageData;

+ (instancetype)emptyPerson;

- (instancetype)initWithData:(NSDictionary *)data;
/**
 *  根据recordID，phoneNumber,contactType判断联系人是否相同
 *
 *  @param person 联系人对象
 *
 *  @return YES/NO
 */

-(instancetype)initWithABRecordRef:(ABRecordRef)person;

- (BOOL)isEqualToPerson:(NCWWidgetPerson *)person;
/**
 *  将联系人信息转化成保存在widget信息管理里面的格式
 *
 *  @return 数据字典
 */
- (NSDictionary *)personInfoForWidget;

//-(MEWidgetPerson *)initWidgetPersonWithAddressBookPerson:(MEAddressBookPerson *)person AndPhoneNum:(NSString *)phoneNum
//                                             ContactType:(MEPersonContactType)type;

@end
