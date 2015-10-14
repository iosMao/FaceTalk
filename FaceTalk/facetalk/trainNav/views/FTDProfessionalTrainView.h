//
//  FTDProfessionalTrainView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/12.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDProfessionalTrainView : UIView<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIPageControl *pageCol;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentCol;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollBG;
- (IBAction)selectClick:(id)sender;
+(FTDProfessionalTrainView *)initCustomview;
@end
