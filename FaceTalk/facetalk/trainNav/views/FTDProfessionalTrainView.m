//
//  FTDProfessionalTrainView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/12.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDProfessionalTrainView.h"

@implementation FTDProfessionalTrainView
@synthesize scrollBG,pageCol,segmentCol;
- (IBAction)selectClick:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [self changeDesc:0];
    }
    else if ([sender selectedSegmentIndex] == 1)
    {
        [self changeDesc:1];
    }
    else{
        [self changeDesc:2];
    }
    
    
}

+(FTDProfessionalTrainView *)initCustomview
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FTDProfessionalTrainView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}
-(void)awakeFromNib
{
    scrollBG.pagingEnabled=YES;
    [self changeDesc:0];
    
}
-(void)changeDesc:(int)selectID
{
    for (UIView *subView in scrollBG.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
             
        }
    }
    [scrollBG setContentOffset:CGPointMake(0, 0)];
    
    if (selectID == 0) {
        scrollBG.contentSize = CGSizeMake(887*3, 622);
        pageCol.numberOfPages=3;
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*887, 0, 887, 622)];
             
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"FTD_ProfessionalTrain_NPA%d.png", i]];
            [scrollBG addSubview:imageView];
        }
    }
    else if (selectID == 1)
    {
        scrollBG.contentSize = CGSizeMake(887*2, 622);
        pageCol.numberOfPages=2;
        for (int i = 0; i < 2; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*887, 0, 887, 622)];
            
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"FTD_ProfessionalTrain_NPC%d.png", i]];
            [scrollBG addSubview:imageView];
        }
    }
    else{
        scrollBG.contentSize = CGSizeMake(887*3, 622);
        pageCol.numberOfPages=3;
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*887, 0, 887, 622)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"FTD_ProfessionalTrain_NPL%d.png", i]];
            [scrollBG addSubview:imageView];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageCol.currentPage = page;
    
}
-(void)dealloc{
    NSLog(@"专业培训释放");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
