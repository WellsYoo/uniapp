//
//  NCWBaseAppViewController.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "FSFViewController.h"
#import "pinyin.h"

#import "YXpplicationItem.h"
#import "YOTableViewCell.h"

#define kGroupSectionTitle @"GroupSectionTitle"
#define kGroupItems        @"GroupItems"

@class NCWBaseAppViewController;

@protocol NCWBaseAppViewControllerDelegate <NSObject>

@required

- (NSArray *)applicationController:(NCWBaseAppViewController *)appController selecedAppsWhichIsSystem:(BOOL)isSystem;
- (BOOL)applicationControllerShouldCheck;

@optional

- (void)applicationController:(NCWBaseAppViewController *)appController didPressedAppItem:(YXpplicationItem *)appItem;

- (BOOL)applicationControllerBeginSearch;
- (NSString *)applicationControllerSearchKeyWord;
- (UITableView *)applicationControllerSearchResultTableView;

@end

@interface NCWBaseAppViewController : FSFViewController <UITableViewDataSource, UITableViewDelegate,
                                                          NCWSoftwareTableViewCellDelegate>
{
    UITableView               *_tableView;
    
    NSMutableArray            *_tableData;
    NSMutableArray            *_sectionTitles;
    NSMutableArray            *_sectionGroup;
    NSMutableArray            *_searchResults;
    BOOL                       _isSystem;
    
    __weak UINavigationController *_superNavigationController;
    __weak id<NCWBaseAppViewControllerDelegate> _delegate;
}

@property(nonatomic, weak) id<NCWBaseAppViewControllerDelegate> delegate;
@property(nonatomic, weak) UINavigationController *superNavigationController;

- (void)initAppItems;
- (void)reloadData;

@end
