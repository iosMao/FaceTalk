//
//  FTDAIADetailScrollView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/28.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDAIADetailScrollView : UIView<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollBG;
@property (strong, nonatomic) IBOutlet UIPageControl *pageCol;
@property (strong, nonatomic)NSMutableArray *arrayImage;
+(FTDAIADetailScrollView *)initCustomview;
-(void)creatImageScroll:(NSArray *)array;
@end
