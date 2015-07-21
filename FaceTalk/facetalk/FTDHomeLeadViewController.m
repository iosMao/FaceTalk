//
//  FTDHomeLeadViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/16.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeLeadViewController.h"
#import "FTDGoodAgentHomeController.h"
@interface FTDHomeLeadViewController ()
{
    int imgIndex;
}
@end

@implementation FTDHomeLeadViewController
@synthesize imgLeadH;
- (void)viewDidLoad {
    [super viewDidLoad];
    imgIndex=0;
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadimglead) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadimglead
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

- (IBAction)nextbtnclick:(id)sender {
    FTDGoodAgentHomeController *FTDHomeLeadViewCol=[[FTDGoodAgentHomeController alloc]init];
    CATransition *  tran=[CATransition animation];
    tran.type = @"pageCurl";
    tran.subtype = kCATransitionFromRight;
    tran.duration=1;
    tran.delegate=self;
    [self.view.superview.layer addAnimation:tran forKey:@"kongyu"];
    [self.navigationController pushViewController:FTDHomeLeadViewCol animated:YES];
}
@end
