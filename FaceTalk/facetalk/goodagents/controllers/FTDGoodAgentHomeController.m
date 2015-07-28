//
//  FTDGoodAgentHomeController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/10.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDGoodAgentHomeController.h"
#import "FTDGoodAgentKindsController.h"
@interface FTDGoodAgentHomeController ()

@end

@implementation FTDGoodAgentHomeController
@synthesize btnCareer,btnCompany,btnFreedom,imgBG,imgCamera,imgCup,imgGlass,imgKey,imgPen,imgPenBox;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatAnimation];
    
    
    // Do any additional setup after loading the view from its nib.
}
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
    CGAffineTransform transformbtnCompany = btnCompany.transform;
    transformbtnCompany = CGAffineTransformScale(transformbtnCompany, 2,2);
    btnCompany.transform = transformbtnCompany;
    
    CGAffineTransform transformbtnFreedom = btnFreedom.transform;
    transformbtnFreedom = CGAffineTransformScale(transformbtnFreedom, 2,2);
    btnFreedom.transform = transformbtnFreedom;
    
    CGAffineTransform transformbtnCareer = btnCareer.transform;
    transformbtnCareer = CGAffineTransformScale(transformbtnCareer, 2,2);
    btnCareer.transform = transformbtnCareer;
    
    [UIView animateKeyframesWithDuration:1 delay:1 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        imgCup.alpha=1;
        imgGlass.alpha=1;
        
        imgPen.alpha=1;
        
        
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            imgCamera.alpha=1;
            imgKey.alpha=1;
            
        } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                imgPenBox.alpha=1;
                
            } completion:^(BOOL finished) {
                [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                    btnCompany.alpha=1;
                    CGAffineTransform transform = btnCompany.transform;
                    transform = CGAffineTransformScale(transform, 0.5,0.5);
                    btnCompany.transform = transform;
                    
                    btnCareer.alpha=1;
                    CGAffineTransform transform1 = btnCareer.transform;
                    transform1 = CGAffineTransformScale(transform1, 0.5,0.5);
                    btnCareer.transform = transform1;
                    
                    btnFreedom.alpha=1;
                    CGAffineTransform transform2 = btnFreedom.transform;
                    transform2 = CGAffineTransformScale(transform2, 0.5,0.5);
                    btnFreedom.transform = transform2;
                    
                } completion:^(BOOL finished) {
                    
                }];
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

- (IBAction)backclick:(id)sender {
    
//    CATransition *  tran=[CATransition animation];
//    tran.type = @"pageCurl";
//    tran.subtype = kCATransitionFromLeft;
//    tran.duration=1;
//    tran.delegate=self;
//    [self.view.superview.layer addAnimation:tran forKey:@"kongyu"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)companyclick:(id)sender {
    FTDGoodAgentKindsController *FTDGoodAgentKindsCol=[[FTDGoodAgentKindsController alloc]init];
//    CATransition *  tran=[CATransition animation];
//    tran.type = @"pageCurl";
//    tran.subtype = kCATransitionFromRight;
//    tran.duration=1;
//    tran.delegate=self;
//    [self.view.superview.layer addAnimation:tran forKey:@"mao"];
    [self.navigationController pushViewController:FTDGoodAgentKindsCol animated:YES];
}

- (IBAction)freedomclick:(id)sender {
}

- (IBAction)careerclick:(id)sender {
}
@end
