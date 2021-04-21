//
//  NCWBaseAppViewController.m
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "NCWBaseAppViewController.h"
#import "NCWDialog.h"

#import "NCWWidgetInfoManager.h"

#define kSoftwareCellHeaderHeight   20.0f
#define kUndefineTitleIndex         @"#"

@implementation NCWBaseAppViewController
@synthesize delegate = _delegate;
@synthesize superNavigationController = _superNavigationController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    
    _tableData = [NSMutableArray array];
    _sectionGroup = [NSMutableArray array];
    _sectionTitles = [NSMutableArray array];
    _searchResults = [NSMutableArray array];
    
    [[NCWDialog Instance] showProgress:_superNavigationController];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //初始化数据
        [self initAppItems];
        
        //已选择apps
        NSMutableArray *selectedApps = [NSMutableArray array];
        if (_delegate && [_delegate respondsToSelector:@selector(applicationController:selecedAppsWhichIsSystem:)]) {
            NSArray *apps = [_delegate applicationController:self selecedAppsWhichIsSystem:_isSystem];
            [selectedApps addObjectsFromArray:apps];
        }
        //数据排序  q
        NSMutableArray *commonApps = [NSMutableArray array]; //常用
        for (NCWApplicationItem *appItem in _tableData) {
            //是否已选择
            for (NCWApplicationItem *selectedApp in selectedApps) {
//            BOOL shouldBreak = NO;//有子功能不查询主功能是否已选中
                for (NCWApplicationItem *subItem in appItem.subItems) {
                    if ([subItem isEqual:selectedApp]) {
                        subItem.isChecked = YES;
                    }
                }
                if ([appItem isEqual:selectedApp]) {
                    appItem.isChecked = YES;
                    break;
                }
            }
            //是否常用，添加至常用数组
            if (appItem.isCommon) {
                [commonApps addObject:appItem];
                continue;
            }
            //添加title索引
            if (appItem.titleIndex == nil) {
                char firstLetter = pinyinFirstLetter([appItem.title characterAtIndex:0]);
                if ((firstLetter > 96 && firstLetter < 123) || (firstLetter > 64 && firstLetter < 91)) {
                    appItem.titleIndex = [[NSString stringWithFormat:@"%c", firstLetter] uppercaseString];
                }else {
                    appItem.titleIndex = kUndefineTitleIndex;
                }
            }
        }
        NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"titleIndex" ascending:YES]];
        [_tableData sortUsingDescriptors:sortDescriptors];
        if (commonApps.count) {
            [_sectionTitles addObject:@"常用"];
            
            NSDictionary *commmonDictionary = @{kGroupSectionTitle:[_sectionTitles objectAtIndex:0],
                                                kGroupItems:commonApps};
            [_sectionGroup addObject:commmonDictionary];
        }
        for (NCWApplicationItem *appItem in _tableData) {
            if (![_sectionTitles containsObject:appItem.titleIndex] && appItem.titleIndex) {
                [_sectionTitles addObject:appItem.titleIndex];
            }
        }
        //数据分组
        NSInteger startIndex = 0;
        if (commonApps.count) {
            startIndex = 1;
        }
        for (NSInteger i = startIndex; i < _sectionTitles.count; i++) {
            NSString *appTitleIndex = [_sectionTitles objectAtIndex:i];
            NSMutableArray *appItems = [NSMutableArray array];
            for (NCWApplicationItem *app in _tableData) {
                if ([app.titleIndex isEqualToString:appTitleIndex] && !app.isCommon) {
                    [appItems addObject:app];
                }
            }
            NSDictionary *groupDictionary = @{kGroupSectionTitle:appTitleIndex,
                                              kGroupItems:appItems};
            [_sectionGroup addObject:groupDictionary];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //界面
            _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            _tableView.dataSource = self;
            _tableView.delegate = self;
            _tableView.tableFooterView = [[UIView alloc] init];
            [self.view addSubview:_tableView];
            
            [[NCWDialog Instance] hideProgress];
//            [self loadAppIcon];
        });
    });
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_tableView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 45)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NCWWidgetInfoManager sharedInstance] clearRequestQueue];
}

- (void)initAppItems
{
    
}

- (void)reloadData
{
//    [_searchResults removeAllObjects];
    [_tableView reloadData];
}

