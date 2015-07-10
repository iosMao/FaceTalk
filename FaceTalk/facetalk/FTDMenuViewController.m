//
//  FTDMenuViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/10.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDMenuViewController.h"
#import "FTDGoodAgentHomeController.h"
#import "FTDPersonalHomeController.h"
@interface FTDMenuViewController ()

@end

@implementation FTDMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)workelementclick:(id)sender {
}

- (IBAction)goodagentclick:(id)sender {
    FTDGoodAgentHomeController *FTDGoodAgentHomeCol=[[FTDGoodAgentHomeController alloc]init];
    [self.navigationController pushViewController:FTDGoodAgentHomeCol animated:YES];
}

- (IBAction)aiaelementclick:(id)sender {
}

- (IBAction)personalteamclick:(id)sender {
}
@end
