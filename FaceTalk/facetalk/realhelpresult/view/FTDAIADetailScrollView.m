//
//  FTDAIADetailScrollView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/28.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDAIADetailScrollView.h"
#import "FTDDataPacketManager.h"
@implementation FTDAIADetailScrollView
@synthesize scrollBG;
+(FTDAIADetailScrollView *)initCustomview
{
    NSArray* nibView = [[NSBundle mainBundle] loadNibNamed:@"FTDAIADetailScrollView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}
-(void)awakeFromNib
{
    
    //scrollBG.contentSize = CGSizeMake(887*4, 622);
    scrollBG.pagingEnabled = YES;
//    for (int i = 0; i < 4; i++) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(887*i, 0, 887, 622)];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"FTD_TeacherTeam%d.png", i]];
//        [scrollBG addSubview:imageView];
//    }
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageCol.currentPage = page;
    
}
-(void)creatImageScroll:(NSArray *)array
{
    for (UIView *subView in scrollBG.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
            
        }
    }
    [scrollBG setContentOffset:CGPointMake(0, 0)];
    int totalNum = array.count;
    if (totalNum > 0) {
        if (totalNum == 1) {
            _pageCol.hidden = YES;
        }
        else{
            _pageCol.hidden = NO;
            _pageCol.numberOfPages = totalNum;
        }
        
        
        scrollBG.contentSize = CGSizeMake(887*totalNum, 622);
        for (int i = 0; i < totalNum; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(887*i, 0, 887, 622)];
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            NSString *docDir = [paths objectAtIndex:0];
            //imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[self basePath],[array objectAtIndex:i]]];
            imageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",[self basePath],[array objectAtIndex:i]]];
            [scrollBG addSubview:imageView];
        }
    }
    
    
}


-(NSString *)basePath
{
    NSString *file1=[[FTDDataPacketManager sharedInstance]basePath];
    return file1;
}
@end
