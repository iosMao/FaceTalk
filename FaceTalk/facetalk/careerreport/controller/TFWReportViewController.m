//
//  TFWReportViewController.m
//  demo
//
//  Created by wen on 15/8/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWReportViewController.h"
#import "TFWReportView.h"

@interface TFWReportViewController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *customNameLabel;
@property (nonatomic,strong) UILabel *adviserNameLabel;
@property (nonatomic,strong) TFWReportView *reportView;

@end

@implementation TFWReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildNameLabel];
    [self buildReportView];
    [self buildPopButton];
    [self buildShadow];
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 2046 / 2.0, 1496 / 2.0)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ftw_share_back" ofType:@"png"]];
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

-(void)buildNameLabel
{
    _customNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(386, 378, 320, 56)];
    _customNameLabel.font = [UIFont systemFontOfSize:43];
    _customNameLabel.textColor = [UIColor whiteColor];
    _customNameLabel.textAlignment = NSTextAlignmentCenter;
    _customNameLabel.text = @"致 李月月";
    [self.view addSubview:_customNameLabel];
    
    _adviserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(582, 441, 80, 30)];
    _adviserNameLabel.font = [UIFont systemFontOfSize:19];
    _adviserNameLabel.textColor = [UIColor whiteColor];
    _adviserNameLabel.textAlignment = NSTextAlignmentCenter;
    _adviserNameLabel.text = @"马萧萧";
    [self.view addSubview:_adviserNameLabel];
}


-(void)buildPopButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_customNameLabel.frame), CGRectGetMinY(_customNameLabel.frame), CGRectGetWidth(_customNameLabel.frame), CGRectGetHeight(_customNameLabel.frame) * 4)];
    [button addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buildShadow
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 435 + 46, 804, 102)];
    imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ftw_share_shadow" ofType:@"png"]];
    [self.view addSubview:imageView];
}

-(void)buildReportView
{
    _reportView = [[TFWReportView alloc] init];
    _reportView.center = CGPointMake(CGRectGetMidX(_customNameLabel.frame), CGRectGetHeight(_reportView.frame) / 2.0);
    [self.view addSubview:_reportView];
}

-(void)popAction:(UIButton *)button
{
    [UIView animateWithDuration:1.0 animations:^{
        _reportView.center = CGPointMake(CGRectGetMidX(_customNameLabel.frame), 295);
        _reportView.alpha = 1.0f;
    }];
}

-(void)back:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
