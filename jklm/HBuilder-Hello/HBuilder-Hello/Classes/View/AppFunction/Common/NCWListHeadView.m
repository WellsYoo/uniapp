//
//  ListHeadView.m
//  MobileAssist
//
//  Created by fuyongle on 14-10-13.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//

#import "NCWListHeadView.h"
#import "NCWSegmentButton.h"
//#import "BaseScrollView.h"

#define kBtnMaxCount 4  //4个或4个以下 按钮使用固定宽度
#define kBtnSpacing 16

@interface NCWListHeadView()
{
    UIScrollView   *_scrollView;
    UIView         *_selectedView;//标题选中视图
    
    NSMutableArray *_btns;        //标题按钮
    NSUInteger     _count;        //标题个数
    NSInteger      _currentIndex;
    NSUInteger     _defaultIndex;

    BOOL           _isLoad;
}
@end

@implementation NCWListHeadView
@synthesize listDelegate;
@synthesize array;
@synthesize defaultIndex = _defaultIndex;
@synthesize currentIndex = _currentIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _isLoad = NO;
        _currentIndex = -1;
        _defaultIndex = 0; //默认选中第一个

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 12, CGRectGetWidth(self.frame), 26)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentInset = UIEdgeInsetsZero;
        _scrollView.clipsToBounds = YES;
        _scrollView.layer.cornerRadius = 4;
        _scrollView.layer.borderWidth = 1;
        _scrollView.layer.borderColor = [UIColor colorWithHexString:@"2e92ff"].CGColor;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        //底部边框
//        CGSize size = frame.size;
//        float lineHeight = 1.0 / [UIScreen mainScreen].scale;
//        UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(0, size.height - lineHeight, size.width, lineHeight)];
//        splitLine.backgroundColor = [UIColor colorWithRed:0.85 green:0.87 blue:0.89 alpha:1.0];
//        [self addSubview:splitLine];
        
//        //选中视图
//        _selectedView = [[UIView alloc] init];
//        _selectedView.frame = CGRectMake(0, 0, 0, frame.size.height);
//        _selectedView.backgroundColor = kSegmentSelectedColor;
//        [_scrollView addSubview:_selectedView];
        
        _btns = [[NSMutableArray alloc] init];
    }
	
    return self;
}


-(void)layoutSubviews
{
    if(listDelegate == nil)
        return;
    
    if(_isLoad)
        return;
    
    _isLoad = YES;
    
    [self reloadView];
}

-(void)reloadView
{
    NSUInteger count = [listDelegate listHeadViewForCount];
    
    if (count <= 0) {
        return;
    }

    _count = count;
    
    [_btns removeAllObjects];
    
//    CGRect frame = _selectedView.frame;
//    frame.size.width = self.frame.size.width / _count;
//    _selectedView.frame = frame;
    
    CGFloat totalWidth = 0;
    CGFloat width = 0;
    if (_count <= kBtnMaxCount) {
        totalWidth = _scrollView.bounds.size.width;
        width = totalWidth /_count;
    }
    
    CGFloat orginX = 0;
    for(int i = 0; i < _count; i++)
    {
        NSString *btnTitle = [self.array objectAtIndex:i];
        
        if (_count > kBtnMaxCount) {
            CGSize size = [btnTitle sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
            width = 2*kBtnSpacing + size.width;
            totalWidth += width;
        }
        
        NCWSegmentButton *btn = [[NCWSegmentButton alloc] initWithFrame:CGRectMake(orginX, 0, width, _scrollView.bounds.size.height)];
        btn.tag = i;
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
        [_btns addObject:btn];
        if (i == 0) {
            [btn setSelected:YES];
        }else {
            [btn setSelected:NO];
        }
        
        orginX += width;
    }
    
    _scrollView.contentSize = CGSizeMake(totalWidth, _scrollView.frame.size.height);
    
    if(_currentIndex >=0 && _currentIndex < _count){
        [self setSelected:_currentIndex];
    }else{
        [self setSelected:_defaultIndex];
    }
}

// 更新按钮文字
- (void)updateBtnTitles
{
    for(int i = 0; i < _count; i++) {
        UIButton *btn = [_btns objectAtIndex:i];
        NSString *btnTitle= [self.array objectAtIndex:i];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
    }
}

// 点击按钮
- (void)press:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (_currentIndex == btn.tag) {
        return;
    }
    if (listDelegate) {
        [listDelegate listHeadView:self press:btn];
    }
    [self setSelected:btn.tag];
}

- (void)setBtnSelected:(NSUInteger)index
{
    if (_currentIndex >= 0) {
        UIButton *btn = [_btns objectAtIndex:_currentIndex];
        btn.selected = NO;
    }
    
    UIButton *btn = [_btns objectAtIndex:index];
    btn.selected = YES;
}

- (void)setSelected:(NSUInteger)index
{
    if(index >= _count || index == _currentIndex)
        return;
    
    [self setBtnSelected:index];
    _currentIndex = index;
}

- (void)scrollToIndex:(NSUInteger)index
{
    [self setSelected:index];
}

-(void)setDefaultIndex:(NSUInteger)index
{
    _defaultIndex = index;
    if (_isLoad) {
        [self setSelected:index];
    }
}

@end

