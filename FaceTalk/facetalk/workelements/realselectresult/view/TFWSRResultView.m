//
//  TFWSRResultView.m
//  demo
//
//  Created by wen on 15/7/26.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSRResultView.h"
#import "TFWSRRoundView.h"
#import "TFWSRKeyView.h"

@interface TFWSRResultView ()

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) CGFloat rate;

@property (nonatomic,strong) UIImageView *pathView;
@property (nonatomic,assign) CGPoint currentPoint;
@property (nonatomic,strong) TFWSRRoundView *roundView;
@property (nonatomic,strong) NSString *roundTitle;
@property (nonatomic,assign) int roundScore;
@property (nonatomic,strong) UILabel *rateLabel;
@property (nonatomic,strong) TFWSRKeyView *keyView;
@property (nonatomic,assign) int index;

@end

@implementation TFWSRResultView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createResultViewCenter:(CGPoint)center andTitle:(NSString *)title andText:(NSString *)text andRate:(CGFloat)rate roundTitle:(NSString *)roundtitle roundScore:(int)score
{
    TFWSRResultView *resultView = [[TFWSRResultView alloc] initWithFrame:CGRectZero];
    resultView.center = center;
    resultView.title = title;
    resultView.text = text;

    resultView.roundTitle = roundtitle;
    resultView.roundScore = score;
    
    [resultView buildView];
    
    resultView.rate = rate;
    
    resultView.index = 0;
    
    return resultView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 480, 480)];
    if (self) {

    }
    
    return self;
}

-(void)setRate:(CGFloat)rate
{
    _rate = rate;
    _pathView.image = [self createPathwithRate:_rate];
    [NSTimer scheduledTimerWithTimeInterval:0.015 target:self selector:@selector(timeAni:) userInfo:nil repeats:YES];
}

-(void)timeAni:(NSTimer *)timer
{
    int num = (int)(_rate / 0.01);
    if (num <= _index) {
        [timer invalidate];
        if (self.animationDoneblock) {
            self.animationDoneblock();
        }
    }
    
//    _pathView.image = [self createPathwithRate:_index / 100.0];
    _roundView.center = CGPointMake(240, 53);
    _rateLabel.text = [NSString stringWithFormat:@"%2d%@",_index,@"%"];
    [_keyView setRate:_index / 100.0];
    _index++;
}

-(void)buildView
{
    [self createPath];
    [self createRoundView];
    [self createTitle];
    [self createRate];
    [self createText];
    [self createKey];
}

-(void)createPath
{
    _pathView = [[UIImageView alloc] initWithImage:[self createPathwithRate:self.rate]];
    _pathView.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    [self addSubview:_pathView];
}

-(void)createRoundView
{
    _roundView = [TFWSRRoundView createRoundWithCenter:self.currentPoint Title:self.roundTitle Score:self.roundScore];
    [self addSubview:_roundView];
}

-(void)setCurrentPoint:(CGPoint)currentPoint
{
    _roundView.center = currentPoint;
    _currentPoint = currentPoint;
}

-(void)createTitle
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22.4];
    titleLabel.textColor = [UIColor colorWithRed:113 / 255.0 green:113 / 255.0 blue:113 / 255.0 alpha:1];
    titleLabel.center = CGPointMake(self.bounds.size.width / 2.0, 145);
    titleLabel.text = self.title;
    [self addSubview:titleLabel];
}

-(void)createRate
{
    _rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 240)];
    _rateLabel.textAlignment = NSTextAlignmentCenter;
    _rateLabel.font = [UIFont systemFontOfSize:140.0];
    _rateLabel.textColor = [UIColor colorWithRed:186 / 255.0 green:12 / 255.0 blue:58 / 255.0 alpha:1];
    _rateLabel.center = CGPointMake(self.bounds.size.width / 2.0, 220);
    _rateLabel.text = [NSString stringWithFormat:@"%2.f%@",self.rate * 100,@"%"];
    [self addSubview:_rateLabel];
}

-(void)createText
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont boldSystemFontOfSize:28];
    textLabel.textColor = [UIColor colorWithRed:113 / 255.0 green:113 / 255.0 blue:113 / 255.0 alpha:1];
    textLabel.center = CGPointMake(self.bounds.size.width / 2.0, 405);
    textLabel.text = self.text;
    [self addSubview:textLabel];
}

-(void)createKey
{
    _keyView = [TFWSRKeyView createKeyViewwithCenter:CGPointMake(self.bounds.size.width / 2.0, 350) andRate:_rate];
    
    [self addSubview:_keyView];
}


-(UIImage *)createPathwithRate:(CGFloat)rate
{
    CGFloat radio = 375 / 2.0;
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.frame.size.width, self.frame.size.height), 0, 1.0);
    CGFloat start = -M_PI / 2.0 * 3 + M_PI / 6.0;
    CGFloat end = M_PI / 2.0 - M_PI / 6.0 ;
    CGFloat dif = (end - start) * rate + start;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radio startAngle:start endAngle:dif clockwise:YES];
    [path setLineWidth:5];
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 15);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor colorWithRed:182 / 255.0 green:12 / 255.0 blue:58 / 255.0 alpha:1].CGColor);
    _currentPoint = [path currentPoint];
    [path stroke];
    
    path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radio startAngle:dif endAngle:end clockwise:YES];
    [path setLineWidth:5];
    //    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 15);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor colorWithRed:113 / 255.0 green:113 / 255.0 blue:113 / 255.0 alpha:1].CGColor);
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


@end
