//
//  MPITextAttachmentsInfo.h
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MPITextAttachment;

@interface CCTextAttachmentInfo : NSObject

@property (nonatomic, assign, readonly) CGRect frame;
@property (nonatomic, assign, readonly) NSUInteger characterIndex;

- (instancetype)initWithFrame:(CGRect)frame characterIndex:(NSUInteger)characterIndex;

@end

@interface CCTextAttachmentsInfo : NSObject

/**
 Array of `MPITextAttachment`
 */
@property (nonatomic, strong, readonly) NSArray<MPITextAttachment *> *attachments;

@property (nonatomic, strong, readonly) NSArray<CCTextAttachmentInfo *> *attachmentInfos;

- (instancetype)initWithAttachments:(NSArray<MPITextAttachment *> *)attachments
                    attachmentInfos:(NSArray<CCTextAttachmentInfo *> *)attachmentInfos;

@end

NS_ASSUME_NONNULL_END
