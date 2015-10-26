//
//  FTDTeacherTeamView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/12.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDTeacherTeamView.h"

@implementation FTDTeacherTeamView
@synthesize scrollBG;
+(FTDTeacherTeamView *)initCustomview
{
    NSArray* nibView = [[NSBundle mainBundle] loadNibNamed:@"FTDTeacherTeamView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}
-(void)awakeFromNib
{
    scrollBG.contentSize = CGSizeMake(887*4, 622);
    scrollBG.pagingEnabled = YES;
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(887*i, 0, 887, 622)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"FTD_TeacherTeam%d.png", i]];
        [scrollBG addSubview:imageView];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageCol.currentPage = page;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
