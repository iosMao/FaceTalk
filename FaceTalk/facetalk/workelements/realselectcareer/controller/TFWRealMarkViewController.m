//
//  TFWRealMarkViewController.m
//  demo
//
//  Created by wen on 15/7/26.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWRealMarkViewController.h"
#import "TFWSCItemView.h"
#import "FTDGoodAgentHomeController.h"
@interface TFWRealMarkViewController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) TFWSCItemView *leftItem;
@property (nonatomic,strong) TFWSCItemView *rightItem;

@end

@implementation TFWRealMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildItem];
    [self buildOkButton];
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 1024, 748)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tfw_sc_back" ofType:@"png"]];
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
    self.titleLabel.text = @"真选择成就事业";
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

-(void)buildItem
{
    self.leftItem = [TFWSCItemView createItemWithCenter:CGPointMake(308, 370) andItemArray:@[@"适合度",@"生活平衡",@"学习成长",@"发展空间",@"收入丰厚"] isHope:NO];
    [self.view addSubview:self.leftItem];
    
    self.rightItem = [TFWSCItemView createItemWithCenter:CGPointMake(308 + 440, 370) andItemArray:@[@"适合度",@"生活平衡",@"学习成长",@"发展空间",@"收入丰厚"] isHope:YES];
    [self.view addSubview:self.rightItem];

}

-(void)buildOkButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(822, 600, 103, 107);
    [bt setImage:[UIImage imageNamed:@"tfw_rs_next"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}


-(void)back:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"back");
}

-(void)okAction
{
    FTDGoodAgentHomeController *vc=[[FTDGoodAgentHomeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
