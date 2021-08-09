//
//  MPITextLayoutManager.m
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import "MPITextLayoutManager.h"
#import "CCTextAttachmentsInfo.h"
#import "MPITextBackgroundsInfo.h"
#import "MPITextAttachment.h"
#import "MPITextAttributes.h"
#import "MPITextGeometryHelpers.h"
#import "MPITextDefaultsValueHelpers.h"
#import "MPITextDebugOption.h"
#import <CoreText/CoreText.h>

/**
 NOTE:
 -fillBackgroundRectArray:count:forCharacterRange:color: The draws is incorrect in this method.
 -truncatedGlyphRangeInLineFragmentForGlyphAtIndex: The retuns result incorrect in multi line text line break.
 */
@interface MPITextLayoutManager ()

@end

@implementation MPITextLayoutManager

#pragma mark - Background

- (MPITextBackgroundsInfo *)backgroundsInfoForGlyphRange:(NSRange)glyphsToShow inTextContainer:(NSTextContainer *)textContainer {
    if (glyphsToShow.length == 0) {
        return nil;
    }
    
    NSTextStorage *textStorage = self.textStorage;
    NSRange characterRangeToShow = [self characterRangeForGlyphRange:glyphsToShow actualGlyphRange:NULL];
    
    NSMutableArray<NSArray *> *backgroundRectArrays = [NSMutableArray new];
    NSMutableArray<NSValue *> *backgroundCharacterRanges = [NSMutableArray new];
    NSMutableArray<MPITextBackground *> *backgrounds = [NSMutableArray new];
    [textStorage enumerateAttribute:MPITextBackgroundAttributeName inRange:characterRangeToShow options:kNilOptions usingBlock:^(MPITextBackground  *_Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (!value) {
            return;
        }
        
        NSRange glyphRange = [self glyphRangeForCharacterRange:range actualCharacterRange:NULL];
        if (glyphRange.location == NSNotFound) {
            return;
        }
        
        NSMutableArray<NSValue *> *rects = [NSMutableArray new];
        // SelectedGlyphRange will including glyphs that draw outside their line fragment rectangles and text attributes such as underlining.
        // If SelectedGlyphRange is (NSNotFound, 0), it behaves like SelectedGlyphRange is glyphRange (unlike doc said).
        [self enumerateEnclosingRectsForGlyphRange:glyphRange withinSelectedGlyphRange:NSMakeRange(glyphRange.location, 1) inTextContainer:textContainer usingBlock:^(CGRect rect, BOOL *stop) {
            CGRect proposedRect = rect;
            
            // This method may return a larger value.
            // NSRange glyphRange = [self glyphRangeForBoundingRect:proposedRect inTextContainer:textContainer];
            NSUInteger startGlyphIndex = [self glyphIndexForPoint:CGPointMake(ceil(CGRectGetMinX(proposedRect)), CGRectGetMidY(proposedRect)) inTextContainer:textContainer];
            NSUInteger endGlyphIndex = [self glyphIndexForPoint:CGPointMake(floor(CGRectGetMaxX(proposedRect)), CGRectGetMidY(proposedRect)) inTextContainer:textContainer];
            NSRange glyphRange = NSMakeRange(startGlyphIndex, endGlyphIndex - startGlyphIndex + 1);
            NSRange characterRange = [self characterRangeForGlyphRange:glyphRange actualGlyphRange:NULL];
            
            CGRect lineFragmentUsedRect = [self lineFragmentUsedRectForGlyphAtIndex:glyphRange.location effectiveRange:NULL withoutAdditionalLayout:NO];
            proposedRect = CGRectIntersection(proposedRect, lineFragmentUsedRect);
            
            proposedRect = [value  backgroundRectForTextContainer:textContainer
                                                     proposedRect:proposedRect
                                                   characterRange:characterRange];
            
            [rects addObject:[NSValue valueWithCGRect:proposedRect]];
        }];
        
        [backgroundRectArrays addObject:rects];
        [backgroundCharacterRanges addObject:[NSValue valueWithRange:range]];
        [backgrounds addObject:value];
    }];
    
    if (backgrounds.count > 0) {
        return [[MPITextBackgroundsInfo alloc] initWithBackgrounds:backgrounds
                                              backgroundRectArrays:backgroundRectArrays
                                         backgroundCharacterRanges:backgroundCharacterRanges];
    }
    
    return nil;
}

