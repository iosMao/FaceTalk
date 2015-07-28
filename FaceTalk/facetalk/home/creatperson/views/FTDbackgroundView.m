//
//  FTDbackgroundView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDbackgroundView.h"

@implementation FTDbackgroundView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha=0.5;
        self.backgroundColor=[UIColor blackColor];
        // Initialization code
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
