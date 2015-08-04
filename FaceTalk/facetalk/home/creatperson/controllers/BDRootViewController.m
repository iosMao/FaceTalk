//
//  ViewController.m
//  FaceTalk
//
//  Created by wen on 15/7/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "BDRootViewController.h"
#import "FTDHomeViewController.h"
#import "TFDNavViewController.h"
@interface BDRootViewController ()

@end

@implementation BDRootViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ftdhomeviewclick:(id)sender {
    
    FTDHomeViewController *FTDHomeViewCol=[[FTDHomeViewController alloc]init];
    TFDNavViewController *navFTDHomeViewCol=[[TFDNavViewController alloc]initWithRootViewController:FTDHomeViewCol];
    navFTDHomeViewCol.navigationBar.hidden=YES;
    [self presentViewController:navFTDHomeViewCol animated:YES completion:nil];
    //[self.navigationController pushViewController:navFTDHomeViewCol animated:YES];
}
@end
