//
//  BaseScrollView.m
//  MobileExperience
//  自定义滚动View(增加一些自定义处理)
//  Created by fuyongle on 14-6-11.
//  Copyright (c) 2014年 NetDragon. All rights reserved.
//

#import "DBJScrollView.h"

@implementation DBJScrollView

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (_allowBounce) {
        return YES;
    }
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        CGPoint point = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        
        // 限制ScrollView在contentSize内滑动
        if ((self.contentOffset.x <= 0  && (point.x > 0)) ||
            (self.contentOffset.x >= self.contentSize.width - self.bounds.size.width && (point.x < 0))) {
            return NO;
        }
    }
    
    return YES;
}

@end
