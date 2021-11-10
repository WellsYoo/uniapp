//
//  DrawTextView.m
//  
//
//  Created by YWH on 13/11/24.
//
//

#import "HMYNWCView.h"


@interface HMYNWCView()

@property(nonatomic, strong) NSString * text;
@property(nonatomic, assign) BOOL isLetter;
@end

@implementation HMYNWCView

-(id)initWithFrame:(CGRect)frame Text:(NSString *)text Letter:(BOOL)isLetter{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ UIColor clearColor];
        self.text = text;
        self.isLetter = isLetter;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1);
    CGContextFillEllipseInRect(context, self.bounds);
    
    UIColor *stringColor = [UIColor whiteColor];
    NSDictionary *attrs = @{NSForegroundColorAttributeName:stringColor, NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:25]};
    CGFloat offset = 0;
    if (_isLetter) {
        offset = 3;
    }
    
    CGFloat orignX = (rect.size.width - 25)/2;
    [self.text drawInRect:CGRectMake(orignX + offset, orignX, 25, 25) withAttributes:attrs];
}
@end
