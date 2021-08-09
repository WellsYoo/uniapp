//
//  MPITextTailTruncater.h
//  MeituMV
//
//  Created by Tpphha on 2019/3/24.
//  Copyright © 2019 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<MPITextKit/MPITextKit.h>)
#import <MPITextKit/MPITextTruncating.h>
#else
#import "CCTextTruncating.h"
#endif

@interface MPITextTailTruncater : NSObject <CCTextTruncating>

@end
