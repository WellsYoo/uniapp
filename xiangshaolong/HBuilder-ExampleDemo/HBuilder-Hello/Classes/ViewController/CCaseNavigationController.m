//
//  BaseNavigationController.m
//  NotificationCenterWidget
//
//  Created by YWH on 15/11/19.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "CCaseNavigationController.h"

#define kNavBarTextColor [UIColor colorWithRed:0.20 green:0.23 blue:0.23 alpha:1.0]

@interface CCaseNavigationController()
{
    UIView *_splitLine;
}


@end

@implementation CCaseNavigationController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    //去除ios6，7导航栏下面的分割线
    if (CURRENT_SYSTEM_VERSION >= 6) {
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
    
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kNavBarTextColor, NSFontAttributeName:[UIFont systemFontOfSize:20]};

    
    if (CURRENT_SYSTEM_VERSION < 7) {
        [self.navigationBar setBackgroundImage:kNCWBundleImage(@"nav_bar_background_44.png") forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationBar setBackgroundImage:kNCWBundleImage(@"nav_bar_background_64.png") forBarMetrics:UIBarMetricsDefault];
    }
}



#pragma mark - SplitLine

- (void)addPartingLine
{
    if (_splitLine == nil) {
        CGSize size = self.navigationBar.frame.size;
        float lineHeight = 1.0 / [UIScreen mainScreen].scale;
        _splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, size.height-lineHeight, size.width, lineHeight)];
        _splitLine.backgroundColor = [UIColor colorWithRed:0.85 green:0.87 blue:0.89 alpha:1.0];
        [self.navigationBar addSubview:_splitLine];
    }
}

- (void)removePartingLine
{
    if (_splitLine) {
        [_splitLine removeFromSuperview];
        _splitLine = nil;
    }
}
@end
