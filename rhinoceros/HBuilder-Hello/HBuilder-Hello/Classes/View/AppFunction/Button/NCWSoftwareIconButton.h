//
//  NCWSoftwareIconButton.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "NCWApplicationItem.h"

@class NCWSoftwareIconButton;
@protocol NCWSoftwareIconButtonDelegate <NSObject>
- (void)softwareIconButton:(NCWSoftwareIconButton *)iconButton pressedAtItem:(NCWApplicationItem *)appItem;
@end

@interface NCWSoftwareIconButton : UIControl
{
    __weak id<NCWSoftwareIconButtonDelegate> _delegate;
}
@property(nonatomic, weak) id<NCWSoftwareIconButtonDelegate> delegate;

- (void)setAppItem:(NCWApplicationItem *)appItem;
- (void)setTitleHidden:(BOOL)hidden;

@end
