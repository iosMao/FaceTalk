//
//  FTDHomeViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/9.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeViewController.h"
#import "FTDMenuViewController.h"
#import "FTDHomeLeadViewController.h"

@interface FTDHomeViewController ()

@end

@implementation FTDHomeViewController
@synthesize btnKey,scrollBG;
- (void)viewDidLoad {
    [super viewDidLoad];
    scrollBG.contentSize=CGSizeMake(1024*3, 748);
    scrollBG.pagingEnabled=YES;
     [btnKey  addTarget:self action:@selector(homeLeadViewclick) forControlEvents:UIControlEventTouchUpInside];
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

-(void)homeLeadViewclick
{
 
    FTDHomeLeadViewController *FTDHomeLeadViewCol=[[FTDHomeLeadViewController alloc]init];
    CATransition *  tran=[CATransition animation];
    tran.type =kCATransitionFade;
     tran.subtype = kCATransitionFromRight;
    tran.duration=1;
    tran.delegate=self;
    [self.view.superview.layer addAnimation:tran forKey:@"kongyu"];
    [self.navigationController pushViewController:FTDHomeLeadViewCol animated:YES];
}
@end
