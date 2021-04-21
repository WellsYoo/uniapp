//
//  NCWSoftwareTableViewCell.m
//  NotificationCenterWidget
//
//  Created by Leeping on 15/11/20.
//  Copyright © 2015年 YWH. All rights reserved.
//

#import "YOTableViewCell.h"
#import "YCtwareIconButton.h"

#import "UIImage+NCWUtil.h"

#define kSoftwareCellSubItemSpace  8.0f
#define kSoftwareCellSubItemWidth  55.0f

@interface YOTableViewCell () <YCuttonDelegate>
{
    UILabel      *_title;
    UIControl    *_moreView;
    UIControl    *_moreControl;
    UIImageView  *_moreBackgroundView;
    UIImageView  *_arrowView;
    YCtwareIconButton  *_iconView;
    
    YXpplicationItem *_appItem;
}

@end

@implementation YOTableViewCell
@synthesize delegate = _delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.clipsToBounds = YES;
        
        //更多背景
        _moreBackgroundView = [[UIImageView alloc] init];
        _moreBackgroundView.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"efeff4"]];
        _moreBackgroundView.userInteractionEnabled = YES;
        [self.contentView addSubview:_moreBackgroundView];
        
        //更多Control
        _moreControl = [[UIControl alloc] init];
        [_moreControl addTarget:self action:@selector(moreControlHandler:) forControlEvents:UIControlEventTouchUpInside];
        [_moreControl setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_moreControl];
        
        //更多界面
        _moreView = [[UIControl alloc] init];
        _moreView.backgroundColor = [UIColor clearColor];
        _moreView.clipsToBounds = YES;
        [self.contentView addSubview:_moreView];
        
        //应用名
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        
        //应用图标
        _iconView = [[YCtwareIconButton alloc] initWithFrame:CGRectMake(4.5, 0, 45, kSoftwareTableViewCellHeight)];
//        _iconView.backgroundColor = [UIColor redColor];
        _iconView.userInteractionEnabled = NO;
        _iconView.clipsToBounds = YES;
        _iconView.layer.cornerRadius = 6;
        [self.contentView addSubview:_iconView];
        
        //更多箭头
        _arrowView = [[UIImageView alloc] init];
        _arrowView.image = kNCWBundleImage(@"icon_arrow_down");
        [self.contentView addSubview:_arrowView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_appItem.isExpress) {
        NSInteger count = _appItem.subItems.count / kSoftwareTableViewCellMaxCount;
        if (_appItem.subItems.count % kSoftwareTableViewCellMaxCount) {
            count++;
        }
        [_moreView setFrame:CGRectMake(kSoftwareCellSubItemSpace, kSoftwareTableViewCellHeight,
                                       CGRectGetWidth([UIScreen mainScreen].bounds) - kSoftwareCellSubItemSpace * 2,
                                       kSoftwareTableViewCellMoreHeight * count)];
        [_moreBackgroundView setFrame:CGRectMake(0, kSoftwareTableViewCellHeight, CGRectGetWidth([UIScreen mainScreen].bounds),
                                                 kSoftwareTableViewCellMoreHeight * count)];
    }else {
        [_moreView setFrame:CGRectMake(kSoftwareCellSubItemSpace, kSoftwareTableViewCellHeight,
                                       CGRectGetWidth([UIScreen mainScreen].bounds) - kSoftwareCellSubItemSpace * 2, 0)];
        [_moreBackgroundView setFrame:CGRectMake(0, kSoftwareTableViewCellHeight, CGRectGetWidth([UIScreen mainScreen].bounds), 0)];
    }
    [_moreControl setFrame:_moreBackgroundView.frame];
    [_title setFrame:CGRectMake(52, 0, CGRectGetWidth(self.frame) - 100, kSoftwareTableViewCellHeight)];
    [_arrowView setFrame:CGRectMake(CGRectGetWidth(self.frame) - 36, (kSoftwareTableViewCellHeight - 7) / 2,
                                    12, 7)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAppItem:(YXpplicationItem *)appItem
{
    _appItem = appItem;
    
    [_title setText:_appItem.title];
    [_iconView setSelected:_appItem.isChecked];
    [_iconView setAppItem:_appItem];
    [_iconView setTitleHidden:YES];
    
    if (_appItem.subItems.count) {
        _arrowView.hidden = NO;
    }else {
        _arrowView.hidden = YES;
    }
    //子功能
    if (_appItem.isExpress) {
        [_arrowView setImage:kNCWBundleImage(@"icon_arrow_up")];
        while ([_moreView.subviews lastObject] != nil) {
            [(UIView *)[_moreView.subviews lastObject] removeFromSuperview];
        }
        CGFloat space = (CGRectGetWidth([UIScreen mainScreen].bounds) - kSoftwareCellSubItemSpace * 2 - kSoftwareCellSubItemWidth
                         * kSoftwareTableViewCellMaxCount) / (kSoftwareTableViewCellMaxCount - 1);
        for (NSInteger i = 0; i < _appItem.subItems.count; i++) {
            NSInteger column = i;
            NSInteger row = i / kSoftwareTableViewCellMaxCount;
            if (i > (kSoftwareTableViewCellMaxCount - 1)) {
                column = i - kSoftwareTableViewCellMaxCount * row;
            }
            YXpplicationItem *item = [_appItem.subItems objectAtIndex:i];
            YCtwareIconButton *iconButton = [[YCtwareIconButton alloc] initWithFrame:CGRectMake(column * (space + kSoftwareCellSubItemWidth),
                                                                                                        kSoftwareTableViewCellMoreHeight * row,
                                                                                                        kSoftwareCellSubItemWidth, kSoftwareTableViewCellMoreHeight)];
//            [iconButton setBackgroundColor:[UIColor redColor]];
            [iconButton setTag:i];
            [iconButton setSelected:item.isChecked];
            [iconButton setAppItem:item];
            [iconButton setDelegate:self];
            [_moreView addSubview:iconButton];
        }
    }else {
        [_arrowView setImage:kNCWBundleImage(@"icon_arrow_down")];
    }
}

#pragma mark - NCWSoftwareIconButton Delegate

- (void)softwareIconButton:(YCtwareIconButton *)iconButton pressedAtItem:(YXpplicationItem *)appItem
{
    if (_delegate && [_delegate respondsToSelector:@selector(softwareTableViewCell:didPressedAtItem:)]) {
        [_delegate softwareTableViewCell:self didPressedAtItem:appItem];
    }
}

#pragma mark - NCWSoftwareMoreControlHandler

- (void)moreControlHandler:(id)sender
{
    
}

@end
