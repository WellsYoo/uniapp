//
//  NCWReallyManager.h
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/24.
//  Copyright © 2015年 91. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBJReallyManager : NSObject

@property(nonatomic, assign) BOOL shouleBeReally;

+ (DBJReallyManager *)sharedInstance;

@end
