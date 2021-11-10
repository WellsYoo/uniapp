//
//  MTAppRequest.h
//  MTAppCommunication
//
//  Created by JoyChiang on 13-3-13.
//  Copyright (c) 2013年 Meitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MTAppMessage.h"

@class EGAppClient;

@interface HMYAppRequest : NSObject

@property (nonatomic, copy, readonly) NSString *requestID;

@property (nonatomic, retain) EGAppClient *client;

@property (nonatomic, copy) NSString *action;
@property (nonatomic, strong) EGAppRequestMessage *requestMessage;

@property (nonatomic, copy) void(^successCalback)(EGAppResponseMessage
*message);
@property (nonatomic, copy) void(^errorCalback)(NSError *);

@end


