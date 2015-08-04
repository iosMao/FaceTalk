//
//  FTDAgentDetailScoreView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/29.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDAgentDetailScoreView : UIView
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgBtnWhite;
@property (strong, nonatomic) IBOutlet UIImageView *imgBtnRed;
@property (strong, nonatomic) IBOutlet UIImageView *imgGrayTriangle;
@property (strong, nonatomic) IBOutlet UIImageView *imgRedTriangle;
@property (strong, nonatomic) IBOutlet UILabel *lblGrayScore;
@property (strong, nonatomic) IBOutlet UILabel *lblRedScore;
@property (strong, nonatomic) IBOutlet UITextView *textDesc;


+(FTDAgentDetailScoreView *)setCustomview;
-(void)setTitle:(NSString *)title andOldScore:(int)oldscore andNewScore:(int)newscore andDesc:(NSString *)desc;
@end
