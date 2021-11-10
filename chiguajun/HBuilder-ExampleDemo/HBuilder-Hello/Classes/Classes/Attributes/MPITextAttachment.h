//
//  MPITextAttachmet.h
//  CCHLinkTextView Example
//
//  Created by Tpphha on 2018/8/11.
//  Copyright © 2018年 Claus Höfele. All rights reserved.
//

#import <UIKit/UIKit.h>
#if __has_include(<MPITextKit/MPITextKit.h>)
#import <MPITextKit/MPITextKitConst.h>
#else
#import "MPITextKitConst.h"
#endif

/**
 MPITextAttachment's attachmentSize depend on contentSize and bounds's size，if the bounds is set， then attachmentSize equal to bounds's size，otherwise contentSize instead.
 You can change the bounds's origin to change the content's origin (UIKit Coordinate System).
 */
@interface MPITextAttachment : NSTextAttachment

/**
 Attachment align to text，default is MPITextVerticalAlignmentCenter。
 */
@property (nonatomic, assign) MPITextVerticalAlignment verticalAligment;

/**
 Supported type: UIImage, UIView, CALayer.
 */
@property (nonatomic, strong) id content;

/**
 Content size，if content is a iamge, it's image.size otherwise content.bounds.size instead。
 */
@property (nonatomic, assign) CGSize contentSize;

/**
 Content display mode.
 */
@property (nonatomic, assign) UIViewContentMode contentMode;

/**
 The insets when drawing content.
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;

/**
 Attachment's size, depends content and bounds.
 */
@property (nonatomic, assign, readonly) CGSize attachmentSize;

/**
 Draws attachment.

 @param textContainer The text container in which the attachment is laid out.
 @param textView The text view in which the attachment's content is laid out.
 @param proposedRect The proposed rect for attachment's content.
 @param characterIndex The  character index of the attachment.
 */
- (void)drawAttachmentInTextContainer:(NSTextContainer *)textContainer
                             textView:(nullable UIView *)textView
                         proposedRect:(CGRect)proposedRect
                       characterIndex:(NSUInteger)characterIndex;

/**
 The final drawing method.

 @param rect The final rect for attachment's content.
 @param textView The text view in which the attachment's content is laid out.
 */
- (void)drawAttachmentInRect:(CGRect)rect textView:(nullable UIView *)textView;

@end

