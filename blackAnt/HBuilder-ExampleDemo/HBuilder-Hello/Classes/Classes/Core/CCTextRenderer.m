//
//  MPITextRenderer.m
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import "CCTextRenderer.h"
#import "MPITextKitContext.h"
#import "MPITextRenderAttributes.h"
#import "CCTextAttachmentsInfo.h"
#import "MPITextBackgroundsInfo.h"
#import "MPITextRendererKey.h"
#import "MPITextTailTruncater.h"
#import "MPITextDefaultsValueHelpers.h"
#import "MPITextCache.h"
#import "MPITextKitConst.h"

static MPITextCache *sharedTruncaterCache()
{
    static dispatch_once_t onceToken;
    static MPITextCache *truncaterCache = nil;
    dispatch_once(&onceToken, ^{
        truncaterCache = [[MPITextCache alloc] init];
        truncaterCache.countLimit = 200;
    });
    return truncaterCache;
}

static id<CCTextTruncating> truncaterForAttributes(MPITextRenderAttributes *attributes) {
    // Currently only tail is supported.
    if (attributes.lineBreakMode != NSLineBreakByTruncatingTail) {
        return nil;
    }
    
    MPITextCache *cache = sharedTruncaterCache();
    
    MPITextRendererKey *key = [[MPITextRendererKey alloc] initWithAttributes:attributes constrainedSize:CCTextContainerMaxSize];
    
    id<CCTextTruncating> truncater = [cache objectForKey:key];
    if (truncater == nil) {
        if (attributes.lineBreakMode == NSLineBreakByTruncatingTail) {
            truncater = [[MPITextTailTruncater alloc] initWithTruncationAttributedString:attributes.attributedText avoidTailTruncationSet:MPITextDefaultAvoidTruncationCharacterSet()];
        }
        if (truncater) {
            [cache setObject:truncater forKey:key];
        }
    }
    
    return truncater;
}

@interface CCTextRenderer ()

@property (nonatomic, strong) MPITextKitContext *context;

@property (nonatomic, strong) MPITextRenderAttributes *attributes;
@property (nonatomic, assign) CGSize constrainedSize;
@property (nonatomic, assign) CGSize calculatedSize;

@property (nonatomic, strong) MPITextTruncationInfo *truncationInfo;

@property (nonatomic, strong) CCTextAttachmentsInfo *attachmentsInfo;
@property (nonatomic, strong) MPITextBackgroundsInfo *backgroundsInfo;

@property (nonatomic, assign) NSRange glyphsToShow;

@end

@implementation CCTextRenderer

- (instancetype)initWithTextKitAttributes:(MPITextRenderAttributes *)attributes constrainedSize:(CGSize)constrainedSize {
    self = [super init];
    if (self) {
        _attributes = attributes;
        _constrainedSize = constrainedSize;
        
        // TextKit render incorrect by truncating. eg. text = @"/a/n/n/nb", maximumNumberOfLines = 2.
        NSLineBreakMode lineBreakMode = attributes.lineBreakMode;
        if (lineBreakMode == NSLineBreakByTruncatingTail) {
            lineBreakMode = NSLineBreakByWordWrapping;
        }
        
        NSArray<UIBezierPath *> *exclusionPaths = nil;
        if (attributes.exclusionPath) {
             exclusionPaths = @[attributes.exclusionPath];
        }
        _context = [[MPITextKitContext alloc] initWithAttributedString:attributes.attributedText
                                                         lineBreakMode:lineBreakMode
                                                  maximumNumberOfLines:attributes.maximumNumberOfLines
                                                        exclusionPaths:exclusionPaths
                                                       constrainedSize:constrainedSize];
        
        [self calculateSize];
        [self caclulateGlyphsToShow];
        [self calculateExtraInfos];
        
    }
    return self;
}

