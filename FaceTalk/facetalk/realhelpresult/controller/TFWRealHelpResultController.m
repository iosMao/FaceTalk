//
//  TFWRealHelpResultController.m
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWRealHelpResultController.h"
#import "TFWHelpResultMenuView.h"

@interface TFWRealHelpResultController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) TFWHelpResultMenuView *menu;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation TFWRealHelpResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildMenu];
    [self buildImageView];
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 1024, 748)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ft_ten_back" ofType:@"png"]];
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
    self.titleLabel.text = @"真精彩 友邦帮你";
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

-(void)buildMenu
{
    _menu = [TFWHelpResultMenuView createMenuwithArray:@[@"职涯规划",@"行业潜力",@"公司五年规划",@"渠道定位"] andBottom:CGPointMake(78, 745)];
    __weak TFWRealHelpResultController *weakSelf = self;
    [_menu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_menu];
}

-(void)buildImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 138, 890, 604)];
    _imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ft_ten_demo" ofType:@"png"]];
    [self.view addSubview:_imageView];
}

-(void)back:(UIButton *)button
{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)menuClickAction:(NSInteger)index
{
    NSLog(@"index : %d",index);
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