//
//  FTDHomAlertFinishView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomAlertFinishView.h"

@implementation FTDHomAlertFinishView
+(FTDHomAlertFinishView *)initCustomview
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FTDHomAlertFinishView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
 

- (IBAction)gotoCreatMenuclick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(gotoCreatMenu)]) {
        [self.delegate gotoCreatMenu];
    }
}

- (IBAction)gotoMenuclick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(gotoMenu)]) {
        [self.delegate gotoMenu];
    }
}

- (IBAction)cancelclick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(homeAlertFinishCancelClick)]) {
        [self.delegate homeAlertFinishCancelClick];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
