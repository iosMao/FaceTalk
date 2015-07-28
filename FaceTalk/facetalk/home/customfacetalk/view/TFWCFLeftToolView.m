//
//  TFWLeftToolView.m
//  demo
//
//  Created by wen on 15/7/17.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWCFLeftToolView.h"

@implementation TFWCFLeftToolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 20, 80 / 2.0, 1496 / 2.0)];
    if (self) {
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:self.bounds];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tfw_cf_lefttool" ofType:@"png"]];
    [self addSubview:back];
}

@end
