//
//  FTDShareView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/11.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FTDShareViewDeledate <NSObject>

- (void)cancelview;
-(void)shareQQ;
-(void)shareWeChat;

-(void)sendtextEmail:(NSString *)textEmail;
@end
@interface FTDShareView : UIView
@property(nonatomic, weak)id<FTDShareViewDeledate> delegate;
@property (strong, nonatomic) IBOutlet UIView *viewBG;
+(FTDShareView *)initCustomview;
- (IBAction)shareQQclick:(id)sender;
- (IBAction)shareWeChatclick:(id)sender;
- (IBAction)cancelclick:(id)sender;
- (IBAction)sendclick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;

@end
