//
//  MPITextViewModel.h
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include(<MPITextKit/MPITextKit.h>)
#import <MPITextKit/MPITextViewProtocol.h>
#else
#import "MPITextViewProtocol.h"
#endif

@class MPITextKitContext;
@class MPITextInteractiveGestureRecognizer;

@protocol MPITextViewModelDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface MPITextViewModel : NSObject 

/** The gesture recognizer used to detect interactions in this text view. */
@property (nonatomic, readonly) MPITextInteractiveGestureRecognizer *interactiveGestureRecognizer;
@property (nonatomic, readonly) BOOL hasActiveLink;
@property (nonatomic, readonly) NSRange activeLinkRange;
@property (nullable, nonatomic, copy, readonly) NSAttributedString *activeAttributedText;
@property (nonatomic, readonly) BOOL activeInTruncation;

@property (nonatomic, weak) id<MPITextViewModelDelegate> delegate;

- (instancetype)initWithTextView:(id<MPIAttributedTextView>)textView;

@end

@protocol MPITextViewModelDelegate <NSObject>

- (NSRange)textViewModel:(MPITextViewModel *)viewModel linkRangeAtPoint:(CGPoint)point inTruncation:(BOOL *)inTruncation;

- (void)textViewModel:(MPITextViewModel *)viewModel didUpdateActiveAttributedText:(NSAttributedString *)activeAttributedText;

@optional

- (BOOL)textViewModel:(MPITextViewModel *)viewModel shouldBeginInteractAtPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END



