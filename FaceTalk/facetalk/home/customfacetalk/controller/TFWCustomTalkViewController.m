//
//  TFWCustomTalkViewController.m
//  demo
//
//  Created by wen on 15/7/16.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWCustomTalkViewController.h"
#import "TFWCFLeftToolView.h"
#import "TFWCFModelView.h"
#import "TFWCFPickerView.h"
#import "TFWStartTalkViewController.h"
#import "TFDNavViewController.h"
@interface TFWCustomTalkViewController ()

@property (nonatomic,strong) TFWCFLeftToolView *leftToolView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) TFWCFPickerView *cspickerView;

@end

@implementation TFWCustomTalkViewController

- (void)viewDidLoad {
    NSLog(@"%@",self.navigationController);
    TFDNavViewController *nav=(TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden=NO;
    nav.btnRightMenu.hidden=NO;
    // Do any additional setup after loading the view.
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildLeftTool];
    [self buildFourModel];
    [self buildguideImage];
    [self buildPickerBack];
    [self buildPickerView];
    [self buildOkButton];
    
    [super viewDidLoad];
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 2046 / 2.0, 1496 / 2.0)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tfw_cf_background" ofType:@"png"]];
    [self.view addSubview:back];
}

-(void)buildBackButton
{
    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame = CGRectMake(235 / 2.0, 156 / 2.0, 13, 23);
    [backBt setImage:[UIImage imageNamed:@"tfw_tf_back"] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
}

-(void)buildTitleLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 389 / 2.0, 30)];
    self.titleLabel.text = @"定制面谈流程";
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

-(void)buildLeftTool
{
    self.leftToolView = [[TFWCFLeftToolView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.leftToolView];
}

-(void)buildFourModel
{
    [self createOne];
    [self createTwo];
    [self createThree];
    [self createFour];
}

-(void)createOne
{
    TFWCFModelView *view = [TFWCFModelView createModelViewwithX:210 / 2.0 Y:585 / 2.0 title:@"真选择" subTitle:@"成就事业" index:1];
    [self.view addSubview:view];
    view.layer.anchorPoint = CGPointMake(0, 0);
    view.center = CGPointMake(210 / 2.0, 585 / 2.0 + 200);
    [UIView animateWithDuration:1.5 animations:^{
        view.center = CGPointMake(210 / 2.0, 585 / 2.0);
    }];
}

-(void)createTwo
{
    TFWCFModelView *view = [TFWCFModelView createModelViewwithX:374 Y:150 title:@"真英才" subTitle:@"傲人风采" index:2];
    [self.view addSubview:view];
    
    view.layer.anchorPoint = CGPointMake(0, 0);
    view.center = CGPointMake(374, -50);
    [UIView animateWithDuration:1.5 animations:^{
        view.center = CGPointMake(374, 150);
    }];
}

-(void)createThree
{
    TFWCFModelView *view = [TFWCFModelView createModelViewwithX:620 Y:240 title:@"真精彩" subTitle:@"友邦有你" index:3];
    [self.view addSubview:view];
    
    view.layer.anchorPoint = CGPointMake(0, 0);
    view.center = CGPointMake(620, 440);
    [UIView animateWithDuration:1.5 animations:^{
        view.center = CGPointMake(620, 240);
    }];
}

-(void)createFour
{
    TFWCFModelView *view = [TFWCFModelView createModelViewwithX:855 Y:175 title:@"真成就" subTitle:@"我在友邦" index:4];
    [self.view addSubview:view];
    
    view.layer.anchorPoint = CGPointMake(0, 0);
    view.center = CGPointMake(855, -25);
    [UIView animateWithDuration:1.5 animations:^{
        view.center = CGPointMake(855, 175);
    }];
}

-(void)buildguideImage
{
    UIImageView *guideView = [[UIImageView alloc] initWithFrame:CGRectMake(310, 650, 39, 39)];
    guideView.image = [UIImage imageNamed:@"tfw_cf_nextguide"];
    [self.view addSubview:guideView];
}

-(void)buildPickerBack
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(400, 768 - 177, 352, 177)];
    [back.layer setMasksToBounds:YES];
    UIGraphicsBeginImageContext(CGSizeMake(352, 177));
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 352, 177) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 219 / 255.0, 235 / 255.0, 244 / 255.0, 1);
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    back.image = image;
    
    [self.view addSubview:back];
}

-(void)buildPickerView
{
    self.cspickerView = [[TFWCFPickerView alloc] initWithFrame:CGRectMake(412, 603, 327, 120)];
    [self.view addSubview:self.cspickerView];
}

-(void)buildOkButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(800, 588, 127, 125);
    [bt setImage:[UIImage imageNamed:@"tfw_tf_setting"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

-(void)back:(UIButton *)button
{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)okAction
{
    TFWStartTalkViewController *TFWStartTalkViewCol=[[TFWStartTalkViewController alloc]init];
    [self.navigationController pushViewController:TFWStartTalkViewCol animated:YES];
    NSLog(@"OK");
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
