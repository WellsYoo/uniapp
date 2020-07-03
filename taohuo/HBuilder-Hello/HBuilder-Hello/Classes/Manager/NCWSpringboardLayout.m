//
//  GSSpringboardLayout.m
//  MobileExperienceStore
//
//  Created by Liyu on 15/7/31.
//  Copyright (c) 2015年 91. All rights reserved.
//

#import "NCWSpringboardLayout.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#ifndef CGGEOMETRY_LXSUPPORT_H_
CG_INLINE CGPoint
GSS_CGPointAdd(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}
#endif

typedef NS_ENUM(NSInteger, GSScrollingDirection) {
    GSScrollingDirectionUnknown = 0,
    GSScrollingDirectionUp,
    GSScrollingDirectionDown,
    GSScrollingDirectionLeft,
    GSScrollingDirectionRight
};

static NSString * const kGSScrollingDirectionKey = @"GSScrollingDirection";
static NSString * const kGSCollectionViewKeyPath = @"collectionView";

@interface CADisplayLink (GS_userInfo)
@property (nonatomic, copy) NSDictionary *GS_userInfo;
@end

@implementation CADisplayLink (GS_userInfo)
- (void)setGS_userInfo:(NSDictionary *)GS_userInfo {
    objc_setAssociatedObject(self, "GS_userInfo", GS_userInfo, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)GS_userInfo {
    return objc_getAssociatedObject(self, "GS_userInfo");
}
@end

@interface UICollectionViewCell (GSSpringboardLayout)

- (UIView *)GS_snapshotView;

@end

@implementation UICollectionViewCell (GSSpringboardLayout)

- (UIView *)GS_snapshotView {
    //    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
    //        return [self snapshotViewAfterScreenUpdates:YES];
    //    } else {
    //        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0f);
    //        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //        UIGraphicsEndImageContext();
    //        return [[UIImageView alloc] initWithImage:image];
    //    }
    //    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0f);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [[UIImageView alloc] initWithImage:image];
    
}

@end


//-------------GSSpringboardLayout--------------------------//
@interface NCWSpringboardLayout ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UILongPressGestureRecognizer * longPressGestureRecognizer;
@property (nonatomic,strong) UIPanGestureRecognizer * panGestureRecognizer;

@property (nonatomic,strong) NSIndexPath * selectedItemIndexPath;
@property (nonatomic,strong) UIView * currentView;
@property (nonatomic,assign) CGPoint currentViewCenter;
@property (nonatomic,assign) CGPoint panTranslationInCollectionView;
@property (nonatomic,strong) CADisplayLink * displayLink;

@property (nonatomic,weak,readonly) id<GSSpringboardDataSource> dataSource;
@property (nonatomic,weak,readonly) id<GSSpringboardDelegateFlowLayout> delegate;

@end

@implementation NCWSpringboardLayout

@synthesize layoutType = _layoutType;

- (void) setDefaults
{
    _scrollingSpeed = 300.0f;
    _scrollingTriggerEdgeInsets = UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f);
    
}

- (void)setupCollectionView {
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleLongPressGesture:)];
    _longPressGestureRecognizer.delegate = self;
    
    // Links the default long press gesture recognizer to the custom long press gesture recognizer we are creating now
    // by enforcing failure dependency so that they doesn't clash.
    for (UIGestureRecognizer *gestureRecognizer in self.collectionView.gestureRecognizers) {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [gestureRecognizer requireGestureRecognizerToFail:_longPressGestureRecognizer];
        }
    }
    
    [self.collectionView addGestureRecognizer:_longPressGestureRecognizer];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handlePanGesture:)];
    _panGestureRecognizer.delegate = self;
    [self.collectionView addGestureRecognizer:_panGestureRecognizer];
    
    // Useful in multiple scenarios: one common scenario being when the Notification Center drawer is pulled down
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillResignActive:) name: UIApplicationWillResignActiveNotification object:nil];
}

