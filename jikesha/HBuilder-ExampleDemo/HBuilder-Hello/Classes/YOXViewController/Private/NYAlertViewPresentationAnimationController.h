#import <UIKit/UIKit.h>
#import "CGJAlertViewControllerTransitionStyle.h"

@interface NYAlertViewPresentationAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property CGJAlertViewControllerTransitionStyle transitionStyle;
@property CGFloat duration;

@end

