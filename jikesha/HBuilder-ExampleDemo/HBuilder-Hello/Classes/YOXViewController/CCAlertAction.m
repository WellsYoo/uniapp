#import "CCAlertAction.h"
#import "NYAlertAction+Private.h"

@implementation CCAlertAction

- (instancetype)initWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(CCAlertAction * _Nonnull))handler {
    return [self initWithTitle:title style:style handler:handler configuration:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIAlertActionStyle)style
                      handler:(void (^__nullable)(CCAlertAction *action))handler
                configuration:(nullable NYAlertActionConfiguration *)configuration {
    self = [super init];

    if (self) {
        _title = title;
        _style= style;
        _handler = handler;
        _configuration = configuration;
        _enabled = YES;
    }

    return self;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        _enabled = YES;
    }

    return self;
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;

    self.actionButton.enabled = enabled;
}

@end
