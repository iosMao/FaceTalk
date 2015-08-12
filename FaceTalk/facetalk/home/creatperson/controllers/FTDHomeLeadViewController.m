//
//  FTDHomeLeadViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/16.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeLeadViewController.h"
#import "FTDGoodAgentHomeController.h"
#import "FTDHomeAlertView.h"
#import "FTDbackgroundView.h"
#import "FTDHomAlertFinishView.h"
#import "TFWCustomTalkViewController.h"
#import "TFWStartTalkViewController.h"
#import "TFDNavViewController.h"
@interface FTDHomeLeadViewController ()<FTDHomeAlertViewDeledate,FTDHomeAlertFinishViewDeledate>
{
    int imgIndex;
    FTDHomeAlertView *homeAlertView;
    FTDHomAlertFinishView *homeAlertFinishView;
    FTDbackgroundView *backgroundView;
    
   }
@property(nonatomic,strong) NSTimer *loadTimer;

@end

@implementation FTDHomeLeadViewController
@synthesize imgLeadH,loadTimer;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.navigationController);
    TFDNavViewController *nav=(TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden=NO;
    nav.btnRightMenu.hidden=YES;
    imgIndex=0;
    
    backgroundView= [[FTDbackgroundView alloc]initWithFrame:self.view.frame];
    
    homeAlertView= [FTDHomeAlertView initCustomview];
    homeAlertView.delegate= self;
    homeAlertView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
    
    homeAlertFinishView= [FTDHomAlertFinishView initCustomview];
    homeAlertFinishView.delegate= self;
    homeAlertFinishView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
    
    
//    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadimg) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    loadTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadimg) userInfo:nil repeats:YES];
    [loadTimer fire];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [loadTimer invalidate];
}
-(void)loadimg
{
    imgIndex=imgIndex+1;
    if (imgIndex>3) {
        imgIndex=0;
    }
 
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        imgLeadH.frame=CGRectMake(305+(imgIndex*121), 581, 123, 105);
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)homeAlertCancelClick
{
    [backgroundView removeFromSuperview];
    [homeAlertView removeFromSuperview];
}
-(void)homeAlertCreatclick
{
    [homeAlertView removeFromSuperview];
    [self.view addSubview: homeAlertFinishView];
    
}
-(void)homeAlertFinishCancelClick
{
    [backgroundView removeFromSuperview];
    [homeAlertFinishView removeFromSuperview];
}

-(void)gotoCreatMenu
{
    TFWCustomTalkViewController *TFWCustomTalkViewCol=[[TFWCustomTalkViewController alloc]init];
//    CATransition *  tran=[CATransition animation];
//    tran.type = @"pageCurl";
//    tran.subtype = kCATransitionFromRight;
//    tran.duration=1;
//    tran.delegate=self;
//    [self.view.superview.layer addAnimation:tran forKey:@"mao"];
    [self.navigationController pushViewController:TFWCustomTalkViewCol animated:YES];
}
-(void)gotoMenu
{
    TFWStartTalkViewController *TFWStartTalkViewCol=[[TFWStartTalkViewController alloc]init];
    [self.navigationController pushViewController:TFWStartTalkViewCol animated:YES];
    //FTDGoodAgentHomeController *FTDHomeLeadViewCol=[[FTDGoodAgentHomeController alloc]init];
//        CATransition *  tran=[CATransition animation];
//        tran.type = @"pageCurl";
//        tran.subtype = kCATransitionFromRight;
//        tran.duration=1;
//        tran.delegate=self;
//        [self.view.superview.layer addAnimation:tran forKey:@"mao"];
        //[self.navigationController pushViewController:FTDHomeLeadViewCol animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)nextbtnclick:(id)sender {
    [self.view addSubview:backgroundView];
    [self.view addSubview:homeAlertView];
    
    
    
//
}
@end
