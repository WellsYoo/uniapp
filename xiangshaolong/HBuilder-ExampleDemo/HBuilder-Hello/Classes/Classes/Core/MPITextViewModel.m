//
//  MPITextViewModel.m
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import "MPITextViewModel.h"
#import "MPITextInteractiveGestureRecognizer.h"
#import "MPITextLink.h"

#import "NSAttributedString+MPITextKit.h"

@interface MPITextViewModel () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<MPIAttributedTextView> textView;
@property (nonatomic, strong) MPITextInteractiveGestureRecognizer *interactiveGestureRecognizer;

@end

@implementation MPITextViewModel

- (instancetype)initWithTextView:(id<MPIAttributedTextView>)textView {
    self = [super init];
    if (self) {
        _textView = textView;
        _interactiveGestureRecognizer = [[MPITextInteractiveGestureRecognizer alloc] initWithTarget:self action:@selector(linkAction:)];
        _interactiveGestureRecognizer.delegate = self;
        [(UIView *)textView addGestureRecognizer:_interactiveGestureRecognizer];
        _activeLinkRange = NSMakeRange(NSNotFound, 0);
    }
    return self;
}

- (BOOL)hasActiveLink {
    return self.activeLinkRange.location != NSNotFound;
}

#pragma mark Gesture recognition

- (void)linkAction:(MPITextInteractiveGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self displayActiveLink];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (recognizer.result == MPITextInteractiveGestureRecognizerResultTap) {
            [self didTapAtRange:self.activeLinkRange];
        } else if (recognizer.result == MPITextInteractiveGestureRecognizerResultLongPress) {
            [self didLongPressAtRange:self.activeLinkRange];
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded ||
        recognizer.state == UIGestureRecognizerStateCancelled ||
        recognizer.state == UIGestureRecognizerStateFailed) {
        _activeLinkRange = NSMakeRange(NSNotFound, 0);
        _activeAttributedText = nil;
        
        [self notifyDidUpdateActiveAttributedText];
    }
}

#pragma mark - Private

- (NSRange)linkRangeAtPoint:(CGPoint)point inTruncation:(BOOL *)inTruncation {
    return [self.delegate textViewModel:self linkRangeAtPoint:point inTruncation:inTruncation];
}

- (NSRange)linkRangeAtPoint:(CGPoint)point {
    return [self linkRangeAtPoint:point inTruncation:NULL];
}

- (BOOL)containsLinkAtPoint:(CGPoint)point {
    return [self linkRangeAtPoint:point].location != NSNotFound;
}

- (void)notifyDidUpdateActiveAttributedText {
    [self.delegate textViewModel:self didUpdateActiveAttributedText:self.activeAttributedText];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.hasActiveLink) {
        return NO;
    }
    
    id<MPIAttributedTextView> textView = self.textView;
    CGPoint location = [gestureRecognizer locationInView:(UIView *)textView];
    
    BOOL shouldBegin = YES;
    if ([self.delegate respondsToSelector:@selector(textViewModel:shouldBeginInteractAtPoint:)]) {
        shouldBegin = [self.delegate textViewModel:self shouldBeginInteractAtPoint:location];
    }
    
    BOOL inTruncation = NO;
    NSRange activeLinkRange = NSMakeRange(NSNotFound, 0);
    if (shouldBegin) {
        activeLinkRange = [self linkRangeAtPoint:location inTruncation:&inTruncation];
    }
    
    shouldBegin = activeLinkRange.location != NSNotFound && activeLinkRange.length != 0;
    
    NSAttributedString *attributedText = textView.attributedText;
    
    if (shouldBegin && NSMaxRange(activeLinkRange) <= attributedText.length) {
        if ([textView.delegate respondsToSelector:@selector(attributedTextView:shouldInteractWithLink:forAttributedText:inRange:interaction:)]) {
            id value = [attributedText attribute:MPITextLinkAttributeName atIndex:activeLinkRange.location effectiveRange:NULL];
            if (value) {
                NSAssert([value isKindOfClass:MPITextLink.class], @"The value for MPITextLinkAttributeName must be of type MPITextLink.");
                shouldBegin = [textView.delegate attributedTextView:textView shouldInteractWithLink:value forAttributedText:attributedText inRange:activeLinkRange interaction:MPITextItemInteractionPossible];
            } else {
                shouldBegin = NO;
            }
        }
    }
    
    _activeLinkRange = activeLinkRange;
    _activeInTruncation = inTruncation;
    
    return shouldBegin;
}

