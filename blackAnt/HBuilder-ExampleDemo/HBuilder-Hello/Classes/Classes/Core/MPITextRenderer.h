//
//  MPITextKitRender.h
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPITextRenderAttributes;
@class MPITextAttachmentsInfo;
@class MPITextBackgroundsInfo;
@class MPITextDebugOption;
@class MPITextSelectionRect;
@class MPITextPosition;
@class MPITextRange;

NS_ASSUME_NONNULL_BEGIN

@interface MPITextRenderer : NSObject

/**
 Stored attachments info and it's useful for drawing.
 */
@property (nullable, nonatomic, strong, readonly) MPITextAttachmentsInfo *attachmentsInfo;

- (instancetype)initWithTextKitAttributes:(MPITextRenderAttributes *)attributes
                          constrainedSize:(CGSize)constrainedSize;

/**
 The render's size.
 */
- (CGSize)size;

/**
 Whether or not the text is truncated.
 */
- (BOOL)isTruncated;

/**
 Draw everything without view and layer for given point.

 @param point The point indicates where to start drawing.
 @param debugOption How to drawing debug.
 */
- (void)drawAtPoint:(CGPoint)point debugOption:(nullable MPITextDebugOption *)debugOption;

/**
 It's must be on main thread.

 @param point Draw view and layer for given point.
 @param referenceTextView NSAttachment will be drawed to it.
 */
- (void)drawViewAndLayerAtPoint:(CGPoint)point referenceTextView:(UIView *)referenceTextView;

@end

@interface MPITextRenderer (MPITextKitExtendedRenderer)

/**
 Returns the value for the attribute with a given name of the character at a given index, and by reference the range over which the attribute applies.
 
 @param name The name of an attribute.
 @param point The index at which to test for attributeName.
 @param effectiveRange If the named attribute does not exist at index, the range is (NSNotFound, 0).
 @param inTruncation Indicates the attribute is in truncation.
 @return Returns The value for the attribute named attributeName of the character at index, or nil if there is no such attribute.
 */
- (nullable id)attribute:(NSAttributedStringKey)name
                 atPoint:(CGPoint)point
          effectiveRange:(nullable NSRangePointer)effectiveRange
            inTruncation:(nullable BOOL *)inTruncation;

@end

NS_ASSUME_NONNULL_END
