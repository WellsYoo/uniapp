//
//  GSSpringboardCell.h
//  MobileExperienceStore
//
//  Created by Liyu on 15/7/31.
//  Copyright (c) 2015年 91. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBJWidgetPerson.h"

@protocol GSSpringboardCellDelegate;

@interface DBJSpringboardCell : UICollectionViewCell

@property (nonatomic,assign) BOOL sbEditing;
@property (nonatomic,weak) id<GSSpringboardCellDelegate> delegate;

- (void)bindPerson:(DBJWidgetPerson *)person;
@end

@protocol GSSpringboardCellDelegate <NSObject>

@optional

- (void)gs_sbCellDidDeleted:(DBJSpringboardCell *)cell;

@end