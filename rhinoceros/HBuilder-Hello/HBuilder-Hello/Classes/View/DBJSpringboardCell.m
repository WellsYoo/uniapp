//
//  GSSpringboardCell.m
//  MobileExperienceStore
//
//  Created by Liyu on 15/7/31.
//  Copyright (c) 2015年 91. All rights reserved.
//

#import "DBJSpringboardCell.h"
#import "DBJWidgetInfoManager.h"
#import "DBJDrawTextView.h"
#import "DBJApplicationItem.h"
#import "DBJIconImageView.h"

//#define kIconResourceUrl @"http://exp.pgzs.com/support.ashx?act=710&ids="

@interface DBJSpringboardCell()<UIAlertViewDelegate>


@property(nonatomic, strong)DBJIconImageView *portraitView;
@property(nonatomic, strong)UIButton    *deleteButton;
@property(nonatomic, strong)UIImageView *deleteButtonImage;
@property(nonatomic, strong)UILabel     *personNameLabel;
@property(nonatomic, strong)UIImageView *cornerMarkView;
@property(nonatomic, strong)DBJWidgetPerson *mPerson;
@property(nonatomic, strong)DBJApplicationItem *ncwAppItem;

@end

#define kPortraitViewWidth 42
@implementation DBJSpringboardCell

@synthesize sbEditing = _sbEditing;
@synthesize delegate = _delegate;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _portraitView = [[DBJIconImageView alloc] init];
        _portraitView.backgroundColor = [UIColor clearColor];
        _portraitView.layer.cornerRadius = 6.0;
        _portraitView.clipsToBounds = YES;
        _portraitView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_portraitView];
        
        _cornerMarkView = [[UIImageView alloc] init];
        _cornerMarkView.backgroundColor = [UIColor clearColor];
        _cornerMarkView.contentMode = UIViewContentModeScaleToFill;
        [_portraitView addSubview:_cornerMarkView];
        
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor = [UIColor clearColor];
        _deleteButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.hidden = YES;
        [self.contentView addSubview:_deleteButton];
        
        _deleteButtonImage = [[UIImageView alloc] init];
        _deleteButtonImage.image = kNCWBundleImage(@"close.png");
        _deleteButtonImage.highlightedImage = kNCWBundleImage(@"close.png");
        _deleteButtonImage.backgroundColor = [UIColor clearColor];
        _deleteButtonImage.userInteractionEnabled = NO;
        _deleteButtonImage.contentMode = UIViewContentModeScaleToFill;
        [_deleteButton addSubview:_deleteButtonImage];
        
        _personNameLabel = [[UILabel alloc] init];
        _personNameLabel.backgroundColor = [UIColor clearColor];
        _personNameLabel.textAlignment = NSTextAlignmentCenter;
        _personNameLabel.textColor = [UIColor blackColor];
        _personNameLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_personNameLabel];
        
    }
    return self;
}

- (void)bindPerson:(id )item
{
    if ([item isKindOfClass:[DBJWidgetPerson class]]) {
        _mPerson = item;
        _ncwAppItem = nil;
         _cornerMarkView.hidden = NO;
        _personNameLabel.text = _mPerson.fullName;
        
        [_portraitView setNCWPersonImage:_mPerson];
        if (_mPerson.contactType == MEPersonContactTypePhone) {
            [_cornerMarkView setImage:kNCWBundleImage(@"corner_phoneicon.png")];
        }else
        {
            [_cornerMarkView setImage:kNCWBundleImage(@"corner_messageicon.png")];
        }
       
    }else if([item isKindOfClass:[DBJApplicationItem class]]){
        _ncwAppItem = item;
        _mPerson = nil;
        _cornerMarkView.hidden = YES;
        _personNameLabel.text = _ncwAppItem.title;
        
        [_portraitView setNCWAppItem:_ncwAppItem needSave:YES];
//        [_portraitView setImage:kNCWBundleImage(_ncwAppItem.iconUrl)];
//        if (_ncwAppItem.isFromInstalled) {
//            if (_ncwAppItem.isLoaded) {
//                UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_ncwAppItem.bundleId];
//                if (image) {
//                    [_portraitView setImage:image];
//                }else {
//                    [_portraitView sd_setImageWithURL:[NSURL URLWithString:_ncwAppItem.iconUrl] placeholderImage:kNCWBundleImage(@"icon_default")];
//                }
////                [_portraitView sd_setImageWithURL:[NSURL URLWithString:_ncwAppItem.iconUrl] placeholderImage:[UIImage imageNamed:@"icon_default"]];
//            }else {
//                [[NCWWidgetInfoManager sharedInstance] requestApplicationInfo:_ncwAppItem complete:^(NSDictionary *appInfo){
//                    if (appInfo) {
//                        if ([_ncwAppItem.bundleId isEqualToString:[appInfo objectForKey:ApplicationInfoKeyBundleId]]) {
//                            [_ncwAppItem setIconUrl:[appInfo objectForKey:ApplicationInfoKeyIconUrl]];
//                            [_ncwAppItem setIsLoaded:YES];
//                            [_portraitView sd_setImageWithURL:[NSURL URLWithString:_ncwAppItem.iconUrl] placeholderImage:kNCWBundleImage(@"icon_default")
//                                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
//                                                        [[SDImageCache sharedImageCache] storeImage:image forKey:_ncwAppItem.bundleId];
//                                                    }];
//                        }
//                    }
//                }];
//            }
//        }
    }
}




-(void)deleteAction:(id)sender
{
    NSString *tip;
   
    if (_mPerson) {
        NSString *showName = _mPerson.fullName;
        if ([showName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
            showName = _mPerson.phoneNumber;
        }
         NSLog(@"%@",showName);
        tip = [NSString stringWithFormat:@"是否确定删除快捷联系人\"%@\"",showName];
    }else
    {
        tip = [NSString stringWithFormat:@"是否确定删除快捷应用\"%@\"",_ncwAppItem.title];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"" message:tip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
}


- (void) setSbEditing:(BOOL)sbEditing
{
    if (sbEditing == YES)
    {
        self.deleteButton.hidden = NO;
    }
    else
    {
        self.deleteButton.hidden = YES;
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    
    CGRect f1 = bounds;
    f1.origin.x = (f1.size.width - kPortraitViewWidth)/2  ;
    f1.origin.y = 12 ;
    f1.size.width  = kPortraitViewWidth;
     f1.size.height = kPortraitViewWidth;
    _portraitView.frame = f1;
    
    CGRect f2 = f1;
    f2.origin.x = CGRectGetMaxX(f1) - 9;
    f2.origin.y = CGRectGetMinY(f1) - 9;
    f2.size.height = 17;
    f2.size.width = 17;
    _deleteButton.frame = f2;
    
    CGRect f3 = f1;
    f3.origin.y = CGRectGetMaxY(f1) + 5;
    f3.size.height = 14;
    _personNameLabel.frame = f3;
    
    CGRect f4 = f1;
    f4.origin.x = f1.size.width - 15;
    f4.origin.y = f1.size.height - 15;
    f4.size = CGSizeMake(15, 15);
    _cornerMarkView.frame = f4;

    _deleteButtonImage.frame = _deleteButton.bounds;
}




#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if ([self.delegate respondsToSelector:@selector(gs_sbCellDidDeleted:)])
        {
            [self.delegate gs_sbCellDidDeleted:self];
        }
    }
}

@end
