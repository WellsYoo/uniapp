//
//  NCWSegmentButton.m
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "YCegmentButton.h"

@implementation YCegmentButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self setClipsToBounds:YES];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self setBackgroundColor:[UIColor colorWithHexString:@"2e92ff"]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTitleColor:[UIColor colorWithHexString:@"2e92ff"] forState:UIControlStateNormal];
    }
}

@end
