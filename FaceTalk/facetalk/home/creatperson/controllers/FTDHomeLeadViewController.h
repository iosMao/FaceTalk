//
//  FTDHomeLeadViewController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/16.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFDNavViewController.h"
@interface FTDHomeLeadViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imgLeadH;
- (IBAction)nextbtnclick:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgSmall1;
@property (strong, nonatomic) IBOutlet UIImageView *imgSmall2;
@property (strong, nonatomic) IBOutlet UIImageView *imgSmall3;
@property (strong, nonatomic) IBOutlet UIImageView *imgSmall4;
@property (strong, nonatomic) IBOutlet UIImageView *imgBig;
@property (strong, nonatomic) IBOutlet UIView *viewDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)image1click:(id)sender;
- (IBAction)image2click:(id)sender;
- (IBAction)image3click:(id)sender;
- (IBAction)image4click:(id)sender;

@end