- (void)fillBackground:(MPITextBackground *)background rectArray:(NSArray<NSValue *> *)rectArray atPoint:(CGPoint)origin forCharacterRange:(NSRange)charRange  {
    CGFloat cornerRadius = background.cornerRadius;
    UIColor *strokeColor = background.strokeColor;
    CGFloat strokeWidth = background.strokeWidth;
    UIColor *color = background.fillColor;
    
    if (!color && !strokeColor) {
        return;
    }
    
    // background
    NSMutableArray *paths = [NSMutableArray new];
    for (NSUInteger index = 0; index < rectArray.count; index++) {
        CGRect rect = [rectArray[index] CGRectValue];
        rect.origin.x += origin.x;
        rect.origin.y += origin.y;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
        [path closePath];
        [paths addObject:path];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    for (UIBezierPath *path in paths) {
        CGContextAddPath(context, path.CGPath);
    }
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    // stroke
    if (strokeColor && strokeWidth > 0) {
        CGFloat inset = -strokeWidth * 0.5;
        CGFloat radiusDelta = -inset;
        if (cornerRadius <= 0) {
            radiusDelta = 0;
        }
        NSMutableArray *paths = [NSMutableArray new];
        for (NSUInteger index = 0; index < rectArray.count; index++) {
            CGRect rect = [rectArray[index] CGRectValue];
            rect.origin.x += origin.x;
            rect.origin.y += origin.y;
            rect = CGRectInset(rect, inset, inset);
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius + radiusDelta];
            [path closePath];
            [paths addObject:path];
        }
        
        CGContextSaveGState(context);
        for (UIBezierPath *path in paths) {
            CGContextAddPath(context, path.CGPath);
        }
        CGContextSetLineWidth(context, strokeWidth);
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
}

- (void)drawBackgroundWithBackgroundsInfo:(MPITextBackgroundsInfo *)backgroundsInfo atPoint:(CGPoint)origin {
    if (!backgroundsInfo) {
        return;
    }
    
    NSArray<NSArray *> *backgroundRectArrays = backgroundsInfo.backgroundRectArrays;
    NSArray<NSValue *> *backgroundCharacterRanges = backgroundsInfo.backgroundCharacterRanges;
    NSArray<MPITextBackground *> *backgrounds = backgroundsInfo.backgrounds;
    if (backgroundRectArrays.count != backgroundCharacterRanges.count ||
        backgroundRectArrays.count != backgrounds.count) {
        NSAssert(NO, @"Invalid backgroundsInfo: %@.", backgroundsInfo);
        return;
    }
    
    for (NSUInteger i = 0; i < backgroundRectArrays.count; i++) {
        NSArray<NSValue *> *rectArray = backgroundRectArrays[i];
        NSRange characterRange = backgroundCharacterRanges[i].rangeValue;
        MPITextBackground *background = backgrounds[i];
        [self fillBackground:background rectArray:rectArray atPoint:origin forCharacterRange:characterRange];
    }
}

#pragma mark - Attachment

- (CCTextAttachmentsInfo *)attachmentsInfoForGlyphRange:(NSRange)glyphsToShow inTextContainer:(NSTextContainer *)textContainer {
    if (glyphsToShow.length == 0) {
        return nil;
    }
    
    NSTextStorage *textStorage = self.textStorage;
    
    NSMutableArray<MPITextAttachment *> *attachments = [NSMutableArray new];
    NSMutableArray<CCTextAttachmentInfo *> *attachmentInfos = [NSMutableArray new];
    
    NSRange characterRange = [self characterRangeForGlyphRange:glyphsToShow actualGlyphRange:NULL];
    [textStorage enumerateAttribute:NSAttachmentAttributeName inRange:characterRange options:kNilOptions usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (![value isKindOfClass:MPITextAttachment.class]) {
            return;
        }
        
        MPITextAttachment *attachment = (MPITextAttachment *)value;
        
        NSRange glyphRange = [self glyphRangeForCharacterRange:range actualCharacterRange:NULL];
        CGRect attachmentFrame = [self boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
        CGPoint location = [self locationForGlyphAtIndex:glyphRange.location];
        
        // location.y is attachment's frame maxY，this behaviors depends on TextKit and MPITextAttachment implementation.
        attachmentFrame.origin.y += location.y;
        attachmentFrame.origin.y -= attachment.attachmentSize.height;
        attachmentFrame.size.height = attachment.attachmentSize.height;
        
        CCTextAttachmentInfo *attachmentInfo = [[CCTextAttachmentInfo alloc] initWithFrame:attachmentFrame
                                                                              characterIndex:range.location];
        
        [attachments addObject:value];
        [attachmentInfos addObject:attachmentInfo];
    }];
    
    if (attachments.count > 0) {
        return [[CCTextAttachmentsInfo alloc] initWithAttachments:attachments attachmentInfos:attachmentInfos];
    }
    
    return nil;
}

- (void)drawImageAttchmentsWithAttachmentsInfo:(CCTextAttachmentsInfo *)attachmentsInfo
                                       atPoint:(CGPoint)origin
                               inTextContainer:(NSTextContainer *)textContainer {
    if (!attachmentsInfo || attachmentsInfo.attachments.count == 0) {
        return;
    }
    
    NSArray *attachments = attachmentsInfo.attachments;
    NSArray *attachmentInfos = attachmentsInfo.attachmentInfos;
    
    [attachments enumerateObjectsUsingBlock:^(MPITextAttachment * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CCTextAttachmentInfo *attachmentInfo = attachmentInfos[idx];
        CGRect frame = attachmentInfo.frame;
        NSUInteger characterIndex = attachmentInfo.characterIndex;
        frame.origin.x += origin.x;
        frame.origin.y += origin.y;
        id content = obj.content;
        if ([content isKindOfClass:UIImage.class]) {
            [obj drawAttachmentInTextContainer:textContainer
                             textView:nil
                                  proposedRect:frame
                                characterIndex:characterIndex];
        }
    }];
}

- (void)drawViewAndLayerAttchmentsWithAttachmentsInfo:(CCTextAttachmentsInfo *)attachmentsInfo
                                              atPoint:(CGPoint)origin
                                      inTextContainer:(NSTextContainer *)textContainer
                                             textView:(UIView *)textView {
    if (!attachmentsInfo || attachmentsInfo.attachments.count == 0 || !textView) {
        return;
    }
    
    NSAssert([NSThread mainThread], @"Drawing view and layer must be on main thread.");
    NSArray *attachments = attachmentsInfo.attachments;
    NSArray *attachmentInfos = attachmentsInfo.attachmentInfos;
    
    [attachments enumerateObjectsUsingBlock:^(MPITextAttachment * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CCTextAttachmentInfo *attachmentInfo = attachmentInfos[idx];
        CGRect frame = attachmentInfo.frame;
        NSUInteger characterIndex = attachmentInfo.characterIndex;
        frame.origin.x += origin.x;
        frame.origin.y += origin.y;
        id content = obj.content;
        if ([content isKindOfClass:UIView.class] ||
            [content isKindOfClass:CALayer.class]) {
            [obj drawAttachmentInTextContainer:textContainer
                                      textView:textView
                                  proposedRect:frame
                                characterIndex:characterIndex];
        }
    }];
}

#pragma mark - Debug

- (void)drawDebugWithDebugOption:(MPITextDebugOption *)op forGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)point {
    if (!op || ![op needsDrawDebug]) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, point.x, point.y);
    CGContextSetLineWidth(context, 1.0 / MPITextScreenScale());
    CGContextSetLineDash(context, 0, NULL, 0);
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    [self enumerateLineFragmentsForGlyphRange:glyphsToShow usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
        if (op.lineFragmentFillColor) {
            [op.lineFragmentFillColor setFill];
            CGContextAddRect(context, MPITextCGRectPixelRound(rect));
            CGContextFillPath(context);
        }
        if (op.lineFragmentBorderColor) {
            [op.lineFragmentBorderColor setStroke];
            CGContextAddRect(context, MPITextCGRectPixelHalf(rect));
            CGContextStrokePath(context);
        }
        if (op.lineFragmentUsedFillColor) {
            [op.lineFragmentUsedFillColor setFill];
            CGContextAddRect(context, MPITextCGRectPixelRound(usedRect));
            CGContextFillPath(context);
        }
        if (op.lineFragmentUsedBorderColor) {
            [op.lineFragmentUsedBorderColor setStroke];
            CGContextAddRect(context, MPITextCGRectPixelHalf(usedRect));
            CGContextStrokePath(context);
        }
        if (op.baselineColor) {
            CGFloat baselineOffset = [self baselineOffsetForGlyphRange:glyphRange];
            [op.baselineColor setStroke];
            CGFloat x1 = MPITextCGFloatPixelHalf(usedRect.origin.x);
            CGFloat x2 = MPITextCGFloatPixelHalf(usedRect.origin.x + usedRect.size.width);
            CGFloat y =  MPITextCGFloatPixelHalf(CGRectGetMinY(rect) + baselineOffset);
            CGContextMoveToPoint(context, x1, y);
            CGContextAddLineToPoint(context, x2, y);
            CGContextStrokePath(context);
        }
        if (op.glyphFillColor || op.glyphBorderColor) {
            for (NSUInteger g = 0; g < glyphRange.length; g++) {
                CGRect glyphRect = [self glyphRectForGlyphIndex:glyphRange.location + g inTextContainer:textContainer];
                
                if (op.glyphFillColor) {
                    [op.glyphFillColor setFill];
                    CGContextAddRect(context, MPITextCGRectPixelRound(glyphRect));
                    CGContextFillPath(context);
                }
                if (op.glyphBorderColor) {
                    [op.glyphBorderColor setStroke];
                    CGContextAddRect(context, MPITextCGRectPixelHalf(glyphRect));
                    CGContextStrokePath(context);
                }
            }
        }
    }];
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
}