- (void)calculateSize {
    __block CGRect boundingRect;
    __block MPITextTruncationInfo *truncationInfo = nil;
    MPITextRenderAttributes *attributes = self.attributes;
    [self.context performBlockWithLockedTextKitComponents:^(MPITextLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        [layoutManager ensureLayoutForTextContainer:textContainer];
        boundingRect = [layoutManager usedRectForTextContainer:textContainer];
        
        MPITextRenderAttributes *truncationRenderAttributes = [MPITextRenderAttributes new];
        truncationRenderAttributes.attributedText = attributes.truncationAttributedText;
        truncationRenderAttributes.lineBreakMode = attributes.lineBreakMode;
        id<CCTextTruncating> truncater = truncaterForAttributes(truncationRenderAttributes);
        if (truncater) {
            truncationInfo =
            [truncater truncateWithLayoutManager:layoutManager
                                     textStorage:textStorage
                                   textContainer:textContainer];
            if (truncationInfo) {
                [layoutManager ensureLayoutForTextContainer:textContainer];
                CGRect truncatedBoundingRect = [layoutManager usedRectForTextContainer:textContainer];

                // We should use the maximum height.
                boundingRect.size.height = MAX(CGRectGetHeight(truncatedBoundingRect), CGRectGetHeight(boundingRect));
            }
        }
    }];
    
    // TextKit often returns incorrect glyph bounding rects in the horizontal direction, so we clip to our bounding rect
    // to make sure our width calculations aren't being offset by glyphs going beyond the constrained rect.
    boundingRect.size = CGSizeMake(ceil(boundingRect.size.width), ceil(boundingRect.size.height));
    boundingRect = CGRectIntersection(boundingRect, (CGRect){.size = self.constrainedSize});
    
    CGSize size = boundingRect.size;
    
    // Update textContainer's size if needed.
    CGSize newConstrainedSize = self.constrainedSize;
    if (self.constrainedSize.width > CCTextContainerMaxSize.width - FLT_EPSILON) {
        newConstrainedSize.width = size.width;
    }
    if (self.constrainedSize.height > CCTextContainerMaxSize.height - FLT_EPSILON) {
        newConstrainedSize.height = size.height;
    }
    
    if (!CGSizeEqualToSize(newConstrainedSize, self.constrainedSize)) {
        [self.context performBlockWithLockedTextKitComponents:^(MPITextLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
            textContainer.size = newConstrainedSize;
            [layoutManager ensureLayoutForTextContainer:textContainer];
        }];
    }
    
    self.calculatedSize = size;
    self.truncationInfo = truncationInfo;
}

- (void)caclulateGlyphsToShow {
    __block NSRange glyphsToShow;
    [self.context performBlockWithLockedTextKitComponents:^(MPITextLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        glyphsToShow = [layoutManager glyphRangeForTextContainer:textContainer];
    }];
    
    self.glyphsToShow = glyphsToShow;
}

- (void)calculateExtraInfos {
    __block CCTextAttachmentsInfo *attachmentsInfo = nil;
    __block MPITextBackgroundsInfo *backgroundsInfo = nil;
    [self.context performBlockWithLockedTextKitComponents:^(MPITextLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        NSRange glyphsToShow = [layoutManager glyphRangeForTextContainer:textContainer];
        if (glyphsToShow.location != NSNotFound) {
            attachmentsInfo = [layoutManager attachmentsInfoForGlyphRange:glyphsToShow
                                                          inTextContainer:textContainer];
            
            backgroundsInfo = [layoutManager backgroundsInfoForGlyphRange:glyphsToShow
                                                          inTextContainer:textContainer];
        }
    }];
    
    self.attachmentsInfo = attachmentsInfo;
    self.backgroundsInfo = backgroundsInfo;
}

- (CGSize)size {
    return self.calculatedSize;
}

- (BOOL)isTruncated {
    return self.truncationInfo != nil;
}

