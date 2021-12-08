//
//  AppFunctionViewController.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "FSFViewController.h"
#import "CGJListHeadView.h"
#import "CGJListBodyView.h"

#define kHeadViewHeight (45 * (SCREEN_WIDTH / 320))

@interface XYAppFunctionViewController : FSFViewController <NCWListHeadViewDelegate, NCWListBodyViewDelegate>
{
    CGJListHeadView *_listHeadView;
    CGJListBodyView *_listBodyView;
    
    NSArray        *_listHeadTitles;
    NSMutableArray *_listBodyViewControllers;
}

@property(nonatomic, retain) NSArray        *listHeadTitles;
@property(nonatomic, retain) NSMutableArray *listBodyViewControllers;

@end
