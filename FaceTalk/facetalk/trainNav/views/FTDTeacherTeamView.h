//
//  FTDTeacherTeamView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/12.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDTeacherTeamView : UIView<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollBG;
@property (strong, nonatomic) IBOutlet UIPageControl *pageCol;
+(FTDTeacherTeamView *)initCustomview;
@end
