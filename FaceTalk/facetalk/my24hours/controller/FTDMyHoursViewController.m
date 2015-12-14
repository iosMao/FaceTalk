//
//  FTDMyHoursViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/9/25.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDMyHoursViewController.h"
#import "TFWHelpResultMenuView.h"
#import "TFDNavViewController.h"
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
-(void)viewWillAppear:(BOOL)animated
{
    TFDNavViewController *nav = (TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden = NO;
    nav.btnRightMenu.hidden = YES;
    
}
-(void)buildMenu
{
    
    _menu=[TFWHelpResultMenuView createMenuwithArray:@[@"MDRT",@"MOA",@"NPA"] andBottom:CGPointMake(76, 730) andHightBtnIndex:0];
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
        self.imgDesc.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FTD_myhours_MDRT"  ofType:@"png"]];
        //self.imgDesc.image = [UIImage imageNamed:@"FTD_myhours_MDRT.png"];
    }
    else if (index==1)
    {
        self.imgDesc.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FTD_myhours_MOA"  ofType:@"png"]];
        
    }
    else
    {
        self.imgDesc.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FTD_myhours_NPA"  ofType:@"png"]];
        
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
