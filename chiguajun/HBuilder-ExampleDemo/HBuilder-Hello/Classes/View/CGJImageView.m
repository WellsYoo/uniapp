//
//  AdImageView.m
//  MobileExperienceStore
//
//  Created by YWH on 15/9/21.
//  Copyright © 2015年 91. All rights reserved.
//

#import "CGJImageView.h"

@implementation CGJImageView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleToFill;
      
        if ([self isEnglish]) {
            self.image = kNCWBundleImage(@"en_Ad.png");
        }else
        {
            self.image = kNCWBundleImage(@"ad.png");
        }
       
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAdDetail)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

-(void)toAdDetail
{
    NSURL *schemeUrl;
    if ([self isEnglish]) {
         schemeUrl = [NSURL URLWithString:@"https://www.amazon.com/gp/gw/ajax/s.html"];
    }else
    {
        schemeUrl = [NSURL URLWithString:@"https://jhs.m.taobao.com/m/list.htm#!all"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:schemeUrl]) {
        [[UIApplication sharedApplication] openURL:schemeUrl];
        
    }
}


-(BOOL)isEnglish
{
    NSArray *allLanguages =   [NSLocale preferredLanguages];
    NSString *preferedLang = [allLanguages objectAtIndex:0];
    if ([preferedLang isEqualToString:@"en"]) {
        return YES;
    }
    return NO;
}
@end
