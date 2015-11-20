//
//  FTDAgentDetailScoreView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/29.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDAgentDetailScoreView.h"

@implementation FTDAgentDetailScoreView
@synthesize lblGrayScore,lblRedScore,lblTitle,imgBtnRed,imgBtnWhite,imgGrayTriangle,imgRedTriangle,textDesc;
+(FTDAgentDetailScoreView *)setCustomview
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FTDAgentDetailScoreView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}

-(void)awakeFromNib
{
    self.backgroundColor =[UIColor clearColor];
    
}
-(void)setTitle:(NSString *)title andOldScore:(int)oldscore andNewScore:(int)newscore andDesc:(NSString *)desc
{
    lblTitle.text=title;
    CGFloat oldX=42+25*oldscore;
    imgBtnWhite.center=CGPointMake(oldX, 47);
    imgGrayTriangle.center=CGPointMake(oldX, 25);
    lblGrayScore.text=[NSString stringWithFormat:@"%d分",oldscore];
    lblGrayScore.center=CGPointMake(oldX, 14);
    lblGrayScore.hidden = YES;
    
    CGFloat newX=42+25*newscore;
    imgBtnRed.center=CGPointMake(newX, 47);
    imgRedTriangle.center=CGPointMake(newX, 25);
    lblRedScore.text=[NSString stringWithFormat:@"%d分",newscore];
    lblRedScore.center=CGPointMake(newX, 14);
    lblRedScore.hidden = YES;
    
    textDesc.text=desc;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
