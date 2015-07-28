//
//  TFWSTOrderRoundItem.m
//  demo
//
//  Created by wen on 15/7/18.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSTOrderRoundItem.h"

@interface TFWSTOrderRoundItem ()

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subtitle;

@end

@implementation TFWSTOrderRoundItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createRoundItemWithNumber:(NSInteger)index andCenter:(CGPoint)center andTitle:(NSString *)title andSubtitle:(NSString *)subtitle
{
    TFWSTOrderRoundItem *item = [[TFWSTOrderRoundItem alloc] initWithFrame:CGRectZero];
    item.index = index;
    item.center = center;
    item.title = title;
    item.subtitle = subtitle;
    [item buildView];
    
    return item;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 154, 154)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)buildView
{
    [self buildBackImage];
    [self buildNumber];
    [self buildTitleLabel];
    [self createSubTitleLabel];
}

-(void)buildBackImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"tfw_sf_round"];
    [self addSubview:imageView];
}

-(void)buildNumber
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(48, 26, 50, 58)];
    label.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:77];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%d",self.index];
    [self addSubview:label];
}

-(void)buildTitleLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28, 76, 100, 50)];
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:21.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = self.title;
    [self addSubview:label];
}

-(void)createSubTitleLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28, 100, 100, 50)];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = self.subtitle;
    [self addSubview:label];
}


@end
