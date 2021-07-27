//
//  GSSpringboardLayout.h
//  MobileExperienceStore
//
//  Created by Liyu on 15/7/31.
//  Copyright (c) 2015年 91. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBWSpringboardCell.h"

typedef NS_ENUM(NSInteger, GS_SBLayoutType)
{
    GS_SBLayoutTypeScroll = 0,  //单页
    GS_SBLayoutTypePage = 1,    //分页，类似系统springboard(目前这部分还没做!-_-)
};

//--------GSSpringboardLayout------------//
@interface FSpringboardLayout : UICollectionViewFlowLayout

@property (nonatomic,assign,readonly) GS_SBLayoutType layoutType;
@property (nonatomic,assign) CGFloat scrollingSpeed; //拖动item超出collectionView当前视图时collectionView滚动的速度
@property (nonatomic,assign) UIEdgeInsets scrollingTriggerEdgeInsets; //item超出边界的距离(移动item时需要collectionView滚动的临界长度)

- (instancetype)initWithType:(GS_SBLayoutType)type;

@end
//-----GSSpringboardLayout End----------//

//-------GSSpringboardDataSource--------//
@protocol GSSpringboardDataSource <UICollectionViewDataSource>

@optional

- (void)gssb_collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath;
- (void)gssb_collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath;

- (BOOL)gssb_collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)gssb_collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath;

- (void)gssb_collectionView:(UICollectionView *)collectionView editStateDidChanged:(BOOL) editing;

- (void)gssb_collectionView:(UICollectionView *)collectionView itemDidLongPressedAtIndex:(NSIndexPath *) indexPath;

@end
//-----GSSpringboardDataSource End------//

//------GSSpringboardDelegate-----------//
@protocol GSSpringboardDelegate <UICollectionViewDelegate>

@optional

@end

//------GSSpringboardDelegate End-------//

//---GSSpringboardDelegateFlowLayout----//
@protocol GSSpringboardDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional

- (void)gssb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)gssb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)gssb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)gssb_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

@end

//--GSSpringboardDelegateFlowLayout End--//

//--UICollectionView (GSSpringboardLayout)--//
@interface UICollectionView (GSSpringboardLayout)

@property (nonatomic,assign) BOOL gsEditing;

- (void) gs_deleteItemAtIndexPath:(NSIndexPath *) indexPath;

- (void) gs_insertItemAtIndexPath:(NSIndexPath *) indexPath;

@end

//--UICollectionView (GSSpringboardLayout) End--//
