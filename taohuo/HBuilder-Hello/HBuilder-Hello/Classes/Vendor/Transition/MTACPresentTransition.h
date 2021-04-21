//
//  MTACPresentTransition.h
//  MTAccount
//
//  Created by LWB on 2018/7/2.
//

#import <Foundation/Foundation.h>

@protocol MTACPresentTransitional <NSObject>

- (void)presentAnimation;
- (void)dismissAnimation;

@end

@interface MTACPresentTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresent;

@end