- (id)init {
    self = [super init];
    if (self) {
        [self setDefaults];
        [self addObserver:self forKeyPath:kGSCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
        [self addObserver:self forKeyPath:kGSCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (id) initWithType:(GS_SBLayoutType)type
{
    self = [super init];
    if (self)
    {
        _layoutType = type;
        [self setDefaults];
        [self addObserver:self forKeyPath:kGSCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc {
    [self invalidatesScrollTimer];
    [self removeObserver:self forKeyPath:kGSCollectionViewKeyPath];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    if ([layoutAttributes.indexPath isEqual:self.selectedItemIndexPath]) {
        layoutAttributes.hidden = YES;
    }
}

- (id<GSSpringboardDataSource>)dataSource {
    return (id<GSSpringboardDataSource>)self.collectionView.dataSource;
}

- (id<GSSpringboardDelegateFlowLayout>)delegate {
    return (id<GSSpringboardDelegateFlowLayout>)self.collectionView.delegate;
}

- (void)invalidateLayoutIfNecessary {
    @synchronized(self)
    {
        NSIndexPath *newIndexPath = [self.collectionView indexPathForItemAtPoint:self.currentView.center];
        NSIndexPath *previousIndexPath = self.selectedItemIndexPath;
        
        if ((newIndexPath == nil) || (previousIndexPath == nil) || [newIndexPath isEqual:previousIndexPath]) {
            return;
        }
        
        if ([self.dataSource respondsToSelector:@selector(gssb_collectionView:itemAtIndexPath:canMoveToIndexPath:)] &&
            ![self.dataSource gssb_collectionView:self.collectionView itemAtIndexPath:previousIndexPath canMoveToIndexPath:newIndexPath]) {
            return;
        }
        
        self.selectedItemIndexPath = newIndexPath;
        
        if ([self.dataSource respondsToSelector:@selector(gssb_collectionView:itemAtIndexPath:willMoveToIndexPath:)]) {
            [self.dataSource gssb_collectionView:self.collectionView itemAtIndexPath:previousIndexPath willMoveToIndexPath:newIndexPath];
        }
        
        __weak typeof(self) weakSelf = self;
        [self.collectionView performBatchUpdates:^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                if (previousIndexPath) {
                    [strongSelf.collectionView deleteItemsAtIndexPaths:@[ previousIndexPath ]];
                    [strongSelf.collectionView reloadData];
                }
                if (newIndexPath) {
                    [strongSelf.collectionView insertItemsAtIndexPaths:@[ newIndexPath ]];
                    [strongSelf.collectionView reloadData];
                }
            }
        } completion:^(BOOL finished) {
            __strong typeof(self) strongSelf = weakSelf;
            if ([strongSelf.dataSource respondsToSelector:@selector(gssb_collectionView:itemAtIndexPath:didMoveToIndexPath:)]) {
                [strongSelf.dataSource gssb_collectionView:strongSelf.collectionView itemAtIndexPath:previousIndexPath didMoveToIndexPath:newIndexPath];
            }
        }];
    }
}

- (void)invalidatesScrollTimer {
    if (!self.displayLink.paused) {
        [self.displayLink invalidate];
    }
    self.displayLink = nil;
}

- (void)setupScrollTimerInDirection:(GSScrollingDirection)direction {
    if (!self.displayLink.paused) {
        GSScrollingDirection oldDirection = [self.displayLink.GS_userInfo[kGSScrollingDirectionKey] integerValue];
        
        if (direction == oldDirection) {
            return;
        }
    }
    
    [self invalidatesScrollTimer];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleScroll:)];
    self.displayLink.GS_userInfo = @{ kGSScrollingDirectionKey : @(direction) };
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - Target/Action methods

// Tight loop, allocate memory sparely, even if they are stack allocation.
- (void)handleScroll:(CADisplayLink *)displayLink {
    GSScrollingDirection direction = (GSScrollingDirection)[displayLink.GS_userInfo[kGSScrollingDirectionKey] integerValue];
    if (direction == GSScrollingDirectionUnknown) {
        return;
    }
    
    CGSize frameSize = self.collectionView.bounds.size;
    CGSize contentSize = self.collectionView.contentSize;
    CGPoint contentOffset = self.collectionView.contentOffset;
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    // Important to have an integer `distance` as the `contentOffset` property automatically gets rounded
    // and it would diverge from the view's center resulting in a "cell is slipping away under finger"-bug.
    CGFloat distance = rint(self.scrollingSpeed * displayLink.duration);
    CGPoint translation = CGPointZero;
    
    switch(direction) {
        case GSScrollingDirectionUp: {
            distance = -distance;
            CGFloat minY = 0.0f - contentInset.top;
            
            if ((contentOffset.y + distance) <= minY) {
                distance = -contentOffset.y - contentInset.top;
            }
            
            translation = CGPointMake(0.0f, distance);
        } break;
        case GSScrollingDirectionDown: {
            CGFloat maxY = MAX(contentSize.height, frameSize.height) - frameSize.height + contentInset.bottom;
            
            if ((contentOffset.y + distance) >= maxY) {
                distance = maxY - contentOffset.y;
            }
            
            translation = CGPointMake(0.0f, distance);
        } break;
        case GSScrollingDirectionLeft: {
            distance = -distance;
            CGFloat minX = 0.0f - contentInset.left;
            
            if ((contentOffset.x + distance) <= minX) {
                distance = -contentOffset.x - contentInset.left;
            }
            
            translation = CGPointMake(distance, 0.0f);
        } break;
        case GSScrollingDirectionRight: {
            CGFloat maxX = MAX(contentSize.width, frameSize.width) - frameSize.width + contentInset.right;
            
            if ((contentOffset.x + distance) >= maxX) {
                distance = maxX - contentOffset.x;
            }
            
            translation = CGPointMake(distance, 0.0f);
        } break;
        default: {
            // Do nothing...
        } break;
    }
    
    self.currentViewCenter = GSS_CGPointAdd(self.currentViewCenter, translation);
    self.currentView.center = GSS_CGPointAdd(self.currentViewCenter, self.panTranslationInCollectionView);
    self.collectionView.contentOffset = GSS_CGPointAdd(contentOffset, translation);
}


- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer {
    switch(gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
            if (self.collectionView.gsEditing == NO)
            {
                if ([self.dataSource respondsToSelector:@selector(gssb_collectionView:itemDidLongPressedAtIndex:)]) {
                    [self.dataSource gssb_collectionView:self.collectionView itemDidLongPressedAtIndex:currentIndexPath];
                }
                if ([self.dataSource respondsToSelector:@selector(gssb_collectionView:editStateDidChanged:)]) {
                    [self.dataSource gssb_collectionView:self.collectionView editStateDidChanged:YES];
                }
                self.collectionView.gsEditing = YES;
            }
            
        } break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
        } break;
            
        default: break;
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.currentView) {
                [self.currentView removeFromSuperview];
                self.currentView = nil;
                [self invalidateLayout];
            }
            if (self.selectedItemIndexPath == nil)
            {
                NSIndexPath *currentIndexPath = [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
                self.selectedItemIndexPath = currentIndexPath;
                if ([self.delegate respondsToSelector:@selector(gssb_collectionView:layout:willBeginDraggingItemAtIndexPath:)]) {
                    [self.delegate gssb_collectionView:self.collectionView layout:self willBeginDraggingItemAtIndexPath:self.selectedItemIndexPath];
                }
                
                UICollectionViewCell *collectionViewCell = [self.collectionView cellForItemAtIndexPath:self.selectedItemIndexPath];
                
                self.currentView = [[UIView alloc] initWithFrame:collectionViewCell.frame];
                
                collectionViewCell.highlighted = YES;
                UIView *highlightedImageView = [collectionViewCell GS_snapshotView];
                highlightedImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                highlightedImageView.alpha = 1.0f;
                
                collectionViewCell.highlighted = NO;
                UIView *imageView = [collectionViewCell GS_snapshotView];
                imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                imageView.alpha = 0.0f;
                
                [self.currentView addSubview:imageView];
                [self.currentView addSubview:highlightedImageView];
                [self.collectionView addSubview:self.currentView];
                
                self.currentViewCenter = self.currentView.center;
                
                __weak typeof(self) weakSelf = self;
                [UIView
                 animateWithDuration:0.1
                 delay:0.0
                 options:UIViewAnimationOptionBeginFromCurrentState
                 animations:^{
                     __strong typeof(self) strongSelf = weakSelf;
                     if (strongSelf) {
                         highlightedImageView.alpha = 0.0f;
                         imageView.alpha = 1.0f;
                     }
                 }
                 completion:^(BOOL finished) {
                     __strong typeof(self) strongSelf = weakSelf;
                     if (strongSelf) {
                         [highlightedImageView removeFromSuperview];
                         
                         if ([strongSelf.delegate respondsToSelector:@selector(gssb_collectionView:layout:didBeginDraggingItemAtIndexPath:)]) {
                             [strongSelf.delegate gssb_collectionView:strongSelf.collectionView layout:strongSelf didBeginDraggingItemAtIndexPath:strongSelf.selectedItemIndexPath];
                         }
                         //                         [strongSelf invalidateLayout];
                     }
                     
                 }];
                
                [self invalidateLayout];
                
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            self.panTranslationInCollectionView = [gestureRecognizer translationInView:self.collectionView];
            CGPoint viewCenter = self.currentView.center = GSS_CGPointAdd(self.currentViewCenter, self.panTranslationInCollectionView);
            
            [self invalidateLayoutIfNecessary];
            
            switch (self.scrollDirection) {
                case UICollectionViewScrollDirectionVertical: {
                    if (viewCenter.y < (CGRectGetMinY(self.collectionView.bounds) + self.scrollingTriggerEdgeInsets.top)) {
                        [self setupScrollTimerInDirection:GSScrollingDirectionUp];
                    } else {
                        if (viewCenter.y > (CGRectGetMaxY(self.collectionView.bounds) - self.scrollingTriggerEdgeInsets.bottom)) {
                            [self setupScrollTimerInDirection:GSScrollingDirectionDown];
                        } else {
                            [self invalidatesScrollTimer];
                        }
                    }
                } break;
                case UICollectionViewScrollDirectionHorizontal: {
                    if (viewCenter.x < (CGRectGetMinX(self.collectionView.bounds) + self.scrollingTriggerEdgeInsets.left)) {
                        [self setupScrollTimerInDirection:GSScrollingDirectionLeft];
                    } else {
                        if (viewCenter.x > (CGRectGetMaxX(self.collectionView.bounds) - self.scrollingTriggerEdgeInsets.right)) {
                            [self setupScrollTimerInDirection:GSScrollingDirectionRight];
                        } else {
                            [self invalidatesScrollTimer];
                        }
                    }
                } break;
            }
        } break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            NSLog(@"pan end");
            [self invalidatesScrollTimer];
            NSIndexPath *currentIndexPath = self.selectedItemIndexPath;
            
            if (currentIndexPath) {
                if ([self.delegate respondsToSelector:@selector(gssb_collectionView:layout:willEndDraggingItemAtIndexPath:)]) {
                    [self.delegate gssb_collectionView:self.collectionView layout:self willEndDraggingItemAtIndexPath:currentIndexPath];
                }
                
                self.selectedItemIndexPath = nil;
                self.currentViewCenter = CGPointZero;
                
                UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:currentIndexPath];
                
                self.longPressGestureRecognizer.enabled = NO;
                
                __weak typeof(self) weakSelf = self;
                [UIView
                 animateWithDuration:0.3
                 delay:0.0
                 options:UIViewAnimationOptionBeginFromCurrentState
                 animations:^{
                     __strong typeof(self) strongSelf = weakSelf;
                     if (strongSelf) {
                         strongSelf.currentView.center = layoutAttributes.center;
                     }
                 }
                 completion:^(BOOL finished) {
                     
                     self.longPressGestureRecognizer.enabled = YES;
                     
                     __strong typeof(self) strongSelf = weakSelf;
                     if (strongSelf) {
                         for (UIView * subView in strongSelf.currentView.subviews) {
                             [subView removeFromSuperview];
                         }
                         [strongSelf.currentView removeFromSuperview];
                         strongSelf.currentView = nil;
                         [strongSelf invalidateLayout];
                         
                         if ([strongSelf.delegate respondsToSelector:@selector(gssb_collectionView:layout:didEndDraggingItemAtIndexPath:)]) {
                             [strongSelf.delegate gssb_collectionView:strongSelf.collectionView layout:strongSelf didEndDraggingItemAtIndexPath:currentIndexPath];
                         }
                     }
                 }];
            }
        } break;
        default: {
            // Do nothing...
        } break;
    }
}

