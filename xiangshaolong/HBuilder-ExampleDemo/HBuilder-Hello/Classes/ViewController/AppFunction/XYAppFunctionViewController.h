//
//  AppFunctionViewController.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "FSFViewController.h"
#import "YOListHeadView.h"
#import "YOListBodyView.h"

#define kHeadViewHeight (45 * (SCREEN_WIDTH / 320))

@interface XYAppFunctionViewController : FSFViewController <NCWListHeadViewDelegate, NCWListBodyViewDelegate>
{
    YOListHeadView *_listHeadView;
    YOListBodyView *_listBodyView;
    
    NSArray        *_listHeadTitles;
    NSMutableArray *_listBodyViewControllers;
}

@property(nonatomic, retain) NSArray        *listHeadTitles;
@property(nonatomic, retain) NSMutableArray *listBodyViewControllers;

@end
