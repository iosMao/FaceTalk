//
//  FTDRevenueTrialViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/18.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDRevenueTrialViewController.h"
#import "FTDRevenueTrialDetailViewController.h"

#import "FTDCustomCalculationViewController.h"
@interface FTDRevenueTrialViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgBG;
- (IBAction)backAction:(id)sender;
- (IBAction)btn1Action:(id)sender;
- (IBAction)btn2Action:(id)sender;
- (IBAction)btn3Action:(id)sender;
- (IBAction)customAction:(id)sender;

@end

@implementation FTDRevenueTrialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.imgBG.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ftd_customrevenuehome" ofType:@"png"]];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn1Action:(id)sender {
    [self gotoDetailCol:0];
}

- (IBAction)btn2Action:(id)sender {
    [self gotoDetailCol:1];
}

- (IBAction)btn3Action:(id)sender {
    [self gotoDetailCol:2];
}

- (IBAction)customAction:(id)sender {
    FTDCustomCalculationViewController *vc = [[FTDCustomCalculationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoDetailCol:(int)index
{
    FTDRevenueTrialDetailViewController *vc = [[FTDRevenueTrialDetailViewController alloc]init];
    vc.indexID = index;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
