#import <UIKit/UIKit.h>
#import "NYAlertViewControllerTransitionStyle.h"

@interface HMYAlertViewDismissalAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property NYAlertViewControllerTransitionStyle transitionStyle;
@property CGFloat duration;

@end
