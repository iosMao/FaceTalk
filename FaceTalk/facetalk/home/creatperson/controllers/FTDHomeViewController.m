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
@interface FTDHomeViewController ()

@end

@implementation FTDHomeViewController
@synthesize btnKey,scrollBG;
- (void)viewDidLoad {
    [super viewDidLoad];
    scrollBG.contentSize=CGSizeMake(1024*3, 748);
    scrollBG.pagingEnabled=YES;
     [btnKey  addTarget:self action:@selector(homeLeadViewclick:event:) forControlEvents:UIControlEventTouchUpInside];
//    [btnKey addTarget:self action:@selector(dragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
//     UIControlEventTouchUpOutside];
    // Do any additional setup after loading the view from its nib.
}
//- (void) dragMoving: (UIControl *) c withEvent:ev
//{
//    
//    CGPoint point=[[[ev allTouches] anyObject] locationInView:self.view];
//    point.y=440;
//    c.center =point;
//    
//    if (point.x<520) {
//        [self gotoHomeinterView];
//    }
//    
//}
//- (void) dragEnded: (UIControl *) c withEvent:ev
//{
//    CGPoint point=[[[ev allTouches] anyObject] locationInView:self.view];
//     point.y=440;
//    c.center =point;
//    
//}
-(void)viewDidDisappear:(BOOL)animated
{
    btnKey.alpha=1;
    btnKey.frame=CGRectMake(700, 350, 260, 180);
    
}



-(void)homeLeadViewclick:(UIButton *)sender event:(UIEvent *)event
{
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        btnKey.center=CGPointMake(512, 440);
        btnKey.alpha=0;
    } completion:^(BOOL finished) {
        
        CGPoint exactTouchPosition = CGPointMake(512, 440);
        FTDHomeLeadViewController *FTDHomeLeadViewCol=[[FTDHomeLeadViewController alloc]init];
        
        [UIView mdInflateTransitionFromView:self.view toView:FTDHomeLeadViewCol.view originalPoint:exactTouchPosition duration:1.5 completion:^{
            NSLog(@"completed!");
            [self.navigationController pushViewController:FTDHomeLeadViewCol animated:YES];
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
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
