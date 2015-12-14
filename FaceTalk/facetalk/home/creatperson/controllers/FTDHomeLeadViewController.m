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
#import "FTJsonManager.h"
@interface FTDHomeLeadViewController ()<FTDHomeAlertViewDeledate,FTDHomeAlertFinishViewDeledate,FTDbackgroundView>
{
    int imgIndex;
    FTDHomeAlertView *homeAlertView;
    FTDHomAlertFinishView *homeAlertFinishView;
    FTDbackgroundView *backgroundView;
    NSArray *arrayImage;
   }
@property(nonatomic,strong) NSTimer *loadTimer;

@end

@implementation FTDHomeLeadViewController
@synthesize imgLeadH,loadTimer,imgBig,imgSmall1,imgSmall2,imgSmall3,imgSmall4;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgIndex = 0;
    imgSmall1.contentMode = UIViewContentModeScaleAspectFill;
    imgSmall2.contentMode = UIViewContentModeScaleAspectFill;
    imgSmall3.contentMode = UIViewContentModeScaleAspectFill;
    imgSmall4.contentMode = UIViewContentModeScaleAspectFill;
    [imgSmall1.layer setMasksToBounds:YES];
    [imgSmall2.layer setMasksToBounds:YES];
    [imgSmall3.layer setMasksToBounds:YES];
    [imgSmall4.layer setMasksToBounds:YES];
    
    backgroundView = [[FTDbackgroundView alloc]initWithFrame:self.view.frame];
    backgroundView.delegate = self;
    
    
    
    
    homeAlertFinishView = [FTDHomAlertFinishView initCustomview];
    homeAlertFinishView.delegate = self;
    homeAlertFinishView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
    
    [self getImgData];
    
   //self.viewDate.frame=CGRectMake(0, 768, 1024, 216);
    
    
//    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadimg) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}






-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",self.navigationController);
    TFDNavViewController *nav = (TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden = NO;
    nav.btnRightMenu.hidden = YES;
    loadTimer = [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(loadimg) userInfo:nil repeats:YES];
    [loadTimer fire];
}







-(void)viewWillDisappear:(BOOL)animated
{
//    [homeAlertView.textSex removeObserver:homeAlertView forKeyPath:@"text" context:nil];
//    [homeAlertView.textBirthday removeObserver:homeAlertView forKeyPath:@"text" context:nil];
    [loadTimer invalidate];
}
-(void)getImgData
{
   arrayImage = [[NSArray alloc]initWithArray:[FTJsonManager shareManager].guide_page];
    
    imgSmall1.image = [UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:0]];
    imgSmall2.image = [UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:1]];
    imgSmall3.image = [UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:2]];
    imgSmall4.image = [UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:3]];
}





-(void)loadimg
{
    
    if (imgIndex > 3) {
        imgIndex = 0;
    }
 
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        imgLeadH.frame = CGRectMake(305+(imgIndex*121), 581, 123, 105);
        
    } completion:^(BOOL finished) {
        imgBig.image = [UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:imgIndex]];
        imgIndex = imgIndex+1;
    }];
}
-(void)downkeyboard{
    [homeAlertView.textName resignFirstResponder];
    [homeAlertView.textSex resignFirstResponder];
    [homeAlertView.textBirthday resignFirstResponder];
    homeAlertView.tableName.hidden = YES;
}

-(void)homeAlertCancelClick
{
    CGAffineTransform transform = homeAlertView.transform;
    //homeAlertView.transform = CGAffineTransformScale(transform, 1.0, 1.0);
    
    [UIView animateWithDuration:0.4 animations:^{
        homeAlertView.transform = CGAffineTransformScale(transform,0.01,0.01);
    }
     completion:^(BOOL finished){
         [backgroundView removeFromSuperview];
        [homeAlertView removeFromSuperview];
         homeAlertView = nil;
         homeAlertView.transform = CGAffineTransformScale(transform,1,1);
     }];
    
    
//    [UIView animateWithDuration:0.4 animations:^{
//        
//        
//        
//
//    }];
    }
