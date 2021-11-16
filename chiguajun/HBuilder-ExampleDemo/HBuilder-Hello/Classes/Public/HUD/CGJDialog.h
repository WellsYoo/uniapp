

#import <Foundation/Foundation.h>
#import "NCWMBProgressHUD.h"
//#import "SVProgressHUD.h"

typedef void (^NCWDialogButtonHandler)(void);

#define kButtonText  @"btnText"
#define kButtonBlock @"btnBlock"

@interface CGJDialog : NSObject<FFMBProgressHUDDelegate, UIAlertViewDelegate> {
	NCWMBProgressHUD *HUD;
    
	long long expectedLength;
	long long currentLength;
    
    NSMutableDictionary *_paramDict;
    NSInteger           _alertViewTag;
}

+ (CGJDialog *)Instance;

//提示对话框
+ (void)alert:(NSString *)message;
+ (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message withParams:(NSArray *)params;
- (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message withConfirmBlock:(void (^)(void))confirmBlock;

//提示对话框文本左对齐
+(void)willPresentAlertView:(UIAlertView *)alertView;

//类似于Android一个显示框效果
+ (void)toast:(UIViewController *)controller withMessage:(NSString *) message;
+ (void)toast:(NSString *)message;
//+ (void)simpleToast:(NSString *)message;
//+ (void)hideSimpleToast;
//显示在屏幕中间
+ (void)toastCenter:(NSString *)message;
+ (void)toastCenter:(NSString *)message wait:(NSInteger)second;
//带进度条
+ (void)progressToast:(NSString *)message;

//带遮罩效果的进度条
- (void)gradient:(UIViewController *)controller seletor:(SEL)method;

//显示遮罩
- (void)showProgress:(UIViewController *)controller;

//关闭遮罩
- (void)hideProgress;
- (void)hideProgress:(BOOL)animated;

//带说明的进度条
- (void)progressWithLabel:(UIViewController *)controller seletor:(SEL)method;

//显示带说明的进度条
- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText;
- (void)showCenterProgressWithLabel:(NSString *)labelText;

@end
