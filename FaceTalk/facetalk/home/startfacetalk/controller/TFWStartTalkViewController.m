//
//  TFWStartTalkFaceViewController.m
//  demo
//
//  Created by wen on 15/7/18.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWStartTalkViewController.h"
#import "TFWSTOrderView.h"

@interface TFWStartTalkViewController ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation TFWStartTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildOkButton];
    [self buildOrderView];
    
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 1024, 748)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tfw_sf_back" ofType:@"png"]];
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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 600 / 2.0, 30)];
    self.titleLabel.text = @"精彩未来 即将呈现";
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

-(void)buildOkButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(800, 588, 127, 125);
    [bt setImage:[UIImage imageNamed:@"tfw_sf_next"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:bt];
}

-(void)buildOrderView
{
    NSArray *order = [NSArray arrayWithObjects:@"1",@"3",@"2",@"4", nil];
    TFWSTOrderView *orderView = [TFWSTOrderView createItemWithCenter:CGPointMake(530, 380) andIndex:order];
    [self.view addSubview:orderView];
}

-(void)back:(UIButton *)button
{
    NSLog(@"back");
}

-(void)okAction
{
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