-(void)homeAlertCreatclick
{
    [homeAlertView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"FTD_isFinishMark"];//排序结果置位
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TFWSelectOrderUserDefault"]!=nil) {
        [self gotoMenu];
        [backgroundView removeFromSuperview];
    }
    else{
        [self.view addSubview: homeAlertFinishView];
    }
}
-(void)homeAlertFinishCancelClick
{
    CGAffineTransform transform = homeAlertFinishView.transform;
    [UIView animateWithDuration:0.4 animations:^{
        homeAlertFinishView.transform = CGAffineTransformScale(transform,0.01,0.01);
    }
                     completion:^(BOOL finished){
                         [backgroundView removeFromSuperview];
                         [homeAlertFinishView removeFromSuperview];
                         homeAlertFinishView.transform = CGAffineTransformScale(transform,1,1);
                     }];
    
}
//-(void)showDatePicker
//{
//    [UIView animateWithDuration:0.4 animations:^{
//        
//        [self.view addSubview:self.viewDate];
//        
//        self.viewDate.frame=CGRectMake(0, 768-216, 1024, 216);
//    }
//                     completion:^(BOOL finished){
//                         
//                     }];
//}



-(void)gotoCreatMenu
{
    TFWCustomTalkViewController *TFWCustomTalkViewCol = [[TFWCustomTalkViewController alloc]init];
    TFWCustomTalkViewCol.strType = @"first";
    [self.navigationController pushViewController:TFWCustomTalkViewCol animated:YES];
}
-(void)gotoMenu
{
    TFWStartTalkViewController *TFWStartTalkViewCol = [[TFWStartTalkViewController alloc]init];
    [self.navigationController pushViewController:TFWStartTalkViewCol animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)nextbtnclick:(id)sender {
    [self.view addSubview:backgroundView];
    homeAlertView = [FTDHomeAlertView initCustomview];
    homeAlertView.delegate = self;
    homeAlertView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
    [self.view addSubview:homeAlertView];
    CGAffineTransform transform = homeAlertView.transform;
    homeAlertView.transform = CGAffineTransformScale(transform, 0.2, 0.2);
    [UIView animateWithDuration:0.4 animations:^{
        homeAlertView.transform = CGAffineTransformScale(transform, 1.0, 1.0);
        homeAlertView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
    }];
//
}
- (IBAction)image1click:(id)sender {
    imgIndex = 0;
    if (imgIndex > 3) {
        imgIndex = 0;
    }
    
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        imgLeadH.frame = CGRectMake(305+(imgIndex*121), 581, 123, 105);
        
    } completion:^(BOOL finished) {
        imgBig.image = [UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:0]];
    }];
}

- (IBAction)image2click:(id)sender {
    imgIndex=1;
    if (imgIndex>3) {
        imgIndex=0;
    }
    
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        imgLeadH.frame=CGRectMake(305+(imgIndex*121), 581, 123, 105);
        
    } completion:^(BOOL finished) {
        imgBig.image=[UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:1]];
    }];
}

- (IBAction)image3click:(id)sender {
    imgIndex=2;
    if (imgIndex>3) {
        imgIndex=0;
    }
    
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        imgLeadH.frame=CGRectMake(305+(imgIndex*121), 581, 123, 105);
        
    } completion:^(BOOL finished) {
        imgBig.image=[UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:2]];
        
    }];
}

- (IBAction)image4click:(id)sender {
    imgIndex=3;
    if (imgIndex>3) {
        imgIndex=0;
    }
    
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        imgLeadH.frame=CGRectMake(305+(imgIndex*121), 581, 123, 105);
        
    } completion:^(BOOL finished) {
        imgBig.image=[UIImage imageWithContentsOfFile:[arrayImage objectAtIndex:3]];
        
    }];
}

- (IBAction)backclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
