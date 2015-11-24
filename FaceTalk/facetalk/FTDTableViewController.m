//
//  FTDTableViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/10.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDTableViewController.h"

@interface FTDTableViewController ()
@property (nonatomic, strong)FTDTimeTableView *timeTableView;
@end

@implementation FTDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeTableView = [FTDTimeTableView initCustomview];
    self.timeTableView.frame = CGRectMake(0, 0, 844, 622);
    [self.view addSubview:self.timeTableView];
   // self.timeTableView.center = self.view.center;
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

@end