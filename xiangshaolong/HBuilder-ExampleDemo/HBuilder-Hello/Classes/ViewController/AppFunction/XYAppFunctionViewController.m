//
//  AppFunctionViewController.m
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "XYAppFunctionViewController.h"
#import "XYApplicationViewController.h"
#import "SFSstemtViewController.h"

#import "CCaseNavigationController.h"
#import "XSLWidgetInfoManager.h"
#import "XSLReallyManager.h"

#import "HMYDialog.h"

@interface XYAppFunctionViewController () <NCWBaseAppViewControllerDelegate,
//                                            UISearchBarDelegate,
                                            UISearchDisplayDelegate>
{
    UIButton                  *_doneButton;
    UISearchBar               *_searchBar;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    UISearchDisplayController *_searchDisplay;
#pragma clang diagnostic pop
    UIView                    *_searchBackgroundView;
    
    NSMutableArray     *_selectedApps;
    NSMutableArray     *_removeApps;
}

@end

@implementation XYAppFunctionViewController
@synthesize listHeadTitles = _listHeadTitles;
@synthesize listBodyViewControllers = _listBodyViewControllers;

- (instancetype)init
{
    self = [super init];
    if (self) {
        BOOL shouldBeReally = [[XSLReallyManager sharedInstance] shouleBeReally];
        if (shouldBeReally) {
            _listHeadTitles = @[@"已安装应用", @"系统应用"];
        }else {
            _listHeadTitles = @[@"常用应用", @"系统应用"];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    
    _listBodyViewControllers = [NSMutableArray array];
    //已选中application
    _selectedApps = [NSMutableArray array];
    _removeApps = [NSMutableArray array];
    for (id item in [[XSLWidgetInfoManager sharedInstance] personListAtWidget]) {
        if ([item isKindOfClass:[YXpplicationItem class]]) {
            [_selectedApps addObject:item];
        }
    }
    
    //NavigationController
    CCaseNavigationController *navigationController = (CCaseNavigationController *)self.navigationController;
    [navigationController addPartingLine];
    
    //是否变身
    BOOL shouldBeReally = [[XSLReallyManager sharedInstance] shouleBeReally];
    if (shouldBeReally) {
        self.title = @"选择APP和功能";
        
        _listHeadView = [[YOListHeadView alloc] initWithFrame:CGRectMake(12, 0, CGRectGetWidth(self.view.frame) - 2 * 12, kListHeadHeight)];
        _listHeadView.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        _listHeadView.clipsToBounds = YES;
        _listHeadView.listDelegate = self;
        _listHeadView.array = self.listHeadTitles;
        _listHeadView.defaultIndex = 0;
        [self.view addSubview:_listHeadView];
        
        _listBodyView = [[YOListBodyView alloc] initWithFrame:CGRectMake(0, kListHeadHeight, CGRectGetWidth(self.view.frame),
                                                                          CGRectGetHeight(self.view.frame) - kListHeadHeight)];
    }else {
        self.title = @"选择功能";
        _listBodyView = [[YOListBodyView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),
                                                                          CGRectGetHeight(self.view.frame))];
    }
    
    _listBodyView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _listBodyView.navigationController = self.navigationController;
    _listBodyView.listDelegate = self;
    _listBodyView.defaultIndex = 0;
    [self.view addSubview:_listBodyView];
    
    //done button
    UIView *topBorder = [[UIView alloc] init];
    [topBorder setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0.5)];
    [topBorder setBackgroundColor:[UIColor colorWithHexString:@"e1e1e1"]];
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButton setBackgroundColor:[UIColor whiteColor]];
    [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [_doneButton setTitleColor:[UIColor colorWithHexString:@"2e92ff"] forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(doneButtonPressHandler:) forControlEvents:UIControlEventTouchUpInside];
    [_doneButton addSubview:topBorder];
    [self.view addSubview:_doneButton];
    
    //search button
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:kNCWBundleImage(@"icon_search") forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 32, 20)];
    [rightBtn addTarget:self action:@selector(navigationBarRightBtnCallback:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    UIBarButtonItem *fixBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixBarItem.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:fixBarItem, rightItem, nil];
    
    //back button
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:kNCWBundleImage(@"bar_back_normal") forState:UIControlStateNormal];
    [leftBtn setImage:kNCWBundleImage(@"bar_back_selected") forState:UIControlStateHighlighted];
    [leftBtn setFrame:CGRectMake(0, 0, 25, 18)];
    [leftBtn addTarget:self action:@selector(naivgationBarLeftBtnCallback:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftItem, nil];
    
    //search view
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kListHeadHeight)];
    _searchBar.alpha = 0;
    _searchBar.hidden = YES;
//    _searchBar.delegate = self;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    _searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
#pragma clang diagnostic pop
    _searchDisplay.delegate = self;
    _searchDisplay.searchResultsTableView.tableFooterView = [[UIView alloc] init];
    _searchDisplay.searchResultsTableView.backgroundColor = [UIColor clearColor];
    _searchBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    _searchBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _searchBackgroundView.hidden = YES;
    [self.view addSubview:_searchBackgroundView];
    [self.view addSubview:_searchBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //是否变身
//    BOOL shouldBeReally = [[NCWReallyManager sharedInstance] shouleBeReally];
//    if (shouldBeReally) {
        [_doneButton setFrame:CGRectMake(0, CGRectGetMaxY(_listBodyView.frame) - 45, CGRectGetWidth(self.view.frame), 45)];
//    }else {
//        [_doneButton setFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 110, CGRectGetWidth(self.view.frame), 45)];
//    }
}

