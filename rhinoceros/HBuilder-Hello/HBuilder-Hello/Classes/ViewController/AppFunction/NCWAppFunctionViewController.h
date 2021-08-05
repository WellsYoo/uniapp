//
//  AppFunctionViewController.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "NCWBaseViewController.h"
#import "DBJListHeadView.h"
#import "DBJListBodyView.h"

#define kHeadViewHeight (45 * (SCREEN_WIDTH / 320))

@interface NCWAppFunctionViewController : NCWBaseViewController <NCWListHeadViewDelegate, NCWListBodyViewDelegate>
{
    DBJListHeadView *_listHeadView;
    DBJListBodyView *_listBodyView;
    
    NSArray        *_listHeadTitles;
    NSMutableArray *_listBodyViewControllers;
}

@property(nonatomic, retain) NSArray        *listHeadTitles;
@property(nonatomic, retain) NSMutableArray *listBodyViewControllers;

@end
