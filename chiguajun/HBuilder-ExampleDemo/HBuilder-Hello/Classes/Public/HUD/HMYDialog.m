
#import "HMYDialog.h"
#import <unistd.h>

@implementation HMYDialog

static HMYDialog *instance = nil;

- (id)init
{
    if (self = [super init]) {
        _paramDict = [[NSMutableDictionary alloc] init];
        _alertViewTag = 0x1000;
    }
    
    return self;
}

+ (HMYDialog *)Instance
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [self new];
        }
    }
    return instance;
}

//Alert消息文本左对齐
+(void)willPresentAlertView:(UIAlertView *)alertView
{
    for( UIView * view in alertView.subviews)
    {
        if( [view isKindOfClass:[UILabel class]] )
        {
            UILabel* label = (UILabel*) view;
            label.textAlignment = UITextAlignmentLeft;
        }
    }
}

+ (void)alert:(NSString *)message {
    
    if (!message) {
        return;
    }
    
    if (![message isKindOfClass:[NSString class]]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@""
                                  message:message 
                                  delegate:nil 
                                  cancelButtonTitle:_(@"OK")
                                  otherButtonTitles:nil, nil];
        [alertView show];
    });
}

+ (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:title
                                  message:message
                                  delegate:nil
                                  cancelButtonTitle:_(@"OK")
                                  otherButtonTitles:nil, nil];
        [alertView show];
    });
}

- (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message withParams:(NSArray *)params {
    if (params.count == 0) {
        return;
    }

    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.tag = _alertViewTag;
    alertView.title = title;
    alertView.message = message;
    alertView.delegate = self;
    for (int i = 0; i < [params count]; i++) {
        NSString *strTitle = [[params objectAtIndex:i] objectForKey:kButtonText];
        [alertView addButtonWithTitle:strTitle];
    }
    [alertView show];
    
    [_paramDict setObject:params forKey:[NSNumber numberWithInt:_alertViewTag++]];
}

// 通用确认取消框
- (void)alertWithTitle:(NSString *)title andMessage:(NSString *)message withConfirmBlock:(void (^)(void))confirmBlock {
    NSMutableArray *params = [NSMutableArray array];
    [params addObject:@{kButtonText:_(@"Cancel")}];
    [params addObject:@{kButtonText:_(@"OK"), kButtonBlock:confirmBlock}];
    [[HMYDialog Instance] alertWithTitle:title andMessage:message withParams:params];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    NSNumber *key = [NSNumber numberWithInt:alertView.tag];
    NSArray *arr = [_paramDict objectForKey:key];
    [_paramDict removeObjectForKey:key];
    
    if (buttonIndex >= arr.count) {
        return;
    }
    
    void (^block)(void) = [[arr objectAtIndex:buttonIndex] objectForKey:kButtonBlock];
    if (block) {
        block();
    }
}
    

+ (void)toast:(UIViewController *)controller withMessage:(NSString *)message {
    NCWMBProgressHUD *hud = [NCWMBProgressHUD showHUDAddedTo:controller.view animated:YES];
	hud.mode = NCWMBProgressHUDModeText;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:2];
}

+ (void)toast:(NSString *)message {
    NCWMBProgressHUD *hud = [NCWMBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
	hud.mode = NCWMBProgressHUDModeText;
    hud.animationType = NCWMBProgressHUDAnimationZoomOut;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:2];
}

#if 0
+ (void)simpleToast:(NSString *)message
{
    [SVProgressHUD showOnlyStatus:message withDuration:2];
}

+ (void)hideSimpleToast
{
    [SVProgressHUD dismissAfterDelay:2];
}
#endif

+ (void)toastCenter:(NSString *)message {
    NCWMBProgressHUD *hud = [NCWMBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
	hud.mode = NCWMBProgressHUDModeText;
    hud.animationType = NCWMBProgressHUDAnimationZoomOut;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = -20.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:2];
}

+ (void)toastCenter:(NSString *)message wait:(NSInteger)second
{
    NCWMBProgressHUD *hud = [NCWMBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.mode = NCWMBProgressHUDModeText;
    hud.animationType = NCWMBProgressHUDAnimationZoomOut;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = -20.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:second];
}

+ (void)progressToast:(NSString *)message
{
    NCWMBProgressHUD *hud = [NCWMBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
	hud.mode = NCWMBProgressHUDModeIndeterminate;
	hud.labelText = message;
	hud.margin = 10.f;
	hud.yOffset = -20.f;
	hud.removeFromSuperViewOnHide = YES;
	[hud hide:YES afterDelay:2];
}

- (void)gradient:(UIViewController *)controller seletor:(SEL)method {
    HUD = [[NCWMBProgressHUD alloc] initWithView:controller.view];
	[controller.view addSubview:HUD];
//	HUD.dimBackground = YES;
	HUD.delegate = self;
	[HUD showWhileExecuting:method onTarget:controller withObject:nil animated:YES];
}

- (void)showProgress:(UIViewController *)controller {
    HUD = [[NCWMBProgressHUD alloc] initWithView:controller.view];
    [controller.view addSubview:HUD];
//    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD show:YES];
}

- (void)showProgress:(UIViewController *)controller withLabel:(NSString *)labelText {
    HUD = [[NCWMBProgressHUD alloc] initWithView:controller.view];
    [controller.view addSubview:HUD];
    HUD.delegate = self;
//    HUD.dimBackground = YES;
    HUD.labelText = labelText;
    [HUD show:YES];
}

- (void)showCenterProgressWithLabel:(NSString *)labelText
{
    if (HUD) {
        HUD.labelText = labelText;
        return;
    }
    
    HUD = [[NCWMBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
    [[UIApplication sharedApplication].delegate.window addSubview:HUD];
    HUD.delegate = self;
    //    HUD.dimBackground = YES;
    HUD.labelText = labelText;
    [HUD show:YES];
}

- (void)hideProgress {
    [self hideProgress:YES];
}

- (void)hideProgress:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUD hide:animated];
    });
}

- (void)progressWithLabel:(UIViewController *)controller seletor:(SEL)method {
    HUD = [[NCWMBProgressHUD alloc] initWithView:controller.view];
    [controller.view addSubview:HUD];
    HUD.delegate = self;
    //HUD.labelText = @"数据加载中...";
    [HUD showWhileExecuting:method onTarget:controller withObject:nil animated:YES];
}

#pragma mark -
#pragma mark Execution code

//- (void)myTask {
//	sleep(3);
//}

- (void)myProgressTask {
	float progress = 0.0f;
	while (progress < 1.0f) {
		progress += 0.01f;
		HUD.progress = progress;
		usleep(50000);
	}
}

- (void)myMixedTask {
	sleep(2);
	HUD.mode = NCWMBProgressHUDModeDeterminate;
	HUD.labelText = @"Progress";
	float progress = 0.0f;
	while (progress < 1.0f)
	{
		progress += 0.01f;
		HUD.progress = progress;
		usleep(50000);
	}
	HUD.mode = NCWMBProgressHUDModeIndeterminate;
	HUD.labelText = @"Cleaning up";
	sleep(2);
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] ;
	HUD.mode = NCWMBProgressHUDModeCustomView;
	HUD.labelText = @"Completed";
	sleep(2);
}

#pragma mark -
#pragma mark NSURLConnectionDelegete

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	expectedLength = [response expectedContentLength];
	currentLength = 0;
	HUD.mode = NCWMBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	currentLength += [data length];
	HUD.progress = currentLength / (float)expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = NCWMBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[HUD hide:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(NCWMBProgressHUD *)hud {
	[HUD removeFromSuperview];
	HUD = nil;
}

@end
