//
//  NCWSoftwareIconButton.m
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "HMYtwareIconButton.h"
#import "XYIconImageView.h"
#import "XSLWidgetInfoManager.h"

#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

@interface HMYtwareIconButton ()
{
//    UIImageView *_iconView;
    UIImageView *_checkView;
    UILabel     *_title;
    XYIconImageView *_iconView;
    
    YXpplicationItem *_appItem;
}

@end

@implementation HMYtwareIconButton
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //应用图标
        
        self.clipsToBounds = YES;
        
        _iconView = [[XYIconImageView alloc] initWithFrame:CGRectMake(7.5, 8,
                                                                       CGRectGetWidth(frame) - 15,
                                                                       CGRectGetWidth(frame) - 15)];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.clipsToBounds = YES;
        _iconView.layer.cornerRadius = 6.0;
        [self addSubview:_iconView];
        
        //打钩图标
        _checkView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame) - 10,
                                                                   CGRectGetMinY(_iconView.frame) - 5, 15, 15)];
        [_checkView setImage:kNCWBundleImage(@"icon_checked")];
        [_checkView setHidden:YES];
        [self addSubview:_checkView];
        
        //应用标题
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconView.frame) + 3, CGRectGetWidth(frame), 15)];
        [_title setBackgroundColor:[UIColor clearColor]];
        [_title setTextColor:[UIColor blackColor]];
        [_title setFont:[UIFont systemFontOfSize:12]];
        [_title setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_title];
        
        [self addTarget:self action:@selector(touchInsideEventHandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        [_checkView setHidden:NO];
    }else {
        [_checkView setHidden:YES];
    }
}

- (void)setAppItem:(YXpplicationItem *)appItem
{
    _appItem = appItem;
    
    [_iconView setNCWAppItem:_appItem];
    
//    [_iconView setImage:kNCWBundleImage(_appItem.iconUrl)];
//    if (_appItem.isFromInstalled) {
//        if (_appItem.isLoaded) {
//            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_appItem.bundleId];
//            if (image) {
//                [_iconView setImage:image];
//            }else {
//                [_iconView sd_setImageWithURL:[NSURL URLWithString:_appItem.iconUrl] placeholderImage:kNCWBundleImage(@"icon_default")];
//            }
//        }else {
//            [[NCWWidgetInfoManager sharedInstance] requestApplicationInfo:_appItem complete:^(NSDictionary *appInfo){
//                if (appInfo) {
//                    if ([_appItem.bundleId isEqualToString:[appInfo objectForKey:ApplicationInfoKeyBundleId]]) {
//                        [_appItem setIconUrl:[appInfo objectForKey:ApplicationInfoKeyIconUrl]];
//                        [_appItem setIsLoaded:YES];
//                        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_appItem.bundleId];
//                        if (image) {
//                            [_iconView setImage:image];
//                        }else {
//                            [_iconView sd_setImageWithURL:[NSURL URLWithString:_appItem.iconUrl] placeholderImage:kNCWBundleImage(@"icon_default")
//                                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
//                                                    [[SDImageCache sharedImageCache] storeImage:image forKey:_appItem.bundleId];
//                                                }];
//                        }
//                    }
//                }
//            }];
//        }
//    }
    
    [_title setText:_appItem.title];
}

- (void)setTitleHidden:(BOOL)hidden
{
    _title.hidden = hidden;
    
    if (hidden) {
        [_iconView setFrame:CGRectMake(7.5, 10, 30, 30)];
        [_iconView setContentMode:UIViewContentModeScaleToFill];
    }
}

- (void)touchInsideEventHandler:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(softwareIconButton:pressedAtItem:)]) {
        [_delegate softwareIconButton:self pressedAtItem:_appItem];
    }
}

@end
