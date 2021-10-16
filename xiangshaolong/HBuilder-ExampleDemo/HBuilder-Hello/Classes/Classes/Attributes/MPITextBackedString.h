//
//  MPITextBackedString.h
//  MeituMV
//
//  Created by Tpphha on 2018/11/9.
//  Copyright © 2018 美图网. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPITextBackedString : NSObject <NSCopying, NSCoding>

@property (nullable, nonatomic, copy) NSString *string; ///< backed text

- (instancetype)initWithString:(nullable NSString *)string;

+ (instancetype)stringWithString:(nullable NSString *)string;

@end

NS_ASSUME_NONNULL_END
