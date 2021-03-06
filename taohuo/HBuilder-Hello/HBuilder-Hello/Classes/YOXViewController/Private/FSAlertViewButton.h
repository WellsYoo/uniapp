#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NYAlertViewButtonType) {
    NYAlertViewButtonTypeDefault,
    NYAlertViewButtonTypeRoundRect,
    NYAlertViewButtonTypeBordered
};

@interface FSAlertViewButton : UIButton

@property (nonatomic) NYAlertViewButtonType type;
@property (nonatomic) CGFloat cornerRadius;

@end
