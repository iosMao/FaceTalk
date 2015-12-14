//
//  FTDGoodAgentHomeController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/10.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDGoodAgentHomeController.h"
#import "FTDGoodAgentKindsController.h"
#import "TFWRealHelpViewController.h"
#import "FTWDataManager.h"
#import "TFWReportViewController.h"
#import "FTJsonManager.h"
#import "FTDDataProvider.h"
#import "TFDNavViewController.h"
#import <SVProgressHUD.h>
#import "FTDDataPacketManager.h"
#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
@interface FTDGoodAgentHomeController ()

@end

@implementation FTDGoodAgentHomeController
@synthesize btnCareer,btnCompany,btnFreedom,imgBG,imgCamera,imgCup,imgGlass,imgKey,imgPen,imgPenBox;
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self getJsonUrl];
    [self creatAnimation];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getlocalResourse) name:@"FTDUNZIPSUCCESS" object:nil];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    TFDNavViewController *nav=(TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden=NO;
    nav.btnRightMenu.hidden=NO;
    
}


//-(void)checkPicUpdate
//{
//    if ([[FTJsonManager shareManager].lastUpdatePicDate isEqualToString:get_sp(@"DLASTUPDATEPIC")]) {
//        NSLog(@"没更新");
//    }
//    else{
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"检测到图片有更新，是否更新资源包？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//    }
//}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1) {
//        [[FTDDataPacketManager sharedInstance] downloadFile];
//    }
//}
//-(void)getlocalResourse
//{
//    [[FTJsonManager shareManager]initData];
//    NSLog(@"更新好之后的日期：%@",[FTJsonManager shareManager].lastUpdatePicDate);
//     set_sp(@"DLASTUPDATEPIC", [FTJsonManager shareManager].lastUpdatePicDate);
//}
-(void)creatAnimation
{
    btnFreedom.alpha=0;
    btnCareer.alpha=0;
    btnCompany.alpha=0;
    imgCamera.alpha=0;
    imgCup.alpha=0;
    imgGlass.alpha=0;
    imgKey.alpha=0;
    imgPen.alpha=0;
    imgPenBox.alpha=0;
    
    btnCompany.center=CGPointMake(270*3, 394);
    btnFreedom.center=CGPointMake(526*3, 394);
    btnCareer.center=CGPointMake(787*3, 394);
//    CGAffineTransform transformbtnCompany = btnCompany.transform;
//    transformbtnCompany = CGAffineTransformScale(transformbtnCompany, 2,2);
//    btnCompany.transform = transformbtnCompany;
//    
//    CGAffineTransform transformbtnFreedom = btnFreedom.transform;
//    transformbtnFreedom = CGAffineTransformScale(transformbtnFreedom, 2,2);
//    btnFreedom.transform = transformbtnFreedom;
//    
//    CGAffineTransform transformbtnCareer = btnCareer.transform;
//    transformbtnCareer = CGAffineTransformScale(transformbtnCareer, 2,2);
//    btnCareer.transform = transformbtnCareer;
    
    [UIView animateKeyframesWithDuration:0.5 delay:1 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        imgCup.alpha=1;
        imgGlass.alpha=1;
        
        imgPen.alpha=1;
        
        
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            imgCamera.alpha=1;
            imgKey.alpha=1;
            
        } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                imgPenBox.alpha=1;
                btnCompany.alpha=1;
                btnCareer.alpha=1;
                btnFreedom.alpha=1;
                btnCompany.center=CGPointMake(270, 394);
                btnFreedom.center=CGPointMake(787, 394);
                btnCareer.center=CGPointMake(526, 394);
            } completion:^(BOOL finished) {
                
            }];
            
        }];
        
        
        
        
    }];
}
 





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextAction:(id)sender {
    
    TFWOrderModel *orderModel = [[FTWDataManager shareManager] selectOrder];
    NSInteger index = 0;
    NSLog(@"%ld",(long)[FTWDataManager shareManager].currentIndex);
    switch ([FTWDataManager shareManager].currentIndex++ + 1) {
        case 0:
            index = orderModel.first;
            break;
        case 1:
            index = orderModel.second;
            break;
        case 2:
            index = orderModel.third;
            break;
        case 3:
            index = orderModel.fourth;
            break;
            
        default:
            index = -1;
            break;
    }
    id vc = nil;
    if (index == -1) {
        if ( [[[NSUserDefaults standardUserDefaults]objectForKey:@"FTD_isFinishMark"]isEqualToString:@"0"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请完成“真选择成就事业”的评分！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        vc = [[TFWReportViewController alloc] init];
    }else
    {
        vc = [[NSClassFromString([[FTWDataManager shareManager].classArray objectAtIndex:index - 1]) alloc] init];
    }
    
//    TFWRealHelpViewController *vc=[[TFWRealHelpViewController alloc]init];
    [self.navigationController setViewControllers:@[vc] animated:YES];
    //[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)backclick:(id)sender {
    
//    CATransition *  tran=[CATransition animation];
//    tran.type = @"pageCurl";
//    tran.subtype = kCATransitionFromLeft;
//    tran.duration=1;
//    tran.delegate=self;
//    [self.view.superview.layer addAnimation:tran forKey:@"kongyu"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)companyclick:(id)sender {//企业单位
    FTDGoodAgentKindsController *FTDGoodAgentKindsCol=[[FTDGoodAgentKindsController alloc]init];
    FTDGoodAgentKindsCol.index=0;
    [self.navigationController pushViewController:FTDGoodAgentKindsCol animated:YES];
}

- (IBAction)freedomclick:(id)sender {//自由职业
    FTDGoodAgentKindsController *FTDGoodAgentKindsCol=[[FTDGoodAgentKindsController alloc]init];
    FTDGoodAgentKindsCol.index=2;
    [self.navigationController pushViewController:FTDGoodAgentKindsCol animated:YES];
}

- (IBAction)careerclick:(id)sender {//事业单位
    FTDGoodAgentKindsController *FTDGoodAgentKindsCol=[[FTDGoodAgentKindsController alloc]init];
    FTDGoodAgentKindsCol.index=1;
    [self.navigationController pushViewController:FTDGoodAgentKindsCol animated:YES];
}

-(void)dealloc{
    NSLog(@"优秀营销员释放");
}


@end
