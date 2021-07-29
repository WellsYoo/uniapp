#import <UIKit/UIKit.h>
#import "NYAlertActionConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMYAlertAction : NSObject

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIAlertActionStyle)style
                      handler:(void (^__nullable)(HMYAlertAction *action))handler;

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIAlertActionStyle)style
                      handler:(void (^__nullable)(HMYAlertAction *action))handler
                configuration:(nullable NYAlertActionConfiguration *)configuration;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, readonly) UIAlertActionStyle style;
@property (nonatomic, strong, readonly, nullable) void (^handler)(HMYAlertAction *action);
@property (nonatomic, strong, readonly, nullable) NYAlertActionConfiguration *configuration;
@property (nonatomic) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