#pragma mark - UICollectionViewLayout overridden methods

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributesForElementsInRect = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in layoutAttributesForElementsInRect) {
        switch (layoutAttributes.representedElementCategory) {
            case UICollectionElementCategoryCell: {
                [self applyLayoutAttributes:layoutAttributes];
            } break;
            default: {
                // Do nothing...
            } break;
        }
    }
    
    return layoutAttributesForElementsInRect;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    switch (layoutAttributes.representedElementCategory) {
        case UICollectionElementCategoryCell: {
            [self applyLayoutAttributes:layoutAttributes];
        } break;
        default: {
            // Do nothing...
        } break;
    }
    
    return layoutAttributes;
}

#pragma mark - UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        if (self.collectionView.gsEditing)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    if ([self.longPressGestureRecognizer isEqual:gestureRecognizer]) {
        if (self.collectionView.gsEditing)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //    if ([self.longPressGestureRecognizer isEqual:gestureRecognizer]) {
    //        return [self.panGestureRecognizer isEqual:otherGestureRecognizer];
    //    }
    //
    //    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
    //        return [self.longPressGestureRecognizer isEqual:otherGestureRecognizer];
    //    }
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        return NO;
    }
    return YES;
}

#pragma mark - Key-Value Observing methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kGSCollectionViewKeyPath]) {
        if (self.collectionView != nil) {
            [self setupCollectionView];
        } else {
            [self invalidatesScrollTimer];
        }
    }
}

