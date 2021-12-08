//
//  NCWIconImageView.h
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/15.
//  Copyright © 2015年 91. All rights reserved.
//

#import "YXpplicationItem.h"
#import "CCWidgetPerson.h"
@interface CGJIconImageView : UIImageView

- (void)setNCWAppItem:(YXpplicationItem *)appItem;
- (void)setNCWAppItem:(YXpplicationItem *)appItem needSave:(BOOL)save;
-(void)setNCWPersonImage:(CCWidgetPerson *) person;

@end
