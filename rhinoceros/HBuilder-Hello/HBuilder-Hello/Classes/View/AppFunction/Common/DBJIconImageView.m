//
//  NCWIconImageView.m
//  NotificationCenterWidgetSdk
//
//  Created by Leeping on 15/12/15.
//  Copyright © 2015年 91. All rights reserved.
//

#import "DBJIconImageView.h"
#import "DBJWidgetInfoManager.h"
#import "DBJDrawTextView.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIImage+NCWUtil.h"

#define kIconResourceUrl @"http://exp.pgzs.com/support.ashx?act=710&ids="

@interface DBJIconImageView ()
{
    DBJApplicationItem *_appItem;
    BOOL                _needSave;
    DBJWidgetPerson    *_person;
}

@end

@implementation DBJIconImageView

- (void)setNCWAppItem:(DBJApplicationItem *)appItem
{
    _appItem = appItem;
  
    [self setImage:kNCWBundleImage(_appItem.iconUrl)];
    if (_appItem.isFromInstalled) {
        if (_appItem.isLoaded) {
            if (_appItem.imageData.length) {
                [self setImage:[UIImage imageWithData:_appItem.imageData]];
            }else {
                [self sd_setImageWithURL:[NSURL URLWithString:_appItem.iconUrl] placeholderImage:kNCWBundleImage(@"icon_default")
                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (image) {
                            [self setImage:image];
                        }else {
                            [self setImage:kNCWBundleImage(@"icon_default")];
                        }
                    });
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);
                         _appItem.imageData = imageData;
                         if (_needSave) {
                             [[DBJWidgetInfoManager sharedInstance] saveToWidget];
                         }
                     });
                 }];
            }
        }else {
            [[DBJWidgetInfoManager sharedInstance] requestApplicationInfo:_appItem complete:^(NSDictionary *appInfo){
                if (appInfo) {
                    if ([_appItem.bundleId isEqualToString:[appInfo objectForKey:ApplicationInfoKeyBundleId]]) {
                        [_appItem setIconUrl:[appInfo objectForKey:ApplicationInfoKeyIconUrl]];
                        [_appItem setIsLoaded:YES];
                        [self sd_setImageWithURL:[NSURL URLWithString:_appItem.iconUrl] placeholderImage:kNCWBundleImage(@"icon_default")
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (image) {
                                    [self setImage:image];
                                }else {
                                    [self setImage:kNCWBundleImage(@"icon_default")];
                                }
                            });
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                NSData *imageData = UIImageJPEGRepresentation(image, 0.8f);
                                _appItem.imageData = imageData;
                                if (_needSave) {
                                    [[DBJWidgetInfoManager sharedInstance] saveToWidget];
                                }
                            });
                        }];
                    }
                }
            }];
        }
    }
}

- (void)setNCWAppItem:(DBJApplicationItem *)appItem needSave:(BOOL)save
{
    _needSave = save;
    [self setNCWAppItem:appItem];
}
//
//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    if (_person) {
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1);
//        CGContextFillEllipseInRect(context, self.bounds);
//    }
//   
//}


-(void)setNCWPersonImage:(DBJWidgetPerson *) person{
    _person = person;
    
    NSString *fullName = _person.fullName;
    if (_person.imageData) {
        UIImage *image = [UIImage imageWithData:_person.imageData];
        
        self.image = [image circleImageWithBorder:0 borderColor: [UIColor clearColor]];;
        
    }else if([[DBJWidgetInfoManager sharedInstance] onlyContainChineseCharacter:fullName]&&fullName.length > 0){
        NSString *showName = [fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *lastCharacter = [showName substringFromIndex:showName.length-1];
        DBJDrawTextView *drawTextView = [[DBJDrawTextView alloc] initWithFrame:CGRectMake(0, 0, 42, 42) Text:lastCharacter Letter:false];
        UIImage *image = [[DBJWidgetInfoManager sharedInstance] convertViewToImage:drawTextView];
        if (image) {
            self.image = image;
        }
    }else if ([[DBJWidgetInfoManager sharedInstance] onlyContainLetter:fullName]&&fullName.length > 0){
        NSString *showName = [fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *firstLetter = [[showName substringToIndex:1] uppercaseString];
        DBJDrawTextView *drawTextView = [[DBJDrawTextView alloc] initWithFrame:CGRectMake(0, 0, 42, 42) Text:firstLetter Letter:YES];
        UIImage *image = [[DBJWidgetInfoManager sharedInstance] convertViewToImage:drawTextView];
        if (image) {
            self.image = image;
        }
        
    }else{
        self.image = [[DBJWidgetInfoManager sharedInstance] defaultPortrait];
    }
}

@end