//- (void)loadAppIcon
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSMutableArray *tempApps = [NSMutableArray array];
//        NSString *requestUrl = kIconResourceUrl;
//        for (NCWApplicationItem *appItem in _tableData) {
//            if (appItem.isFromInstalled) {
//                if ([appItem.appId integerValue]) {
//                    requestUrl = [NSString stringWithFormat:@"%@%@;", requestUrl, appItem.appId];
//                    [tempApps addObject:appItem];
//                }
//            }
//        }
//        @try {
//            NSURL *url = [NSURL URLWithString:[requestUrl substringToIndex:requestUrl.length - 1]];
//            NSData *json = [NSData dataWithContentsOfURL:url];
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:NULL];
//            NSDictionary *result = [dict objectForKey:@"Result"];
//            NSArray *items = [result objectForKey:@"items"];
//            for (NSInteger i = 0; i < tempApps.count; i++) {
//                NCWApplicationItem *appItem = [tempApps objectAtIndex:i];
//                for (NSDictionary *dictionary in items) {
//                    NSString *iconUrl = [dictionary objectForKey:@"icon"];
//                    NSString *bundleId = [dictionary objectForKey:@"identifer"];
////                    NSString *resId = [dictionary objectForKey:@"resId"];
//                    if ([bundleId isEqualToString:appItem.bundleId]) {
//                        appItem.iconUrl = iconUrl;
//                        appItem.isLoaded = YES;
//                        break;
//                    }
//                }
//            }
//        }
//        @catch (NSException *exception) {
//            
//        }
//        @finally {
//            
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if ([_delegate applicationControllerBeginSearch]) {
//                __weak UITableView *tableView = [_delegate applicationControllerSearchResultTableView];
//                [tableView reloadData];
//            }else {
//                [_tableView reloadData];
//            }
//        });
//    });
//}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //search
    if ([_delegate applicationControllerBeginSearch]) {
        return 1;
    }
    //normal
    return _sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    __weak UITableView *searchResultTableView = [_delegate applicationControllerSearchResultTableView];
    if ([_delegate applicationControllerBeginSearch] &&
        searchResultTableView == tableView) {
        //search
        [_searchResults removeAllObjects];
        NSString *keyword = [_delegate applicationControllerSearchKeyWord];
        for (NCWApplicationItem *appItem in _tableData) {
            for (NSInteger i = 0; i < keyword.length; i++) {
                char subWord = [keyword characterAtIndex:i];
                if ((subWord > 96 && subWord < 123) || (subWord > 64 && subWord < 91)) {
                    NSString *capKeyword = [[NSString stringWithFormat:@"%c", subWord] capitalizedString];
                    NSString *lowKeyword = [[NSString stringWithFormat:@"%c", subWord] lowercaseString];
                    if ([appItem.title containsString:capKeyword] || [appItem.title containsString:lowKeyword]) {
                        if (![_searchResults containsObject:appItem]) {
                            [_searchResults addObject:appItem];
                        }
                    }
                }
            }
            if ([appItem.title containsString:keyword]) {
                if (![_searchResults containsObject:appItem]) {
                    [_searchResults addObject:appItem];
                }
            }
        }
        return _searchResults.count;
    }else {
        //normal
        NSDictionary *groupDictionary = [_sectionGroup objectAtIndex:section];
        NSMutableArray *appItems = [groupDictionary objectForKey:kGroupItems];
        return appItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ApplicationCell";
    NCWSoftwareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NCWSoftwareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setDelegate:self];
    }
    //search
    if ([_delegate applicationControllerBeginSearch]) {
        __weak UITableView *searchResultTableView = [_delegate applicationControllerSearchResultTableView];
        if (searchResultTableView == tableView) {
            NCWApplicationItem *appItem = [_searchResults objectAtIndex:indexPath.row];
            [cell setAppItem:appItem];
            return cell;
        }
    }
    //normal
    NSDictionary *groupDictionary = [_sectionGroup objectAtIndex:indexPath.section];
    NSMutableArray *appItems = [groupDictionary objectForKey:kGroupItems];
    NCWApplicationItem *appItem = [appItems objectAtIndex:indexPath.row];
    [cell setAppItem:appItem];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //search
    if ([_delegate applicationControllerBeginSearch]) {
        __weak UITableView *searchResultTableView = [_delegate applicationControllerSearchResultTableView];
        if (searchResultTableView == tableView) {
            NCWApplicationItem *appItem = [_searchResults objectAtIndex:indexPath.row];
            if (appItem.isExpress && appItem.subItems.count) {
                NSInteger count = appItem.subItems.count / kSoftwareTableViewCellMaxCount;
                if (appItem.subItems.count % kSoftwareTableViewCellMaxCount) {
                    count++;
                }
                return kSoftwareTableViewCellHeight + kSoftwareTableViewCellMoreHeight * count;
            }
            return kSoftwareTableViewCellHeight;
        }
    }
    //normal
    NSDictionary *groupDictionary = [_sectionGroup objectAtIndex:indexPath.section];
    NSMutableArray *appItems = [groupDictionary objectForKey:kGroupItems];
    NCWApplicationItem *appItem = [appItems objectAtIndex:indexPath.row];
    
    if (appItem.isExpress && appItem.subItems.count) {
        NSInteger count = appItem.subItems.count / kSoftwareTableViewCellMaxCount;
        if (appItem.subItems.count % kSoftwareTableViewCellMaxCount) {
            count++;
        }
        return kSoftwareTableViewCellHeight + kSoftwareTableViewCellMoreHeight * count;
    }
    return kSoftwareTableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_delegate applicationControllerBeginSearch]) {
        return 0;
    }
    return kSoftwareCellHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_delegate applicationControllerBeginSearch]) {
        return [[UIView alloc] init];
    }
    //normal
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kSoftwareCellHeaderHeight)];
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, CGRectGetWidth(headerView.frame) - 24, kSoftwareCellHeaderHeight)];
    [titleLb setFont:[UIFont systemFontOfSize:12]];
    [titleLb setBackgroundColor:[UIColor clearColor]];
    [headerView setBackgroundColor:[UIColor colorWithHexString:@"efeff4"]];
    [headerView addSubview:titleLb];
    
    //分隔线
    CGSize size = headerView.frame.size;
    float lineHeight = 1.0 / [UIScreen mainScreen].scale;
    UIView *bottomSplitLine = [[UIView alloc] initWithFrame:CGRectMake(0, size.height - lineHeight, size.width, lineHeight)];
    bottomSplitLine.backgroundColor = [UIColor colorWithRed:0.85 green:0.87 blue:0.89 alpha:1.0];
    [headerView addSubview:bottomSplitLine];
    if (section) {
        UIView *topSplitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, lineHeight)];
        topSplitLine.backgroundColor = [UIColor colorWithRed:0.85 green:0.87 blue:0.89 alpha:1.0];
        [headerView addSubview:topSplitLine];
    }
    
