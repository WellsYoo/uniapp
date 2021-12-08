#import <UIKit/UIKit.h>
#import "NYAlertActionConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCAlertAction : NSObject

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIAlertActionStyle)style
                      handler:(void (^__nullable)(CCAlertAction *action))handler;

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIAlertActionStyle)style
                      handler:(void (^__nullable)(CCAlertAction *action))handler
                configuration:(nullable NYAlertActionConfiguration *)configuration;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, readonly) UIAlertActionStyle style;
@property (nonatomic, strong, readonly, nullable) void (^handler)(CCAlertAction *action);
@property (nonatomic, strong, readonly, nullable) NYAlertActionConfiguration *configuration;
@property (nonatomic) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
