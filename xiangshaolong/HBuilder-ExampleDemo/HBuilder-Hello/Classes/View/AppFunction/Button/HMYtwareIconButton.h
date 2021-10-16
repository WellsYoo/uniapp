//
//  NCWSoftwareIconButton.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "YXpplicationItem.h"

@class HMYtwareIconButton;
@protocol YCuttonDelegate <NSObject>
- (void)softwareIconButton:(HMYtwareIconButton *)iconButton pressedAtItem:(YXpplicationItem *)appItem;
@end

@interface HMYtwareIconButton : UIControl
{
    __weak id<YCuttonDelegate> _delegate;
}
@property(nonatomic, weak) id<YCuttonDelegate> delegate;

- (void)setAppItem:(YXpplicationItem *)appItem;
- (void)setTitleHidden:(BOOL)hidden;

@end
