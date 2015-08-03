//
//  TFWHelpResultButton.m
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWHelpResultButton.h"

@interface TFWHelpResultButton ()

@property (nonatomic,strong) UIColor *fillColor;
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation TFWHelpResultButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(6, 6)];
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _fillColor.CGColor);
    [bezier fill];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.frame = CGRectMake(0, 0, 15, frame.size.height);
    self.textLabel.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
    self.textLabel.font = [UIFont systemFontOfSize:12];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textColor = [UIColor whiteColor];
    [self addSubview:_textLabel];
    
    return self;
}

-(void)setText:(NSString *)text
{
    self.textLabel.text = text;
}

-(void)setColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsLayout];
}


@end
