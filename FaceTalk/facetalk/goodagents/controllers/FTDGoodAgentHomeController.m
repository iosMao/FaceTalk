//
//  FTDGoodAgentHomeController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/10.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDGoodAgentHomeController.h"

@interface FTDGoodAgentHomeController ()

@end

@implementation FTDGoodAgentHomeController
@synthesize btnCareer,btnCompany,btnFreedom;
- (void)viewDidLoad {
    [super viewDidLoad];
    btnFreedom.alpha=0;
    btnCareer.alpha=0;
    btnCompany.alpha=0;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    
    
    [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        btnCompany.alpha=1;
//        CGAffineTransform transform = btnCompany.transform;
//        
//        transform = CGAffineTransformScale(transform, 2,2);//前面的2表示横向放大2倍，后边的0.5表示纵向缩小一半
//        
//        btnCompany.transform = transform;
        
    } completion:^(BOOL finished) {
        
        
        [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            btnFreedom.alpha=1;
            
        } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                btnCareer.alpha=1;
                
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

- (IBAction)backclick:(id)sender {
    
    CATransition *  tran=[CATransition animation];
    tran.type = @"pageCurl";
    tran.subtype = kCATransitionFromLeft;
    tran.duration=1;
    tran.delegate=self;
    [self.view.superview.layer addAnimation:tran forKey:@"kongyu"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
