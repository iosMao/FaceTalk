//
//  FTDShareView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/11.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDShareView.h"

@implementation FTDShareView
@synthesize viewBG;
+(FTDShareView *)initCustomview
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FTDShareView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
-(void)awakeFromNib
{
    self.backgroundColor=[UIColor clearColor];
    [self.viewBG.layer setMasksToBounds:YES];
    [self.viewBG.layer setCornerRadius:5];
    
}
- (IBAction)shareQQclick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(shareQQ)]) {
        [self.delegate shareQQ];
    }
}
- (IBAction)shareWeChatclick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(shareWeChat)]) {
        [self.delegate shareWeChat];
    }
}
- (IBAction)cancelclick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(cancelview)]) {
        [self.delegate cancelview];
    }
}

- (IBAction)sendclick:(id)sender {
    [self.delegate sendtextEmail:self.textEmail.text];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
