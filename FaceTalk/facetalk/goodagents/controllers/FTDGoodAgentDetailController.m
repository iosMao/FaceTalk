//
//  FTDGoodAgentDetailController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/28.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDGoodAgentDetailController.h"

@interface FTDGoodAgentDetailController ()

@end

@implementation FTDGoodAgentDetailController

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

- (IBAction)backclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
