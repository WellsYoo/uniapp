#import <UIKit/UIKit.h>
#import "CGJAlertViewControllerTransitionStyle.h"

@interface CGJAlertViewDismissalAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property CGJAlertViewControllerTransitionStyle transitionStyle;
@property CGFloat duration;

@end
