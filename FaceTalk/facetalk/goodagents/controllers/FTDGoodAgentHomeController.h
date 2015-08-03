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
@property (strong, nonatomic) IBOutlet UIImageView *imgBG;
@property (strong, nonatomic) IBOutlet UIImageView *imgCup;
@property (strong, nonatomic) IBOutlet UIImageView *imgPen;
@property (strong, nonatomic) IBOutlet UIImageView *imgKey;
@property (strong, nonatomic) IBOutlet UIImageView *imgPenBox;

@property (strong, nonatomic) IBOutlet UIImageView *imgCamera;
@property (strong, nonatomic) IBOutlet UIImageView *imgGlass;

- (IBAction)nextAction:(id)sender;

- (IBAction)backclick:(id)sender;
- (IBAction)companyclick:(id)sender;
- (IBAction)freedomclick:(id)sender;
- (IBAction)careerclick:(id)sender;
@end
