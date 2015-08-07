//
//  FTDHomeViewController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/9.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFDNavViewController.h"
@interface FTDHomeViewController : UIViewController
@property(nonatomic,strong)UIButton *btn;
@property (strong, nonatomic) IBOutlet UIButton *btnKey;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollBG;
- (IBAction)backIMOclick:(id)sender;

@end
