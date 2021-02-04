//
//  ListHeadView.h
//  MobileAssist
//
//  Created by fuyongle on 14-10-13.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kListHeadHeight 50

@class NCWListHeadView;

@protocol NCWListHeadViewDelegate
@required
- (NSInteger)listHeadViewForCount;
- (NSInteger)listHeadView:(NCWListHeadView *)listHeadView forWidth:(NSInteger)index;
- (void)listHeadView:(NCWListHeadView *)listHeadView press:(UIButton *)sender;
@end


@interface NCWListHeadView : UIView <UIScrollViewDelegate>
{

}

@property (nonatomic,weak    ) id<NCWListHeadViewDelegate> listDelegate;
@property (nonatomic,strong  ) NSArray                    *array;      //标题文字
@property (nonatomic,readonly) NSInteger                   currentIndex;
@property (nonatomic         ) NSUInteger                  defaultIndex;

- (void)scrollToIndex:(NSUInteger)index;
- (void)reloadView;

@end

