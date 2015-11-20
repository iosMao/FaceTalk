//
//  FTDTimeTableView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/30.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDTimeTableView : UIView
@property (strong, nonatomic) IBOutlet UIButton *hah;
+(FTDTimeTableView *)initCustomview;
@property (nonatomic,strong) NSMutableArray *pointArray;
@end
