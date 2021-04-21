//
//  ListBodyView.h
//  MobileAssist
//
//  Created by fuyongle on 14-10-13.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOScrollView.h"

@class YOListBodyView;

@protocol NCWListBodyViewDelegate<NSObject>

@optional
- (void)scrollToIndex:(int)index;
- (void)synScroll:(int)x;
- (void)viewControllerAppear:(UIViewController *)vc index:(int)index;

@required
- (NSInteger)ListBodyViewForViewControllerCount;
- (id)forListBodyView:(YOListBodyView *)view index:(NSInteger)index;

@end

@interface YOListBodyView : YOScrollView <UIScrollViewDelegate>
{
	
}

@property (nonatomic, weak) id<NCWListBodyViewDelegate> listDelegate;
@property (nonatomic, weak) UINavigationController     *navigationController;

@property (nonatomic, assign, readonly) NSInteger  currentIndex;
@property (nonatomic, assign)           NSUInteger defaultIndex;

- (void)reloadView;

//加载某个界面
- (void)scrollToIndex:(NSUInteger)index;

- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;

- (void)clearMemory:(BOOL)shouldExcludeCurrent;


@end
