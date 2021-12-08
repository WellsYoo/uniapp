//
//  ListBodyView.m
//  MobileAssist
//
//  Created by fuyongle on 14-10-13.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "CGJListBodyView.h"
#import "FSFViewController.h"
//#import "BaseTableViewController.h"

@interface CGJListBodyView()<UIGestureRecognizerDelegate>
{
	BOOL                _isLoad;       //是否已经加载
	NSUInteger          _count;        //ViewController个数
    NSUInteger          _defaultIndex;
	NSInteger           _currentIndex;
    
    NSMutableDictionary *_dict;
}
@end

@implementation CGJListBodyView
@synthesize listDelegate;
@synthesize defaultIndex = _defaultIndex;
@synthesize currentIndex = _currentIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _isLoad = NO;
        _currentIndex = -1;
        _defaultIndex = 0;
        
        self.pagingEnabled = YES;
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        
        _dict = [[NSMutableDictionary alloc] init];
    }
    
	return self;
}

- (void)layoutSubviews
{
	if (self.listDelegate == nil) {
		return;
	}
    
    if (_isLoad) {
        return;
    }
    
    [self reloadView];
        
    _isLoad = YES;
}

- (void)clearMemory:(BOOL)shouldExcludeCurrent
{
    if (!_isLoad) {
        return;
    }
    
    NSArray *keys = _dict.allKeys;
    
    for (NSNumber *number in keys) {
        if (!(shouldExcludeCurrent && [number intValue] == _currentIndex)) {
            UIViewController *vc = [_dict objectForKey:number];
            if (vc) {
                [vc.view removeFromSuperview];
                 [_dict removeObjectForKey:number];
            }
        }
    }
    
    if (!shouldExcludeCurrent) {
        _isLoad = NO;
    }
}

- (void)reloadView
{
    NSUInteger count = [listDelegate ListBodyViewForViewControllerCount];
    
    if (count == 0) {
        return;
    }
    
    _count = count;
    
    [_dict removeAllObjects];
    self.contentSize = CGSizeMake(count*self.frame.size.width, 0);
    
    if(_currentIndex > 0 && _currentIndex < count) {
        [self loadViewController:_currentIndex];
    } else{
        [self loadViewController:_defaultIndex];
    }
}

-(void)loadViewController:(NSInteger)index
{
    [self loadViewController:index animated:NO];
}

-(void)loadViewController:(NSInteger)index animated:(BOOL)animated
{
    NSInteger lastIndex = _currentIndex;
    if (lastIndex >= 0) {
        UIViewController *lastVc = [_dict objectForKey:[NSNumber numberWithInt:lastIndex]];
//        [lastVc viewWillDisappear:YES];
        [lastVc viewDidDisappear:NO];
    }
    
     _currentIndex = index;
    [self setContentOffset:CGPointMake(_currentIndex*self.frame.size.width, 0) animated:animated];
    
    UIViewController *vc = [_dict objectForKey:[NSNumber numberWithInt:_currentIndex]];
    if (vc == nil)
    {
        id class =[listDelegate forListBodyView:self index:_currentIndex];
        if([class isKindOfClass:[UIViewController class]]) {
            vc = class;
        }
        else {
            vc = [[class alloc] init];
        }
        
        if (vc == nil) {
            return;
        }

        [_dict setObject:vc forKey:[NSNumber numberWithInt:_currentIndex]];
        vc.view.frame = CGRectMake(_currentIndex * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:vc.view];

    } else {
        [vc viewDidAppear:YES];
    }
    
    if ([listDelegate respondsToSelector:@selector(viewControllerAppear:index:)])
    {
        [listDelegate viewControllerAppear:vc index:_currentIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = self.contentOffset.x - _currentIndex*scrollView.frame.size.width;
    if (offsetX != 0) {
        
        int index = (offsetX > 0) ? _currentIndex + 1 : _currentIndex - 1;
        if (index >= 0 && index < _count) {
            [listDelegate scrollToIndex:index];
            [self loadViewController:index animated:YES];
        }
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
//{
////	if (listdelegate &&[listdelegate respondsToSelector:@selector(synScroll:)])
////	{
////		[listdelegate synScroll:self.contentOffset.x];
////	}
//}

-(void)scrollToIndex:(NSUInteger)index
{
    if (index >= _count) {
        return;
    }
    
    [self loadViewController:index animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	if (_count!=0)
	{
		UIViewController *vc=[_dict objectForKey:[NSNumber numberWithInt:_currentIndex]];
		if (vc)
		{
			[vc viewWillAppear:animated];
		}
	}
}
// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated
{
	if (_count!=0)
	{
		UIViewController *vc=[_dict objectForKey:[NSNumber numberWithInt:_currentIndex]];
		if (vc)
		{
			[vc viewWillDisappear:animated];
		}
	}
}

@end
