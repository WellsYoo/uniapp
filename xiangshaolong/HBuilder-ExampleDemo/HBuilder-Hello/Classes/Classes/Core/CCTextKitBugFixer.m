//
//  MPITextLineHeightFixer.m
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import "CCTextKitBugFixer.h"
#import "MPITextKitConst.h"

@implementation CCTextKitBugFixer

+ (instancetype)sharedFixer {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldSetLineFragmentRect:(inout CGRect *)lineFragmentRect lineFragmentUsedRect:(inout CGRect *)lineFragmentUsedRect baselineOffset:(inout CGFloat *)baselineOffset inTextContainer:(NSTextContainer *)textContainer forGlyphRange:(NSRange)glyphRange {
    /**
     From apple's doc:
     https://developer.apple.com/library/content/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/CustomTextProcessing/CustomTextProcessing.html
     In addition to returning the line fragment rectangle itself, the layout manager returns a rectangle called the used rectangle. This is the portion of the line fragment rectangle that actually contains glyphs or other marks to be drawn. By convention, both rectangles include the line fragment padding and the interline space (which is calculated from the font’s line height metrics and the paragraph’s line spacing parameters). However, the paragraph spacing (before and after) and any space added around the text, such as that caused by center-spaced text, are included only in the line fragment rectangle, and are not included in the used rectangle.
     
     Althought the doc said usedRect should container lineSpacing,
     we don't add the lineSpacing to usedRect to avoid the case that
     last sentance have a extra lineSpacing pading.
     */
    NSTextStorage *textStorage = layoutManager.textStorage;
    NSRange characterRange = [layoutManager characterRangeForGlyphRange:glyphRange actualGlyphRange:NULL];
    
    __block CGFloat maximumLineHeight = 0;
    __block CGFloat maximumLineSpacing = 0;
    __block CGFloat maximumParagraphSpacingBefore = 0;
    __block CGFloat maximumParagraphSpacing = 0;
    __block CGFloat maximumBaselineOffset = 0;
    [textStorage enumerateAttributesInRange:characterRange options:kNilOptions usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        UIFont *font = attrs[MPITextNSOriginalFontAttributeName]; // The actual height is NSOriginalFont lineHeight.
        if (!font) {
            font = attrs[NSFontAttributeName];
        }
        NSParagraphStyle *paragraphStyle = attrs[NSParagraphStyleAttributeName];
        
        CGFloat lineHeight = [self lineHeightForFont:font paragraphStyle:paragraphStyle];
        if (lineHeight > maximumLineHeight) {
            maximumLineHeight = lineHeight;
        }
        
        CGFloat lineSpacing = paragraphStyle.lineSpacing;
        if (lineSpacing > maximumLineSpacing) {
            maximumLineSpacing = lineSpacing;
        }
        
        CGFloat paragraphSpacingBefore = paragraphStyle.paragraphSpacingBefore;
        if (paragraphSpacingBefore > maximumParagraphSpacingBefore) {
            maximumParagraphSpacingBefore = paragraphSpacingBefore;
        }
        
        CGFloat paragraphSpacing = paragraphStyle.paragraphSpacing;
        if (paragraphSpacing > maximumParagraphSpacing) {
            maximumParagraphSpacing = paragraphSpacing;
        }
        
        CGFloat baselineOffset = font.ascender;
        if (baselineOffset > maximumBaselineOffset) {
            maximumBaselineOffset = baselineOffset;
        }
    }];
    
    // paragraphSpacing
    if (maximumParagraphSpacing > 0) {
        NSRange charaterRange = [layoutManager characterRangeForGlyphRange:NSMakeRange(NSMaxRange(glyphRange) - 1, 1) actualGlyphRange:NULL];
        NSAttributedString *attributedString = [textStorage attributedSubstringFromRange:charaterRange];
        if (![attributedString.string isEqualToString:@"\n"]) {
            maximumParagraphSpacing = 0;
        }
    }
    
    // paragraphSpacing before
    if (glyphRange.location > 0 && maximumParagraphSpacingBefore > 0) {
        NSRange lastLineEndRange = NSMakeRange(glyphRange.location - 1, 1);
        NSRange charaterRange = [layoutManager characterRangeForGlyphRange:lastLineEndRange actualGlyphRange:NULL];
        NSAttributedString *attributedString = [textStorage attributedSubstringFromRange:charaterRange];
        if (![attributedString.string isEqualToString:@"\n"]) {
            maximumParagraphSpacingBefore = 0;
        }
    }
    
    CGRect rect = *lineFragmentRect;
    CGRect usedRect = *lineFragmentUsedRect;
    
    usedRect.origin.y += maximumParagraphSpacingBefore;
    usedRect.size.height = MAX(maximumLineHeight, usedRect.size.height);
    rect.size.height = maximumParagraphSpacingBefore + usedRect.size.height + maximumLineSpacing + maximumParagraphSpacing;

    *lineFragmentRect = rect;
    *lineFragmentUsedRect = usedRect;
    *baselineOffset = MAX(maximumParagraphSpacingBefore + maximumBaselineOffset, *baselineOffset);
    
    return YES;
}

// Implementing this method with a return value 0 will solve the problem of last line disappearing
// when both maxNumberOfLines and lineSpacing are set, since we didn't include the lineSpacing in
// the lineFragmentUsedRect.
- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect {
    return 0;
}

#pragma mark - Utils

- (CGFloat)lineHeightForFont:(UIFont *)font paragraphStyle:(NSParagraphStyle *)style  {
    CGFloat lineHeight = font.lineHeight;
    if (!style) {
        return lineHeight;
    }
    if (style.lineHeightMultiple > FLT_EPSILON) {
        lineHeight *= style.lineHeightMultiple;
    }
    if (style.minimumLineHeight > FLT_EPSILON) {
        lineHeight = MAX(style.minimumLineHeight, lineHeight);
    }
    if (style.maximumLineHeight > FLT_EPSILON) {
        lineHeight = MIN(style.maximumLineHeight, lineHeight);
    }
    return lineHeight;
}

@end


