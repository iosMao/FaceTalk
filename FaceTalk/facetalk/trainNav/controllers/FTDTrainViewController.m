//
//  FTDTrainViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/12.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDTrainViewController.h"
#import "TFWHelpResultMenuView.h"
#import "FTDTeacherTeamView.h"
#import "FTDDevWayView.h"
#import "FTDProfessionalTrainView.h"
@interface FTDTrainViewController ()
@property (nonatomic, strong) TFWHelpResultMenuView *menu;
@property (nonatomic, strong) FTDTeacherTeamView *TeacherTeamView;
@property (nonatomic, strong) FTDDevWayView *DevWayView;
@property (nonatomic, strong) FTDProfessionalTrainView *ProfessionalTrainView;
@end

@implementation FTDTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildMenu];
    
    [self buildViews];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)buildViews
{
    _TeacherTeamView = [FTDTeacherTeamView initCustomview];
    _TeacherTeamView.frame = CGRectMake(97, 122, 887, 622);
    
    _DevWayView = [FTDDevWayView initCustomview];
    _DevWayView.frame = CGRectMake(97, 122, 887, 622);
    [self.view addSubview:_DevWayView];
    
    _ProfessionalTrainView = [FTDProfessionalTrainView  initCustomview];
    _ProfessionalTrainView.frame = CGRectMake(97, 122, 887, 622);
    
    
}


-(void)buildMenu
{
    
    _menu = [TFWHelpResultMenuView createMenuwithArray:@[@"发展路径", @"专业培训", @"讲师团队"] andBottom:CGPointMake(76, 730) andHightBtnIndex:0];
    //_menu = [TFWHelpResultMenuView createMenuwithArray:@[@"企业单位",@"事业单位",@"自由职业"] andBottom:CGPointMake(76, 730)];
    __weak FTDTrainViewController *weakSelf = self;
    [_menu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_menu];
}
-(void)menuClickAction:(NSInteger)index
{
    if (index == 0) {
        [_DevWayView removeFromSuperview];
        [_ProfessionalTrainView removeFromSuperview];
        [_TeacherTeamView removeFromSuperview];
        [self.view addSubview:_DevWayView];
     }
    else if (index == 1)
    {
        [_DevWayView removeFromSuperview];
        [_ProfessionalTrainView removeFromSuperview];
        [_TeacherTeamView removeFromSuperview];
        [self.view addSubview:_ProfessionalTrainView];
    }
    else
    {
        [_DevWayView removeFromSuperview];
        [_ProfessionalTrainView removeFromSuperview];
        [_TeacherTeamView removeFromSuperview];
        [self.view addSubview:_TeacherTeamView];
    }
}
-(void)dealloc
{
    NSLog(@"培训导航释放");
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
    [_DevWayView removeFromSuperview];
    [_ProfessionalTrainView removeFromSuperview];
    [_TeacherTeamView removeFromSuperview];

    [self.navigationController popViewControllerAnimated:YES];
}
@end
