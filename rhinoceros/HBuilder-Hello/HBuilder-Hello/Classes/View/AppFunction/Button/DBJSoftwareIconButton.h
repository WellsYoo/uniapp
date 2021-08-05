//
//  NCWSoftwareIconButton.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "DBJApplicationItem.h"

@class DBJSoftwareIconButton;
@protocol NCWSoftwareIconButtonDelegate <NSObject>
- (void)softwareIconButton:(DBJSoftwareIconButton *)iconButton pressedAtItem:(DBJApplicationItem *)appItem;
@end

@interface DBJSoftwareIconButton : UIControl
{
    __weak id<NCWSoftwareIconButtonDelegate> _delegate;
}
@property(nonatomic, weak) id<NCWSoftwareIconButtonDelegate> delegate;

- (void)setAppItem:(DBJApplicationItem *)appItem;
- (void)setTitleHidden:(BOOL)hidden;

@end
