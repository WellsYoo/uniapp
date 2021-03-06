//
//  ListHeadView.h
//  MobileAssist
//
//  Created by fuyongle on 14-10-13.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kListHeadHeight 50

@class YOListHeadView;

@protocol NCWListHeadViewDelegate
@required
- (NSInteger)listHeadViewForCount;
- (NSInteger)listHeadView:(YOListHeadView *)listHeadView forWidth:(NSInteger)index;
- (void)listHeadView:(YOListHeadView *)listHeadView press:(UIButton *)sender;
@end


@interface YOListHeadView : UIView <UIScrollViewDelegate>
{

}

@property (nonatomic,weak    ) id<NCWListHeadViewDelegate> listDelegate;
@property (nonatomic,strong  ) NSArray                    *array;      //标题文字
@property (nonatomic,readonly) NSInteger                   currentIndex;
@property (nonatomic         ) NSUInteger                  defaultIndex;

- (void)scrollToIndex:(NSUInteger)index;
- (void)reloadView;

@end

