//
//  FTDDevWayView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/12.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDDevWayView.h"

@implementation FTDDevWayView
+(FTDDevWayView *)initCustomview
{
    NSArray* nibView = [[NSBundle mainBundle] loadNibNamed:@"FTDDevWayView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}
-(void)awakeFromNib
{
    self.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FTD_DevWay" ofType:@"png"]];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
