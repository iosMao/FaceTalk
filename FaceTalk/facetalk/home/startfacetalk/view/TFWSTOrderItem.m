//
//  TFWSTOrderItem.m
//  demo
//
//  Created by wen on 15/7/18.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSTOrderItem.h"
#import "TFWSTOrderRoundItem.h"

#define DURATION 0.8
#define STARTX -400

@interface TFWSTOrderItem ()

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) float delay;

@end

@implementation TFWSTOrderItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createItemWithCenter:(CGPoint)center andIndex:(NSInteger)index delay:(float)time
{
    TFWSTOrderItem *item = [[TFWSTOrderItem alloc] initWithFrame:CGRectZero];
    item.center = center;
    item.index = index;
    item.delay = time;
    [NSTimer scheduledTimerWithTimeInterval:item.delay target:item selector:@selector(buildView) userInfo:nil repeats:NO];
    return item;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 380, 380)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)buildView
{
    switch (self.index) {
        case 1:
            [self createOne];
            break;
            
        case 2:
            [self createTwo];
            break;
            
        case 3:
            [self createThree];
            break;
            
        case 4:
            [self createFour];
            break;
            
        default:
            break;
    }
}

-(void)createOne
{
    TFWSTOrderRoundItem *item = [TFWSTOrderRoundItem createRoundItemWithNumber:1 andCenter:CGPointMake(STARTX, 190) andTitle:@"真英才" andSubtitle:@"傲人风采"];
    [self addSubview:item];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 50, 106, 219)];
    imageView.image = [UIImage imageNamed:@"tfw_sf_tie"];
    [self addSubview:imageView];
    
    CGAffineTransform transform = imageView.transform;
    imageView.transform = CGAffineTransformScale(transform, 0, 0);
    [UIView animateWithDuration:DURATION animations:^{
        item.center = CGPointMake(190, 190);
        imageView.transform = CGAffineTransformScale(transform, 1, 1);
    }];
}

-(void)createTwo
{
    TFWSTOrderRoundItem *item = [TFWSTOrderRoundItem createRoundItemWithNumber:2 andCenter:CGPointMake(STARTX, 190) andTitle:@"真选择" andSubtitle:@"成就事业"];
    [self addSubview:item];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 161, 157)];
    imageView.image = [UIImage imageNamed:@"tfw_sf_head"];
    [self addSubview:imageView];
    
    CGAffineTransform transform = imageView.transform;
    imageView.transform = CGAffineTransformScale(transform, 0, 0);
    [UIView animateWithDuration:DURATION animations:^{
        item.center = CGPointMake(190, 190);
        imageView.transform = CGAffineTransformScale(transform, 1, 1);
    }];
}

-(void)createThree
{
    TFWSTOrderRoundItem *item = [TFWSTOrderRoundItem createRoundItemWithNumber:3 andCenter:CGPointMake(STARTX, 190) andTitle:@"真精彩" andSubtitle:@"友邦邦你"];
    [self addSubview:item];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(104, 40, 156, 229)];
    imageView.image = [UIImage imageNamed:@"tfw_sf_pan"];
    [self addSubview:imageView];
    
    CGAffineTransform transform = imageView.transform;
    imageView.transform = CGAffineTransformScale(transform, 0, 0);
    [UIView animateWithDuration:DURATION animations:^{
        item.center = CGPointMake(190, 190);
        imageView.transform = CGAffineTransformScale(transform, 1, 1);
    }];
}

-(void)createFour
{
    TFWSTOrderRoundItem *item = [TFWSTOrderRoundItem createRoundItemWithNumber:4 andCenter:CGPointMake(STARTX, 190) andTitle:@"真成就" andSubtitle:@"我在友邦"];
    [self addSubview:item];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(138, 40, 197, 201)];
    imageView.image = [UIImage imageNamed:@"tfw_sf_cup"];
    [self addSubview:imageView];
    
    CGAffineTransform transform = imageView.transform;
    imageView.transform = CGAffineTransformScale(transform, 0, 0);
    [UIView animateWithDuration:DURATION animations:^{
        item.center = CGPointMake(190, 190);
        imageView.transform = CGAffineTransformScale(transform, 1, 1);
    }];
}

@end
