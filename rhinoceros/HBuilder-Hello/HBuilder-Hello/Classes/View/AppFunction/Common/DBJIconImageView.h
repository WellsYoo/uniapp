//
//  NCWIconImageView.h
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/15.
//  Copyright © 2015年 91. All rights reserved.
//

#import "DBJApplicationItem.h"
#import "DBJWidgetPerson.h"
@interface DBJIconImageView : UIImageView

- (void)setNCWAppItem:(DBJApplicationItem *)appItem;
- (void)setNCWAppItem:(DBJApplicationItem *)appItem needSave:(BOOL)save;
-(void)setNCWPersonImage:(DBJWidgetPerson *) person;

@end
