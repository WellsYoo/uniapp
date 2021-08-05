//
//  collectionHeadView.m
//  
//
//  Created by YWH on 15/11/20.
//
//

#import "NCWCollectionHeadView.h"
#import "DBJWidgetInfoManager.h"

#define kLineColor [UIColor colorWithRed:0.85 green:0.87 blue:0.89 alpha:1.0]

@interface NCWCollectionHeadView(){
    UIView   *_topView;
    UILabel  *_tipLabel;
    UISwitch *_switchButton;
    UIView   *_topLine;
    UIView   *_bottomLine;
    UIView   *_titleBackgroundView;
    UILabel  *_titleLabel;
}

@end




@implementation NCWCollectionHeadView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

         _topView= [[UIView alloc] init];
        _topView.backgroundColor = colorWithRGB(efeff4);
        [self addSubview:_topView];
        
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"通知栏编辑按钮";
        _tipLabel.textColor = colorWithRGB(000000);
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_tipLabel];
       
        _switchButton = [[UISwitch alloc] init];
         NSUserDefaults * widgetDefaults = [[NSUserDefaults alloc] initWithSuiteName:[DBJWidgetInfoManager groupIdentifier]];
        if (![[NSUserDefaults standardUserDefaults] objectForKey:kFirstTimeLaunch]) {
            [[NSUserDefaults standardUserDefaults] setObject: @(YES) forKey:kFirstTimeLaunch];
            [[NSUserDefaults standardUserDefaults] synchronize];
           
            NSUserDefaults * widgetDefaults = [[NSUserDefaults alloc] initWithSuiteName:[DBJWidgetInfoManager groupIdentifier]];
            [widgetDefaults setObject:@(YES) forKey:kSwitch];
            [widgetDefaults synchronize];
            [_switchButton setOn:YES];
        }else{
            BOOL ncwSwitch = [[widgetDefaults objectForKey:kSwitch] boolValue];
            [_switchButton setOn: ncwSwitch];
        }
        [_switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_switchButton];
        
        _topLine= [[UIView alloc] init];
        _topLine.backgroundColor = kLineColor;
        [self addSubview:_topLine];
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = kLineColor;
        [self addSubview:_bottomLine];
        
        
        _titleBackgroundView = [[UIView alloc] init];
        _titleBackgroundView.backgroundColor = colorWithRGB(efeff4);
        [self addSubview: _titleBackgroundView];
        
        _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(12, 16, frame.size.width, 18)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = colorWithRGB(808080);
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.text = @"已添加（长按图标可编辑）";
        [_titleBackgroundView addSubview:_titleLabel];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds = self.bounds;

    _topView.frame = CGRectMake(0, 0, bounds.size.width, 15);
    
    CGRect f1 = bounds;
    f1.origin.x = 12;
    f1.origin.y = 27.5;
    f1.size.width = 150;
    f1.size.height = 16;
    _tipLabel.frame = f1;
    
    CGRect f2 = f1;
    f2.origin.x = bounds.size.width - 12 - 51;
    f2.origin.y = 20;
    f2.size.width = 40;
    f2.size.height = 24;
    _switchButton.frame = f2;
    
    CGFloat lineHeight = 1.0 / [UIScreen mainScreen].scale;
    CGRect f3 = CGRectMake(0, 15, CGRectGetWidth(bounds), lineHeight);
    _topLine.frame = f3;
    
    CGRect f4 = f3;
    f4.origin.y = 56 - lineHeight;
    _bottomLine.frame = f4;
    
    CGRect f5 = f4;
    f5.origin.y = CGRectGetMaxY(f4);
    f5.size.height = 36;
    _titleBackgroundView.frame = f5;
}



-(void)switchAction:(id)sender
{
    UISwitch *switchBtn = (UISwitch*)sender;
    BOOL show = [switchBtn isOn];
    NSUserDefaults * widgetDefaults = [[NSUserDefaults alloc] initWithSuiteName:[DBJWidgetInfoManager groupIdentifier]];
    [widgetDefaults setObject:@(show) forKey:kSwitch];
    [widgetDefaults synchronize];
}



@end
