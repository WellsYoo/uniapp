//
//  MEWidgetPerson.m
//  MobileExperienceStore
//
//  Created by Liyu on 15/7/31.
//  Copyright (c) 2015年 91. All rights reserved.
//

#import "CCWidgetPerson.h"
#import "CGJWidgetInfoManager.h"

@implementation CCWidgetPerson
@synthesize fullName = _fullName;

+ (instancetype)emptyPerson
{
    CCWidgetPerson * person = [[CCWidgetPerson alloc] init];
    return person;
}

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.firstName = [data objectForKey:kWidgetPersonFirstName];
        self.lastName = [data objectForKey:kWidgetPersonLastName];
        self.company = [data objectForKey:kWidgetPersonCompany];
        self.phoneNumber = [data objectForKey:kWidgetPersonPhoneNumber];
//        self.recordID = [[data objectForKey:kWidgetPersonRecordID] integerValue];
        self.contactType = [[data objectForKey:kNcwType] integerValue];
        self.imageData = [data objectForKey:kWidgetPersonImageData];
    }
    return self;
}


-(instancetype)initWithABRecordRef:(ABRecordRef)person{
    self = [super init];
    if (self){
//        NSInteger recordID = ABRecordGetRecordID(person);       //需要获取通讯录权限
//        _recordID = recordID;
        
        
        NSString * firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString * lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSString * company = CFBridgingRelease(ABRecordCopyValue(person, kABPersonOrganizationProperty));

        _firstName = firstName.length > 0?[NSString stringWithFormat:@"%@",firstName]:@"";
        
        _lastName = lastName.length > 0?[NSString stringWithFormat:@"%@",lastName]:@"";
        
        _company = company.length > 0?[NSString stringWithFormat:@"%@",company]:@"";
    
        
        BOOL haveImage =   ABPersonHasImageData(person);
        if (haveImage) {
            _imageData = (__bridge_transfer NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
        }
    }
    return self;
}
//- (UIImage *)protraitImage
//{
//    _protraitImage = [[NCWWidgetInfoManager sharedInstance] personPortrait:self];
//    return _protraitImage;
//}

- (NSString *)fullName
{
    
//    if (self.lastName.length == 0 && self.firstName.length == 0) {
//        _fullName = (self.company.length > 0)?self.company:@"";
//    }
     if (self.lastName.length == 0)
    {
        _fullName = self.firstName;
    }
    else if (self.firstName.length == 0)
    {
        _fullName = self.lastName;
    }
    else
    {
        _fullName = [NSString stringWithFormat:@"%@%@",self.lastName,self.firstName];
    }
 
    if ([_fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0&&self.phoneNumber.length > 0) {
        _fullName = self.phoneNumber;
    }
    
    return _fullName;
}

- (BOOL)isEqualToPerson:(CCWidgetPerson *)person
{
    if (!person) {
        return NO;
    }
    if (self.contactType == person.contactType && [self.phoneNumber isEqualToString:person.phoneNumber]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSDictionary *)personInfoForWidget
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSString * firstName = self.firstName?:@"";
    NSString * lastName = self.lastName?:@"";
    NSString * company = self.company?:@"";
    NSString * phoneNumber = self.phoneNumber?:@"";
    [dict setObject:firstName forKey:kWidgetPersonFirstName];
    [dict setObject:lastName forKey:kWidgetPersonLastName];
    [dict setObject:company forKey:kWidgetPersonCompany];
//    [dict setObject:@(self.recordID) forKey:kWidgetPersonRecordID];
    [dict setObject:phoneNumber forKey:kWidgetPersonPhoneNumber];
    [dict setObject:@(self.contactType) forKey:kNcwType];
    if (_imageData) {
          [dict setObject:_imageData forKey:kWidgetPersonImageData];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}






- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self) {
        self.firstName = [coder decodeObjectForKey:kWidgetPersonFirstName];
        self.lastName = [coder decodeObjectForKey:kWidgetPersonLastName];
        self.company = [coder decodeObjectForKey:kWidgetPersonCompany];
        self.phoneNumber = [coder decodeObjectForKey:kWidgetPersonPhoneNumber];
//        self.recordID = [coder decodeIntegerForKey:kWidgetPersonRecordID];
        self.contactType = [coder decodeIntegerForKey:kNcwType];
        self.imageData = [coder decodeObjectForKey:kWidgetPersonImageData];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_firstName forKey:kWidgetPersonFirstName];
    [aCoder encodeObject:_lastName forKey:kWidgetPersonLastName];
    [aCoder encodeObject:_company forKey:kWidgetPersonCompany];
    [aCoder encodeObject:_phoneNumber forKey:kWidgetPersonPhoneNumber];
//    [aCoder encodeInteger:_recordID forKey:kWidgetPersonRecordID];
    [aCoder encodeInteger:_contactType forKey:kNcwType];
    [aCoder encodeObject:_imageData forKey:kWidgetPersonImageData];
}
@end