#pragma mark - Notifications

- (void)handleApplicationWillResignActive:(NSNotification *)notification {
    //    self.panGestureRecognizer.enabled = NO;
    //    self.panGestureRecognizer.enabled = YES;
    //    self.longPressGestureRecognizer.enabled = NO;
    //    self.panGestureRecognizer.enabled = NO;
}

#pragma mark - Depreciated methods

#pragma mark Starting from 0.1.0
- (void)setUpGestureRecognizersOnCollectionView {
    // Do nothing...
}


@end

//--------------GSSpringboardLayout End----------------------//

//------------UICollectionView (GSSpringboardLayout)----------//

@implementation UICollectionView (GSSpringboardLayout)

- (void) setGsEditing:(BOOL)gsEditing
{
    NSNumber * editObj = [NSNumber numberWithBool:gsEditing];
    objc_setAssociatedObject(self, @"GS_Editing", editObj, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL) gsEditing
{
    NSNumber * editObjc = objc_getAssociatedObject(self, @"GS_Editing");
    return [editObjc boolValue];
}

- (void) gs_insertItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil) return;
    NSArray * indexList = @[indexPath];
    [UIView animateWithDuration:0.3f animations:^{
        [self insertItemsAtIndexPaths:indexList];
    } completion:^(BOOL finished) {
        
    }];
}

- (void) gs_deleteItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil) return;
    NSArray * indexList = @[indexPath];
    [UIView animateWithDuration:0.3f animations:^{
        [self deleteItemsAtIndexPaths:indexList];
    } completion:^(BOOL finished) {
        
    }];
}

@end


//--------UICollectionView (GSSpringboardLayout) End----------//