#pragma mark Gesture handling

- (void)displayActiveLink {
     id<MPIAttributedTextView> textView = self.textView;
    
    NSRange activeLinkRange = self.activeLinkRange;
    if (activeLinkRange.location == NSNotFound) {
        return;
    }
    
    NSAttributedString *attributedText = self.activeInTruncation ? textView.truncationAttributedText : textView.attributedText;
    if (NSMaxRange(activeLinkRange) > attributedText.length) {
        return;
    }
    
    NSMutableAttributedString *activeLinkAttributedText = [attributedText attributedSubstringFromRange:activeLinkRange].mutableCopy;
    
    NSDictionary<NSString *, id> *textAttributes = textView.activeLinkTextAttributes;
    if ([textView.delegate respondsToSelector:@selector(attributedTextView:activeTextAttributesWithLink:forAttributedText:inRange:)]) {
        id value = [attributedText attribute:MPITextLinkAttributeName atIndex:activeLinkRange.location effectiveRange:NULL];
        NSDictionary *attributes = [textView.delegate attributedTextView:textView activeTextAttributesWithLink:value forAttributedText:attributedText inRange:activeLinkRange];
        if (attributes) {
            textAttributes = attributes;
        }
    }
    
    if (textAttributes) {
        [activeLinkAttributedText addAttributes:textAttributes range:activeLinkAttributedText.mpi_rangeOfAll];
    }
    [activeLinkAttributedText addAttribute:MPITextHighlightedAttributeName value:@(YES) range:activeLinkAttributedText.mpi_rangeOfAll];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    [attributedString replaceCharactersInRange:activeLinkRange withAttributedString:activeLinkAttributedText];
    
    _activeAttributedText = attributedString;
    
    [self notifyDidUpdateActiveAttributedText];
}

- (void)didTapAtRange:(NSRange)range {
    if (range.location == NSNotFound) {
        return;
    }
    id<MPIAttributedTextView> textView = self.textView;
    
    NSAttributedString *attributedText = self.activeInTruncation ? textView.truncationAttributedText : textView.attributedText;
    if (NSMaxRange(range) > attributedText.length) {
        return;
    }
    
    if ([textView.delegate respondsToSelector:@selector(attributedTextView:didInteractWithLink:forAttributedText:inRange:interaction:)]) {
        id value = [attributedText attribute:MPITextLinkAttributeName atIndex:range.location effectiveRange:NULL];
        [textView.delegate attributedTextView:textView didInteractWithLink:value forAttributedText:attributedText inRange:range interaction:MPITextItemInteractionTap];
    }
}

- (void)didLongPressAtRange:(NSRange)range {
    if (range.location == NSNotFound) {
        return;
    }
    id<MPIAttributedTextView> textView = self.textView;
    
    NSAttributedString *attributedText = self.activeInTruncation ? textView.truncationAttributedText : textView.attributedText;
    if (NSMaxRange(range) > attributedText.length) {
        return;
    }
    
    if ([textView.delegate respondsToSelector:@selector(attributedTextView:didInteractWithLink:forAttributedText:inRange:interaction:)]) {
        id value = [attributedText attribute:MPITextLinkAttributeName atIndex:range.location effectiveRange:NULL];
        [textView.delegate attributedTextView:textView didInteractWithLink:value forAttributedText:attributedText inRange:range interaction:MPITextItemInteractionLongPress];
    }
}

@end

