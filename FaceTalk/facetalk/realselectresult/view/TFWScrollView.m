//
//  TFWScrollView.m
//  demo
//
//  Created by wen on 15/7/28.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWScrollView.h"
#import "TFWSRResultView.h"

@interface TFWScrollView ()

@property (nonatomic,strong) NSMutableArray *viewArray;
@property (nonatomic,strong) NSArray *pointArray;

@end

@implementation TFWScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createScrollWithCenter:(CGPoint)center
{
    TFWScrollView *sc = [[TFWScrollView alloc] initWithFrame:CGRectMake(0, 0, 880, 450)];
    sc.center = center;
    [sc buildView];
    [sc buildLeftButton];
    [sc buildRightButton];
    
    return sc;
}

-(void)buildView
{
    _viewArray = [[NSMutableArray alloc] init];
    _pointArray = @[@-130,@130,@420,@710,@970];
    self.layer.masksToBounds = YES;
    
    [_viewArray addObject:[TFWSRResultView createResultViewCenter:CGPointMake([[_pointArray objectAtIndex:0] intValue], 220) andTitle:@"满意度" andText:@"学习成长" andRate:0.42 roundTitle:@"现状与\n期望相差" roundScore:3]];
    
    [_viewArray addObject:[TFWSRResultView createResultViewCenter:CGPointMake([[_pointArray objectAtIndex:1] intValue], 220) andTitle:@"满意度" andText:@"学习成长" andRate:0.42 roundTitle:@"现状与\n期望相差" roundScore:3]];
    
    [_viewArray addObject:[TFWSRResultView createResultViewCenter:CGPointMake([[_pointArray objectAtIndex:2] intValue], 220) andTitle:@"满意度" andText:@"学习成长" andRate:0.42 roundTitle:@"现状与\n期望相差" roundScore:3]];
    
    [_viewArray addObject:[TFWSRResultView createResultViewCenter:CGPointMake([[_pointArray objectAtIndex:3] intValue], 220) andTitle:@"满意度" andText:@"学习成长" andRate:0.42 roundTitle:@"现状与\n期望相差" roundScore:3]];
    
    [_viewArray addObject:[TFWSRResultView createResultViewCenter:CGPointMake([[_pointArray objectAtIndex:4] intValue], 220) andTitle:@"满意度" andText:@"学习成长" andRate:0.42 roundTitle:@"现状与\n期望相差" roundScore:3]];
    
    for (int i = 0; i < [_viewArray count]; i++) {
        if (i != 2) {
            CGAffineTransform trans = CGAffineTransformIdentity;
            trans = CGAffineTransformScale(trans, 0.3, 0.3);
            ((UIView *)[_viewArray objectAtIndex:i]).transform = trans;
        }
        [self addSubview:[_viewArray objectAtIndex:i]];
    }
}

-(void)buildLeftButton
{
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 195, 23, 42)];
    [left setImage:[UIImage imageNamed:@"tfw_sr_left"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:left];
}

-(void)buildRightButton
{
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(810, 195, 23, 42)];
    [right setImage:[UIImage imageNamed:@"tfw_sr_right"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:right];
}

-(void)leftAction:(UIButton *)bt
{
    TFWSRResultView *v1 = [_viewArray objectAtIndex:0];
    TFWSRResultView *v2 = [_viewArray objectAtIndex:1];
    TFWSRResultView *v3 = [_viewArray objectAtIndex:2];
    TFWSRResultView *v4 = [_viewArray objectAtIndex:3];
    TFWSRResultView *v5 = [_viewArray objectAtIndex:4];
    
    CGPoint point = v1.center;
    v1.center = v5.center;
    [UIView animateWithDuration:0.6 animations:^{
        v5.center = v4.center;
        v4.center = v3.center;
        v4.transform = CGAffineTransformIdentity;
        v3.transform = CGAffineTransformScale(v3.transform, 0.3, 0.3);
        v3.center = v2.center;
        v2.center = point;
    }];
    
    [_viewArray removeObject:v1];
    [_viewArray addObject:v1];
}

-(void)rightAction:(UIButton *)bt
{
    TFWSRResultView *v1 = [_viewArray objectAtIndex:0];
    TFWSRResultView *v2 = [_viewArray objectAtIndex:1];
    TFWSRResultView *v3 = [_viewArray objectAtIndex:2];
    TFWSRResultView *v4 = [_viewArray objectAtIndex:3];
    TFWSRResultView *v5 = [_viewArray objectAtIndex:4];

    
    CGPoint point = v5.center;
    v5.center = v1.center;
    [UIView animateWithDuration:0.6 animations:^{
        v1.center = v2.center;
        v2.center = v3.center;
        v3.center = v4.center;
        v4.center = point;
        v2.transform = CGAffineTransformIdentity;
        v3.transform = CGAffineTransformScale(v3.transform, 0.3, 0.3);
    }];
    
    [_viewArray removeLastObject];
    [_viewArray insertObject:v5 atIndex:0];
}


@end