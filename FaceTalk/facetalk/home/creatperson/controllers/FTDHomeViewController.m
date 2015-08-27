//
//  FTDHomeViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/9.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeViewController.h"
#import "FTDHomeLeadViewController.h"
#import "UIView+MaterialDesign.h"
#import "TFDNavViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "FTDDataPacketManager.h"
#import "FTJsonManager.h"
@interface FTDHomeViewController ()

@end

@implementation FTDHomeViewController
@synthesize btnKey,scrollBG;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getlocalResourse];
    NSLog(@"%@",self.navigationController);
    TFDNavViewController *nav=(TFDNavViewController *) self.navigationController;
    nav.btnSlider.hidden=YES;
    nav.btnRightMenu.hidden=YES;
    
    scrollBG.contentSize=CGSizeMake(1024, 748);
    scrollBG.pagingEnabled=YES;
    scrollBG.scrollEnabled=NO;
    [btnKey addTarget:self action:@selector(homeLeadViewclick:event:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getlocalResourse) name:@"FTDUNZIPSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backIMOclick:) name:@"FTDREQUESTFAILED" object:nil];
    [self getLoginUserInfo];
    
 
}
-(void)getLoginUserInfo//由QUIX协助调用获取登录信息接口  说明下“TblProfile”模型的结构
{
    
}

-(void)getlocalResourse
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dstResourcePath = [[FTDDataPacketManager sharedInstance]unzipDestinationPath];
    dstResourcePath =[dstResourcePath stringByAppendingPathComponent:@"uploads"];
    dstResourcePath =[dstResourcePath stringByAppendingPathComponent:@"data.json"];
    if ([fileManager fileExistsAtPath:dstResourcePath]) {
        [self getbackgroundImg];
        
    }
    else{
         
        [[FTDDataPacketManager sharedInstance]downloadFile];
    }
}


-(void)getbackgroundImg
{
    NSString *strImg=[FTJsonManager shareManager].index_background;
    UIImageView *scrollImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,20, 1024,748)];
     scrollImage.image=[UIImage imageWithContentsOfFile:strImg] ;
     //scrollImage.image=[UIImage imageNamed:@"FTD_home_aiaoffice.png"];
    [scrollBG addSubview:scrollImage];
}


-(void)viewDidAppear:(BOOL)animated
{
     //[SVProgressHUD showProgress:0.5 status:@"已下载50%" maskType:SVProgressHUDMaskTypeBlack];
}
-(void)viewDidDisappear:(BOOL)animated
{
    btnKey.alpha=1;
    btnKey.frame=CGRectMake(700, 350, 260, 180);
    
}



-(void)homeLeadViewclick:(UIButton *)sender event:(UIEvent *)event
{
    
    __weak FTDHomeViewController *weak=self;
    FTDHomeLeadViewController *FTDHomeLeadViewCol=[[FTDHomeLeadViewController alloc]init];
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        btnKey.center=CGPointMake(512, 440);
        btnKey.alpha=0;
    } completion:^(BOOL finished) {
        
        CGPoint exactTouchPosition = CGPointMake(512, 440);
        
        
        [UIView mdInflateTransitionFromView:weak.view toView:FTDHomeLeadViewCol.view originalPoint:exactTouchPosition duration:1.5 completion:^{
            NSLog(@"completed!");
            [weak.navigationController pushViewController:FTDHomeLeadViewCol animated:YES];
            
        }];
    }];
    
    
    
    
//    CATransition *  tran=[CATransition animation];
//    tran.type =kCATransitionFade;
//     tran.subtype = kCATransitionFromRight;
//    tran.duration=1;
//    tran.delegate=self;
//    [self.view.superview.layer addAnimation:tran forKey:@"kongyu"];
    
}
- (IBAction)backIMOclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
