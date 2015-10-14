//
//  TFWSRKeyView.m
//  demo
//
//  Created by wen on 15/7/28.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSRKeyView.h"

@interface TFWSRKeyView ()

@property (nonatomic,assign) CGFloat rate;

@property (nonatomic,strong) NSMutableArray *btArray;
@end

@implementation TFWSRKeyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createKeyViewwithCenter:(CGPoint)center andRate:(CGFloat)rate
{
    TFWSRKeyView *key = [[TFWSRKeyView alloc] initWithFrame:CGRectMake(0, 0, 210, 80)];
    key.rate = rate;
    key.center = center;
    
    [key buildView];
    
    return key;
}

-(void)setRate:(CGFloat)rate
{
    _rate = rate;
    [self setBtRate];
}

-(void)buildView
{
    _btArray = [[NSMutableArray alloc] init];
    
    for (int i = 2; i < 3; i++) {
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48.5, 50)];
        bt.center = CGPointMake(self.bounds.size.width / 5.0 * i + self.bounds.size.width / 10.0, self.bounds.size.height / 2.0);
        bt.userInteractionEnabled = NO;
//        [bt setImage:[UIImage imageNamed:@"tfw_sr_key_gray"] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"tfw_sr_key"] forState:UIControlStateNormal];
        [self addSubview:bt];
        [self.btArray addObject:bt];
    }
    
    //[self setBtRate];
}

-(void)setBtRate
{
//    int num = (int)(self.rate * 100) / 20;
//    for (int i = 0; i < 5; i++) {
//        UIButton *bt = [self.btArray objectAtIndex:i];
//        if (i < num) {
//            bt.selected = YES;
//        }
//        else
//        {
//            bt.selected = NO;
//        }
//    }
}


@end
