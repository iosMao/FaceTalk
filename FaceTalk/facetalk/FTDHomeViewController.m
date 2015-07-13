//
//  FTDHomeViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/9.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeViewController.h"
#import "FTDMenuViewController.h"
@interface FTDHomeViewController ()

@end

@implementation FTDHomeViewController

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

- (IBAction)menuclick:(id)sender {
    FTDMenuViewController *FTDMenuViewCol=[[FTDMenuViewController alloc]init];
    [self.navigationController pushViewController:FTDMenuViewCol animated:YES];
}
@end
