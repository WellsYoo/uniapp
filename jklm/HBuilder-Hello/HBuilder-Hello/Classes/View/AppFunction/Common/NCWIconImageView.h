//
//  NCWIconImageView.h
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/15.
//  Copyright © 2015年 91. All rights reserved.
//

#import "NCWApplicationItem.h"
#import "NCWWidgetPerson.h"
@interface NCWIconImageView : UIImageView

- (void)setNCWAppItem:(NCWApplicationItem *)appItem;
- (void)setNCWAppItem:(NCWApplicationItem *)appItem needSave:(BOOL)save;
-(void)setNCWPersonImage:(NCWWidgetPerson *) person;

@end
