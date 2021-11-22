//
//  MTAppCallbackSuccessResult.m
//  MTAppManagerKit
//
//  Created by YWH on 2017/10/17.
//

#import "MTAppMessage.h"

@implementation MTAppRequestMessage
- (instancetype)initWithImage:(UIImage *)image
                  requestData:(NSDictionary *)requestData {
    self = [self init];
    if (self) {
        _image = image;
        _requestData = requestData;
    }
    return self;
}
@end

@implementation MTAppResponseMessage

@end
