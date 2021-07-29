//
//  MPITextKitConst.h
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#ifndef MPITextKitConst_h
#define MPITextKitConst_h
#import <UIKit/UIKit.h>

/**
 Text vertical alignment.
 */
typedef NS_ENUM(NSInteger, MPITextVerticalAlignment) {
    MPITextVerticalAlignmentTop =    0, ///< Top alignment.
    MPITextVerticalAlignmentCenter = 1, ///< Center alignment.
    MPITextVerticalAlignmentBottom = 2, ///< Bottom alignment.
};

typedef NS_ENUM(NSInteger, MPITextItemInteraction) {
    MPITextItemInteractionPossible,
    MPITextItemInteractionTap,
    MPITextItemInteractionLongPress,
};

FOUNDATION_EXTERN const CGSize MPITextContainerMaxSize;

UIKIT_EXTERN NSAttributedStringKey const MPITextLinkAttributeName; ///< Attribute name for links. The value must be MPITextLink object.
UIKIT_EXTERN NSAttributedStringKey const MPITextBackgroundAttributeName;
UIKIT_EXTERN NSAttributedStringKey const MPITextBindingAttributedName;
UIKIT_EXTERN NSAttributedStringKey const MPITextBackedStringAttributeName;
UIKIT_EXTERN NSAttributedStringKey const MPITextHighlightedAttributeName;
UIKIT_EXTERN NSAttributedStringKey const MPITextNSOriginalFontAttributeName; ///< @"NSOriginalFont"

#endif /* MPITextKitConst_h */