- (void)drawAtPoint:(CGPoint)point debugOption:(MPITextDebugOption *)debugOption {
    NSRange glyphsToShow = self.glyphsToShow;
    CCTextAttachmentsInfo *attachmentsInfo = self.attachmentsInfo;
    MPITextBackgroundsInfo *backgroundsInfo = self.backgroundsInfo;
    [self.context performBlockWithLockedTextKitComponents:^(MPITextLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        if (glyphsToShow.location != NSNotFound) {
            [layoutManager drawBackgroundForGlyphRange:glyphsToShow atPoint:point];
            if (backgroundsInfo) {
                [layoutManager drawBackgroundWithBackgroundsInfo:backgroundsInfo atPoint:point];
            }
            [layoutManager drawGlyphsForGlyphRange:glyphsToShow atPoint:point];
            if (attachmentsInfo) {
                [layoutManager drawImageAttchmentsWithAttachmentsInfo:attachmentsInfo
                                                              atPoint:point
                                                      inTextContainer:textContainer];
            }
            if (debugOption) {
                [layoutManager drawDebugWithDebugOption:debugOption
                                          forGlyphRange:glyphsToShow
                                                atPoint:point];
            }
        }
    }];
}

- (void)drawViewAndLayerAtPoint:(CGPoint)point referenceTextView:(UIView *)referenceTextView {
    NSRange glyphsToShow = self.glyphsToShow;
    CCTextAttachmentsInfo *attachmentsInfo = self.attachmentsInfo;
    [self.context performBlockWithLockedTextKitComponents:^(MPITextLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        if (glyphsToShow.location != NSNotFound) {
            [layoutManager drawViewAndLayerAttchmentsWithAttachmentsInfo:attachmentsInfo
                                                                 atPoint:point
                                                         inTextContainer:textContainer
                                                                textView:referenceTextView];
        }
    }];
}

@end

@implementation CCTextRenderer (MPITextKitExtendedRenderer)

- (nullable id)attribute:(NSAttributedStringKey)name
                 atPoint:(CGPoint)point
          effectiveRange:(nullable NSRangePointer)effectiveRange
            inTruncation:(BOOL *)pInTruncation {
    __block id value = nil;
    __block NSRange attributeRange = NSMakeRange(NSNotFound, 0);
    __block BOOL inTruncation;
    NSValue *truncationCharacterRange = self.truncationInfo.truncationCharacterRange;
    [self.context performBlockWithLockedTextKitComponents:^(MPITextLayoutManager *layoutManager, NSTextStorage *textStorage, NSTextContainer *textContainer) {
        // Find the range.
        NSRange visibleGlyphsRange = [layoutManager glyphRangeForBoundingRect:(CGRect){ .size = textContainer.size }
                                                              inTextContainer:textContainer];
        NSRange visibleCharactersRange = [layoutManager characterRangeForGlyphRange:visibleGlyphsRange actualGlyphRange:NULL];
        NSUInteger glyphIndex =  [layoutManager glyphIndexForPoint:point inTextContainer:textContainer];
        if (glyphIndex != NSNotFound) {
            CGRect glyphRect = [layoutManager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1) inTextContainer:textContainer];
            if (CGRectContainsPoint(glyphRect, point)) {
                NSUInteger characterIndex = [layoutManager characterIndexForGlyphAtIndex:glyphIndex];
                value = [textStorage attribute:name atIndex:characterIndex longestEffectiveRange:&attributeRange inRange:visibleCharactersRange];
                if (!value) {
                    attributeRange = NSMakeRange(NSNotFound, 0);
                }
            }
        }
        
        // Check that the range is in truncation.
        if (truncationCharacterRange &&
            NSLocationInRange(attributeRange.location, truncationCharacterRange.rangeValue)) {
            inTruncation = YES;
            attributeRange = NSMakeRange(attributeRange.location - truncationCharacterRange.rangeValue.location, attributeRange.length);
        } else {
            inTruncation = NO;
        }
    }];
    
    if (effectiveRange) {
        *effectiveRange = attributeRange;
    }
    
    if (pInTruncation) {
        *pInTruncation = inTruncation;
    }
    
    return value;
}

@end
