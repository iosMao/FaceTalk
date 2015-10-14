//
//  FTDMyHoursViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/9/25.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDMyHoursViewController.h"
#import "TFWHelpResultMenuView.h"

@interface FTDMyHoursViewController ()
@property (nonatomic, strong) TFWHelpResultMenuView *menu;
@end

@implementation FTDMyHoursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildMenu];
    self.imgDesc.image=[UIImage imageNamed:@"FTD_myhours_MDRT.png"];
    // Do any additional setup after loading the view from its nib.
}
-(void)buildMenu
{
    
    _menu=[TFWHelpResultMenuView createMenuwithArray:@[@"MDRT的一天",@"MOA的一天",@"NPA的一天"] andBottom:CGPointMake(76, 730) andHightBtnIndex:1];
    //_menu = [TFWHelpResultMenuView createMenuwithArray:@[@"企业单位",@"事业单位",@"自由职业"] andBottom:CGPointMake(76, 730)];
    __weak FTDMyHoursViewController *weakSelf = self;
    [_menu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_menu];
}
-(void)menuClickAction:(NSInteger)index
{
    if (index==0) {
        self.imgDesc.image = [UIImage imageNamed:@"FTD_myhours_MDRT.png"];
    }
    else if (index==1)
    {
        self.imgDesc.image = [UIImage imageNamed:@"FTD_myhours_MOA.png"];
    }
    else
    {
        self.imgDesc.image = [UIImage imageNamed:@"FTD_myhours_NPA.png"];
    }
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
- (void)dealloc
{
    NSLog(@"24xiaoshi放了");
}
@end
