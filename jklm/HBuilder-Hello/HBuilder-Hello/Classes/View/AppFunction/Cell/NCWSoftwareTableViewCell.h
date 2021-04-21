//
//  NCWSoftwareTableViewCell.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "NCWApplicationItem.h"

#define kSoftwareTableViewCellHeight     50.0f
#define kSoftwareTableViewCellMoreHeight 68.0f
#define kSoftwareTableViewCellMaxCount   5

@class NCWSoftwareTableViewCell;
@protocol NCWSoftwareTableViewCellDelegate <NSObject>
- (void)softwareTableViewCell:(NCWSoftwareTableViewCell *)cell didPressedAtItem:(NCWApplicationItem *)appItem;
@end

@interface NCWSoftwareTableViewCell : UITableViewCell
{
    __weak id<NCWSoftwareTableViewCellDelegate> _delegate;
}
@property(nonatomic, weak) id<NCWSoftwareTableViewCellDelegate> delegate;

- (void)setAppItem:(NCWApplicationItem *)appItem;

@end
