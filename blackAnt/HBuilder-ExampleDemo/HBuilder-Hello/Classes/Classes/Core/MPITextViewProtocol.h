//
//  MPITextViewProtocol.h
//  MeituMV
//
//  Created by Tpphha on 2018/9/27.
//  Copyright © 2018年 美图网. All rights reserved.
//

#ifndef MPITextViewProtocol_h
#define MPITextViewProtocol_h

#import <UIKit/UIKit.h>
#if __has_include(<MPITextKit/MPITextKit.h>)
#import <MPITextKit/MPITextKitConst.h>
#else
#import "MPITextKitConst.h"
#endif

@class MPITextTailTruncater;
@class MPITextKitContext;
@class CCTextRenderer;
@class MPITextLink;

@protocol MPIAttributedTextViewDelegate;

@protocol MPIAttributedTextView <NSObject>

@property (nonatomic, copy) NSAttributedString *attributedText;

@property (nonatomic, copy) NSDictionary<NSString *, id> *activeLinkTextAttributes;

@property (nonatomic, readonly) NSAttributedString *truncationAttributedText;

@property (nonatomic, weak) id<MPIAttributedTextViewDelegate> delegate;

@end

@protocol MPIAttributedTextViewDelegate <NSObject>

@optional

/**
 Asks the delegate if the specified text view should allow the specified type of user interaction with the given URL in the given range of text.

 @param attributedTextView Reference textView.
 @param link MPITextLink instance.
 @param attributedText The attributedText, if link in truncation, it's truncationAttributedText.
 @param characterRange Current interactive characterRange.
 @param interaction Interaction type.
 @return YES if interaction with the URL should be allowed; NO if interaction should not be allowed.
 */
- (BOOL)attributedTextView:(id<MPIAttributedTextView>)attributedTextView shouldInteractWithLink:(MPITextLink *)link forAttributedText:(NSAttributedString *)attributedText inRange:(NSRange)characterRange interaction:(MPITextItemInteraction)interaction;

/**
 User Interacted link.
 
 @param attributedTextView Reference textView.
 @param link MPITextLink instance.
 @param attributedText The attributedText, if link in truncation, it's truncationAttributedText.
 @param characterRange Current interactive characterRange.
 @param interaction Interaction type.
 */
- (void)attributedTextView:(id<MPIAttributedTextView>)attributedTextView didInteractWithLink:(MPITextLink *)link forAttributedText:(NSAttributedString *)attributedText inRange:(NSRange)characterRange interaction:(MPITextItemInteraction)interaction;

/**
 Asks the delegate if the specified text should have another attributes when highlighted.
 
 @param attributedTextView Reference textView.
 @param link MPITextLink instance.
 @param attributedText The attributedText, if link in truncation, it's truncationAttributedText.
 @param characterRange  Current interactive characterRange。
 */
- (NSDictionary *)attributedTextView:(id<MPIAttributedTextView>)attributedTextView activeTextAttributesWithLink:(MPITextLink *)link forAttributedText:(NSAttributedString *)attributedText inRange:(NSRange)characterRange;

@end

#endif /* MPITextViewProtocol_h */