- (void)navigationBarRightBtnCallback:(id)sender
{
    [_searchBar setHidden:NO];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3f animations:^{
        _searchBar.alpha = 1;
    }completion:^(BOOL finished){
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [_searchBar becomeFirstResponder];
    }];
    [_searchDisplay setActive:YES animated:YES];
}

- (void)naivgationBarLeftBtnCallback:(id)sender
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - ListHeadView Delegate

- (NSInteger)listHeadViewForCount
{
    return [_listHeadTitles count];
}

- (NSInteger)listHeadView:(YOListHeadView *)listHeadView forWidth:(NSInteger)index
{
    return 100;
}

- (void)listHeadView:(YOListHeadView *)listHeadView press:(UIButton *)sender
{
    [_listBodyView scrollToIndex:sender.tag];
}

#pragma mark - ListBodyView Delegate

- (NSInteger)ListBodyViewForViewControllerCount
{
    if ([_listBodyViewControllers count]) {
        return [_listBodyViewControllers count];
    }
    else {
        return [_listHeadTitles count];
    }
}

- (id)forListBodyView:(YOListBodyView *)view index:(NSInteger)index
{
    //是否变身
    BOOL shouldBeReally = [[XSLReallyManager sharedInstance] shouleBeReally];
    if (shouldBeReally) {
        NCWBaseAppViewController *viewController = nil;
        switch (index) {
            case 0:
                viewController = [[XYAppFunctionViewController alloc] init];
                break;
            case 1:
                viewController = [[NCWBaseAppViewController alloc] init];
                break;
        }
        viewController.delegate = self;
        viewController.superNavigationController = self.navigationController;
        [_listBodyViewControllers addObject:viewController];
        return viewController;
    }else {
        NCWBaseAppViewController *viewController = viewController = [[NCWBaseAppViewController alloc] init];
        viewController.delegate = self;
        viewController.superNavigationController = self.navigationController;
        [_listBodyViewControllers addObject:viewController];
        return viewController;
    }
}

- (void)scrollToIndex:(int)index
{
    [_listHeadView scrollToIndex:index];
}

- (void)viewControllerAppear:(UIViewController *)vc index:(int)index
{
    [vc viewDidAppear:YES];
    
    NCWBaseAppViewController *appViewController = (NCWBaseAppViewController *)vc;
    _searchDisplay.searchResultsDataSource = appViewController;
    _searchDisplay.searchResultsDelegate = appViewController;
}

#pragma mark - NCWBaseAppViewController Delegate

- (NSArray *)applicationController:(NCWBaseAppViewController *)appController selecedAppsWhichIsSystem:(BOOL)isSystem
{
    NSMutableArray *selectedApps = [NSMutableArray array];
    for (YXpplicationItem *appItem in _selectedApps) {
        if (isSystem) {
            if (appItem.isSystemApp) {
                [selectedApps addObject:appItem];
            }
        }else {
            if (!appItem.isSystemApp) {
                [selectedApps addObject:appItem];
            }
        }
    }
    return selectedApps;
}

- (void)applicationController:(NCWBaseAppViewController *)appController didPressedAppItem:(YXpplicationItem *)appItem
{
    if (appItem.isChecked) {
        if (![_selectedApps containsObject:appItem]) {
            [_selectedApps addObject:appItem];
        }
    }else {
        [_selectedApps removeObject:appItem];
        [_removeApps addObject:appItem];
    }
}

- (BOOL)applicationControllerShouldCheck
{
    NSInteger numOfItem = 0;
    for (id item in [[XSLWidgetInfoManager sharedInstance] personListAtWidget]) {
        if (![item isKindOfClass:[YXpplicationItem class]]) {
            numOfItem++;
        }
    }
    numOfItem += _selectedApps.count;
    if (numOfItem >= kNotificationItemMaxNum) {
        [HMYDialog toast:@"当前数量已达到上限"];
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)applicationControllerBeginSearch
{
    return _searchDisplay.isActive;
}

- (NSString *)applicationControllerSearchKeyWord
{
    return _searchBar.text;
}

- (UITableView *)applicationControllerSearchResultTableView
{
    return _searchDisplay.searchResultsTableView;
}

#pragma mark - DoneButton Callback

- (void)doneButtonPressHandler:(id)sender
{
    for (YXpplicationItem *appItem in _selectedApps) {
        [[XSLWidgetInfoManager sharedInstance] addNCWItemToWidget:appItem saveToWidget:NO];
    }
    for (YXpplicationItem *appItem in _removeApps) {
        [[XSLWidgetInfoManager sharedInstance] deleteFromWidget:appItem saveWidget:NO];
    }
    [[XSLWidgetInfoManager sharedInstance] saveToWidget];
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UISearchBar Delegate

//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    if (_searchDisplay.isActive) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark - UISearchDisplayController Delegate

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    __weak NCWBaseAppViewController *appController = [_listBodyViewControllers objectAtIndex:_listBodyView.currentIndex];
    [appController reloadData];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:0.3f animations:^{
        _searchBar.alpha = 0;
        _searchDisplay.searchResultsTableView.alpha = 0;
        _searchBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }completion:^(BOOL finished){
        [_searchBar setHidden:YES];
        [_searchBackgroundView setHidden:YES];
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    [tableView setAlpha:1];
    [tableView setContentInset:UIEdgeInsetsZero];
    [tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    _searchBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _searchBackgroundView.hidden = NO;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
//    [_searchBar endEditing:YES];
}

@end
