//
//  FTDGoodAgentHomeController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/10.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDGoodAgentHomeController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnCompany;
@property (strong, nonatomic) IBOutlet UIButton *btnFreedom;
@property (strong, nonatomic) IBOutlet UIButton *btnCareer;
- (IBAction)backclick:(id)sender;

@end
