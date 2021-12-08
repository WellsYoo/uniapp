//
//  MTACPresentTransition.m
//  MTAccount
//
//  Created by LWB on 2018/7/2.
//

#import "MTACPresentTransition.h"

@implementation MTACPresentTransition 

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UINavigationController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (_isPresent) {
        id<MTACPresentTransitional> ctl = toVC.viewControllers.lastObject;
        UIView *container = [transitionContext containerView];
        [container addSubview:toVC.view];
        [fromVC beginAppearanceTransition:NO animated:YES];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            if ([ctl conformsToProtocol:@protocol(MTACPresentTransitional)]) {
                [ctl presentAnimation];
            }
        } completion:^(BOOL finished) {
            [fromVC endAppearanceTransition];
            [transitionContext completeTransition:YES];
        }];
    } else {
        id<MTACPresentTransitional> ctl = fromVC.viewControllers.lastObject;
        UIView *container = [transitionContext containerView];
        [container addSubview:fromVC.view];
        [toVC beginAppearanceTransition:YES animated:YES];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            if ([ctl conformsToProtocol:@protocol(MTACPresentTransitional)]) {
                [ctl dismissAnimation];
            }
        } completion:^(BOOL finished) {
            [toVC endAppearanceTransition];
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
