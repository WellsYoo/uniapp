//
//  NCWSoftwareTableViewCell.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "YXpplicationItem.h"

#define kSoftwareTableViewCellHeight     50.0f
#define kSoftwareTableViewCellMoreHeight 68.0f
#define kSoftwareTableViewCellMaxCount   5

@class XSLTableViewCell;
@protocol NCWSoftwareTableViewCellDelegate <NSObject>
- (void)softwareTableViewCell:(XSLTableViewCell *)cell didPressedAtItem:(YXpplicationItem *)appItem;
@end

@interface XSLTableViewCell : UITableViewCell
{
    __weak id<NCWSoftwareTableViewCellDelegate> _delegate;
}
@property(nonatomic, weak) id<NCWSoftwareTableViewCellDelegate> delegate;

- (void)setAppItem:(YXpplicationItem *)appItem;

@end