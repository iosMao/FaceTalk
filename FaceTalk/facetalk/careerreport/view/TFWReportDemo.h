//
//  TFWReportDemo.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/26.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFullView.h"
#import "WaterFullCell.h"

@interface TFWReportDemo : UIView<WaterFullViewDataSource>
@property (nonatomic,assign) BOOL isEndEdit;
@property (nonatomic,strong) WaterFullView *waterFull;
+(id)createReportDemo;
-(void)reloadData;
@end
