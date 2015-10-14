//
//  TFWSRRoundView.m
//  demo
//
//  Created by wen on 15/7/26.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSRRoundView.h"

@interface TFWSRRoundView ()

@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) int score;
@property (nonatomic,strong) UILabel *scoreLable;
@property (nonatomic,strong) UILabel *titleLable;

@end

@implementation TFWSRRoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createRoundWithCenter:(CGPoint)center Title:(NSString *)title Score:(int)score
{
    TFWSRRoundView *rv = [[TFWSRRoundView alloc] initWithFrame:CGRectZero];
    rv.center = center;
    [rv buildView];
    rv.title = title;
    rv.score = score;
    
    return rv;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 95, 95)];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:186 / 255.0 green:12 / 255.0 blue:58 / 255.0 alpha:1];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.bounds.size.width / 2.0;
    }
    
    return self;
}

-(void)buildView
{
    [self createTitleLabel];
    [self createScoreLabel];
}

-(void)createTitleLabel
{
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.height, self.bounds.size.height / 2.0)];
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.numberOfLines = 0;
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.font = [UIFont boldSystemFontOfSize:11.3];
    
    [self addSubview:_titleLable];
}



-(void)createScoreLabel
{
    _scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height / 2.0 - 10, self.bounds.size.height, self.bounds.size.height / 2.0)];
    _scoreLable.textColor = [UIColor whiteColor];
    _scoreLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_scoreLable];
}

-(void)setTitle:(NSString *)title
{
    _titleLable.text = title;
}

-(void)setScore:(int)score
{
    _score = score;
    NSAttributedString *number = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",_score] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:45]}];
    NSAttributedString *fen = [[NSAttributedString alloc] initWithString:@"分" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] init];
    [attribute appendAttributedString:number];
    [attribute appendAttributedString:fen];
    
    _scoreLable.attributedText = attribute;
}

@end