- (CGFloat)baselineOffsetForGlyphIndex:(NSUInteger)glyphIndex {
    NSRange glyphRange;
    [self lineFragmentRectForGlyphAtIndex:glyphIndex effectiveRange:&glyphRange];
    return [self baselineOffsetForGlyphRange:glyphRange];
}

- (CGFloat)baselineOffsetForGlyphRange:(NSRange)glyphRange {
    NSUInteger maxRange = NSMaxRange(glyphRange);
    NSUInteger index = glyphRange.location;
    CGGlyph glyph = kCGFontIndexInvalid;
    while (glyph == kCGFontIndexInvalid && index < maxRange) {
        glyph = [self CGGlyphAtIndex:index];
        index++;
    }
    
    NSUInteger glyphIndex = index - 1;
    CGFloat baselineOffset = [self locationForGlyphAtIndex:glyphIndex].y;
    
    if (glyph == kCGFontIndexInvalid) {
        NSUInteger charIndex = [self characterIndexForGlyphAtIndex:glyphIndex];
        UIFont *font = [self.textStorage attribute:NSFontAttributeName
                                           atIndex:charIndex
                                    effectiveRange:NULL];
        return baselineOffset + font.descender;
    }
    
    return baselineOffset;
}

- (CGRect)glyphRectForGlyphIndex:(NSUInteger)glyphIndex inTextContainer:(NSTextContainer *)textContainer {
    NSUInteger charIndex = [self characterIndexForGlyphAtIndex:glyphIndex];
    CGGlyph glyph = [self CGGlyphAtIndex:glyphIndex];
    CTFontRef font = (__bridge_retained CTFontRef)[self.textStorage attribute:NSFontAttributeName
                                                                      atIndex:charIndex
                                                               effectiveRange:NULL];
    if (font == nil) {
        font = (__bridge_retained CTFontRef)[UIFont systemFontOfSize:MPITextCoreTextDefaultFontSize()];
    }
    //                                    Glyph Advance
    //                             +-------------------------+
    //                             |                         |
    //                             |                         |
    // +------------------------+--|-------------------------|--+-----------+-----+ What TextKit returns sometimes
    // |                        |  |             XXXXXXXXXXX +  |           |     | (approx. correct height, but
    // |               ---------|--+---------+  XXX       XXXX +|-----------|-----|  sometimes inaccurate bounding
    // |               |        |             XXX          XXXXX|           |     |  widths)
    // |               |        |             XX             XX |           |     |
    // |               |        |            XX                 |           |     |
    // |               |        |           XXX                 |           |     |
    // |               |        |           XX                  |           |     |
    // |               |        |      XXXXXXXXXXX              |           |     |
    // |   Cap Height->|        |          XX                   |           |     |
    // |               |        |          XX                   |  Ascent-->|     |
    // |               |        |          XX                   |           |     |
    // |               |        |          XX                   |           |     |
    // |               |        |          X                    |           |     |
    // |               |        |          X                    |           |     |
    // |               |        |          X                    |           |     |
    // |               |        |         XX                    |           |     |
    // |               |        |         X                     |           |     |
    // |               ---------|-------+ X +-------------------------------------|
    // |                        |        XX                     |                 |
    // |                        |        X                      |                 |
    // |                        |      XX         Descent------>|                 |
    // |                        | XXXXXX                        |                 |
    // |                        |  XXX                          |                 |
    // +------------------------+-------------------------------------------------+
    //                                                          |
    //                                                          +--+Actual bounding box
    
    CGFloat advance = CTFontGetAdvancesForGlyphs(font, kCTFontOrientationHorizontal, &glyph, NULL, 1);
    CGFloat ascent = CTFontGetAscent(font);
    CGFloat descent = CTFontGetDescent(font);
    
    CFRelease(font);
    
    // Textkit's glyphs count not equal CoreText glyphs count, and the CoreText removed glyphs if glyph == 0. It's means the glyph not suitable for font.
    if (glyph == 0 && glyphIndex > 0) {
        return [self glyphRectForGlyphIndex:glyphIndex - 1 inTextContainer:textContainer];
    }
    
    CGRect glyphRect = [self boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1) inTextContainer:textContainer];
    
    // If it is a NSTextAttachment(glyph == kCGFontIndexInvalid), we don't have the matched glyph and use width of glyphRect instead of advance.
    CGFloat lineHeight = (glyph == kCGFontIndexInvalid) ? glyphRect.size.height : ascent + descent;
    CGPoint location = [self locationForGlyphAtIndex:glyphIndex];
    CGRect lineFragmentRect = [self lineFragmentRectForGlyphAtIndex:glyphIndex effectiveRange:NULL];
    CGFloat baseline = location.y + CGRectGetMinY(lineFragmentRect);
    
    CGRect properGlyphRect;
    // We are just measuring the line heights here, so we can use the
    // heights used by TextKit, which tend to be pretty good.
    properGlyphRect = CGRectMake(location.x,
                                 (glyph == kCGFontIndexInvalid) ? glyphRect.origin.y : baseline - ascent,
                                 advance,
                                 lineHeight);
    
    return properGlyphRect;
}

- (NSUInteger)numberOfLinesInTextContainer:(NSTextContainer *)textContainer {
    NSRange glyphRange, lineRange = NSMakeRange(0, 0);
    CGRect rect;
    CGFloat lastOriginY = -1.0;
    NSUInteger numberOfLines = -1;
    
    glyphRange = [self glyphRangeForTextContainer:textContainer];
    while (lineRange.location < NSMaxRange(glyphRange)) {
        rect = [self lineFragmentRectForGlyphAtIndex:lineRange.location effectiveRange:&lineRange];
        if (CGRectGetMinY(rect) > lastOriginY) {
            numberOfLines++;
        }
        lastOriginY = CGRectGetMinY(rect);
        lineRange.location = NSMaxRange(lineRange);
    }
    
    return numberOfLines;
}

@end
