//
//  TFWSCPipeView.m
//  demo
//
//  Created by wen on 15/7/23.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "TFWSCPipeView.h"

@interface TFWSCPipeView ()

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIImageView *btImageView;
@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,assign) BOOL flag;
@property (nonatomic,assign) BOOL is_hope;

@end

@implementation TFWSCPipeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createPipeWithCenter:(CGPoint)center Title:(NSString *)title isHope:(BOOL)is_hope
{
    TFWSCPipeView *sc = [[TFWSCPipeView alloc] initWithFrame:CGRectMake(0, 0, 60, 210)];
    sc.center = center;
    sc.title = title;
    sc.is_hope = is_hope;
    [sc buildView];
    
    return sc;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }

    return self;
}

-(void)setPipevalue:(float)pipevalue
{
    _pipevalue = pipevalue;
    _btImageView.center = CGPointMake(self.bounds.size.width / 2.0, 32 + 112 * (1 - pipevalue));
    [self setNeedsLayout];
}

-(void)buildView
{
    [self createBackImage];
    [self createButtonImage];
    [self createTitleLabel];
    [self createScoreLabel];
}

-(void)createBackImage
{
    NSString *imageName = self.is_hope ? @"tfw_sc_movepie_hope" : @"tfw_sc_movepie";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.center = CGPointMake(self.bounds.size.width / 2.0, imageView.frame.size.height / 2);
    [self addSubview:imageView];
}

-(void)createButtonImage
{
    _btImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tfw_sc_movebt"]];
    _btImageView.center = CGPointMake(self.bounds.size.width / 2.0, 32);

    [self addSubview:_btImageView];
}

-(void)createTitleLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 60, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = self.is_hope ? [UIColor whiteColor] : [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.text = self.title;
    [self addSubview:label];
}

-(void)createScoreLabel
{
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 60, 20)];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.textColor = self.is_hope ? [UIColor whiteColor] : [UIColor blackColor];
    _scoreLabel.font = [UIFont boldSystemFontOfSize:13];
    _scoreLabel.text = self.title;
    [self addSubview:_scoreLabel];
    if (_is_hope) {
        _scoreLabel.textColor = [UIColor whiteColor];
    }else{
        _scoreLabel.textColor = [UIColor colorWithRed:0.82 green:0.1 blue:0.28 alpha:1];;
    }
    _scoreLabel.text = @"5分";
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self convertPoint:point toView:_btImageView];
    if ([_btImageView.layer containsPoint:point]) {
        _flag = YES;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (_flag) {
        CGFloat y = point.y;
        if (y > 176 - 32) {
            y = 176 - 32;
        }
        else if(y < 32)
        {
            y = 32;
        }
        _btImageView.center = CGPointMake(self.bounds.size.width / 2.0, y);
        
        self.pipevalue = (144 - y) / 112.0;
        _scoreLabel.text = [NSString stringWithFormat:@"%.0f分",(int)(self.pipevalue * 10) / 1.0];
        if (self.valueChangeblock) {
            self.valueChangeblock(self);
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _flag = NO;
}

@end
