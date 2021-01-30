//
//  AppFunctionViewController.h
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "NCWBaseViewController.h"
#import "NCWListHeadView.h"
#import "NCWListBodyView.h"

#define kHeadViewHeight (45 * (SCREEN_WIDTH / 320))

@interface NCWAppFunctionViewController : NCWBaseViewController <NCWListHeadViewDelegate, NCWListBodyViewDelegate>
{
    NCWListHeadView *_listHeadView;
    NCWListBodyView *_listBodyView;
    
    NSArray        *_listHeadTitles;
    NSMutableArray *_listBodyViewControllers;
}

@property(nonatomic, retain) NSArray        *listHeadTitles;
@property(nonatomic, retain) NSMutableArray *listBodyViewControllers;

@end
