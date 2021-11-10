//
//  MTGPSManager.m
//  MTAreaManagerKit
//
//  Created by dq Chen on 16/2/18.
//  Copyright © 2016年 美图网. All rights reserved.
//

#import "CCGPSManager.h"
#import <CoreLocation/CoreLocation.h>

@interface CCGPSManager () <CLLocationManagerDelegate>

@property (nonatomic, copy) MTGPSCompletionHandler completionHandler;

@property (nonatomic, strong) CLLocationManager *locationmanager;

@end

@implementation CCGPSManager

+ (instancetype)shared {
    
    static CCGPSManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCGPSManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        _locationmanager = [[CLLocationManager alloc] init];
        _locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationmanager.delegate = self;
    }
    return self;
}

- (BOOL)locationAuthoried {
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            return NO;
            break;
        default:
            break;
    }
    return [CLLocationManager locationServicesEnabled];
}

- (void)startUpdatingLocationWithHandler:(MTGPSCompletionHandler)handler {
    
    self.completionHandler = handler;
    
    if (![self locationAuthoried]) {
        
        if (self.completionHandler) {
            self.completionHandler(nil, NO);
            self.completionHandler = nil;
        }
        
        return;
    }

    
    if ([self.locationmanager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSObject *locationDescription = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"NSLocationWhenInUseUsageDescription"];
        //  8.0以上需要在info.plist设置key
        if (locationDescription != nil) {
            [self.locationmanager requestWhenInUseAuthorization];
        } else {
            if (self.completionHandler) {
                self.completionHandler(nil, NO);
                self.completionHandler = nil;
            }
        }
    }
    
    [self.locationmanager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [manager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    
    if (self.completionHandler) {
        MTGPSDataModel *model = [[MTGPSDataModel alloc] init];
        model.latitude = location.coordinate.latitude;
        model.longitude = location.coordinate.longitude;
        self.completionHandler(model, YES);
        self.completionHandler = nil;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    [manager stopUpdatingLocation];
    
    if (self.completionHandler) {
        self.completionHandler(nil, NO);
        self.completionHandler = nil;
    }
    
}

#pragma mark - MTGPSManager Interface

+ (void)requestGPSWithCompletionHandler:(MTGPSCompletionHandler)handler {
    
    [[CCGPSManager shared] startUpdatingLocationWithHandler:handler];
}

@end
