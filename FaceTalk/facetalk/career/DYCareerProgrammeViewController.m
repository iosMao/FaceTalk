//
//  DYCareerProgrammeViewController.m
//  FaceTalk
//
//  Created by niehonglei on 15/11/11.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "DYCareerProgrammeViewController.h"
#import "DYrevenueExampleViewController.h"
#import "DYPictureInstructionViewController.h"
#import "FTDRevenueTrialViewController.h"
#import "TFDNavViewController.h"
@interface DYCareerProgrammeViewController ()

@property(strong, nonatomic) UILabel *titleLabel;
- (IBAction)GOTOrevenueExample;
@property (weak, nonatomic) IBOutlet UIImageView *imgBG;
- (IBAction)GOTOPictureInstruction;
- (IBAction)calculationAction:(id)sender;

@end

@implementation DYCareerProgrammeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    TFDNavViewController *nav=(TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden=NO;
    nav.btnRightMenu.hidden=YES;
    
    
    NSString *str = [NSString stringWithFormat:@"careerProgramme.png"];
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    self.imgBG.image = img;
    
    [self buildTitleLabel];
    [self buildBackButton];
}

-(void)buildBackButton
{
    UIImageView *imageBack=[[UIImageView alloc]initWithFrame:CGRectMake(235 / 2.0, 156 / 2.0, 13, 23)];
    imageBack.image=[UIImage imageNamed:@"tfw_tf_back.png"];
    [self.view addSubview:imageBack];
    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame = CGRectMake(235 / 2.0, 156 / 2.0, 200, 23);
    //[backBt setImage:[UIImage imageNamed:@"tfw_tf_back"] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
}

-(void)buildTitleLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 600 / 2.0, 30)];
    self.titleLabel.text = @"职涯规划";
    self.titleLabel.font = [UIFont systemFontOfSize:40];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GOTOrevenueExample {
    DYrevenueExampleViewController *vc = [[DYrevenueExampleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)GOTOPictureInstruction {
    DYPictureInstructionViewController *vc = [[DYPictureInstructionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)calculationAction:(id)sender {
    FTDRevenueTrialViewController *vc = [[FTDRevenueTrialViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
