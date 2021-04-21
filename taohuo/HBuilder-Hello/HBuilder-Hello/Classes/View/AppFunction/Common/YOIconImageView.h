//
//  NCWIconImageView.h
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/15.
//  Copyright © 2015年 91. All rights reserved.
//

#import "YXpplicationItem.h"
#import "SFWWidgetPerson.h"
@interface YOIconImageView : UIImageView

- (void)setNCWAppItem:(YXpplicationItem *)appItem;
- (void)setNCWAppItem:(YXpplicationItem *)appItem needSave:(BOOL)save;
-(void)setNCWPersonImage:(SFWWidgetPerson *) person;

@end
