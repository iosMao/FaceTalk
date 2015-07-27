//
//  FTDHomAlertFinishView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FTDHomeAlertFinishViewDeledate <NSObject>

- (void)homeAlertFinishCancelClick;
-(void)gotoCreatMenu;
-(void)gotoMenu;
@end
@interface FTDHomAlertFinishView : UIView
@property(nonatomic, weak)id<FTDHomeAlertFinishViewDeledate> delegate;
@property (strong, nonatomic) IBOutlet UIView *viewBG;
+(FTDHomAlertFinishView *)initCustomview;
- (IBAction)gotoCreatMenuclick:(id)sender;
- (IBAction)gotoMenuclick:(id)sender;
- (IBAction)cancelclick:(id)sender;
@end
