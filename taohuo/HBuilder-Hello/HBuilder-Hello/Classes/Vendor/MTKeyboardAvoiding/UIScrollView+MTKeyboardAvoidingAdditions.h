//
//  UIScrollView+MTKeyboardAvoidingAdditions.h
//  MTKeyboardAvoiding
//
//  Created by Michael Tyson on 30/09/2013.
//  Copyright 2015 A Tasty Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MTKeyboardAvoidingAdditions)
- (BOOL)MTKeyboardAvoiding_focusNextTextField;
- (void)MTKeyboardAvoiding_scrollToActiveTextField;

- (void)MTKeyboardAvoiding_keyboardWillShow:(NSNotification*)notification;
- (void)MTKeyboardAvoiding_keyboardWillHide:(NSNotification*)notification;
- (void)MTKeyboardAvoiding_updateContentInset;
- (void)MTKeyboardAvoiding_updateFromContentSizeChange;
- (void)MTKeyboardAvoiding_assignTextDelegateForViewsBeneathView:(UIView*)view;
- (UIView*)MTKeyboardAvoiding_findFirstResponderBeneathView:(UIView*)view;
-(CGSize)MTKeyboardAvoiding_calculatedContentSizeFromSubviewFrames;
@end
