//
//  MTAppCallbackSuccessResult.h
//  MTAppManagerKit
//
//  Created by YWH on 2017/10/17.
//

#import <Foundation/Foundation.h>

@interface EGAppRequestMessage : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDictionary *requestData;

- (instancetype)initWithImage:(UIImage *)image
                  requestData:(NSDictionary *)requestData;
@end


@interface EGAppResponseMessage : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDictionary *responseData;
@end