//    NSDictionary *groupDictionary = [_sectionGroup objectAtIndex:section];
    NSString *appTitleIndex = [_sectionTitles objectAtIndex:section];
    [titleLb setText:appTitleIndex];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NCWApplicationItem *appItem = nil;
    if ([_delegate applicationControllerBeginSearch]) {
        appItem = [_searchResults objectAtIndex:indexPath.row];
    }else {
        NSDictionary *groupDictionary = [_sectionGroup objectAtIndex:indexPath.section];
        NSMutableArray *appItems = [groupDictionary objectForKey:kGroupItems];
        appItem = [appItems objectAtIndex:indexPath.row];
    }
    
    if (appItem.subItems.count) {
        appItem.isExpress = !appItem.isExpress;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else {
        if (!appItem.isChecked) {
            if ([_delegate applicationControllerShouldCheck]) {
                appItem.isChecked = YES;
                if ([_delegate applicationControllerShouldCheck]) {
                    if (_delegate && [_delegate respondsToSelector:@selector(applicationController:didPressedAppItem:)]) {
                        [_delegate applicationController:self didPressedAppItem:appItem];
                    }
                }
            }
        }else {
            appItem.isChecked = NO;
            if (_delegate && [_delegate respondsToSelector:@selector(applicationController:didPressedAppItem:)]) {
                [_delegate applicationController:self didPressedAppItem:appItem];
            }
        }
        [tableView reloadData];
    }
}

#pragma mark - NCWSoftwareTableViewCell Delegate

- (void)softwareTableViewCell:(NCWSoftwareTableViewCell *)cell didPressedAtItem:(NCWApplicationItem *)appItem
{
    if (!appItem.isChecked) {
        if ([_delegate applicationControllerShouldCheck]) {
            appItem.isChecked = YES;
            if ([_delegate applicationControllerShouldCheck]) {
                if (_delegate && [_delegate respondsToSelector:@selector(applicationController:didPressedAppItem:)]) {
                    [_delegate applicationController:self didPressedAppItem:appItem];
                }
            }
        }
    }else {
        appItem.isChecked = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(applicationController:didPressedAppItem:)]) {
            [_delegate applicationController:self didPressedAppItem:appItem];
        }
    }
    if ([_delegate applicationControllerBeginSearch]) {
        __weak UITableView *tableView = [_delegate applicationControllerSearchResultTableView];
        [tableView reloadData];
    }else {
        [_tableView reloadData];
    }
}

@end
