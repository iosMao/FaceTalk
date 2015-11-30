//
//  DYrevenueExampleViewController.m
//  FaceTalk
//
//  Created by niehonglei on 15/11/11.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "DYrevenueExampleViewController.h"
#import "DYrevenueExampleDetailViewController.h"

@interface DYrevenueExampleViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property(strong, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgBG;
- (IBAction)GOTONext:(id)sender;
@end

@implementation DYrevenueExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = [NSString stringWithFormat:@"dyManageBG.png"];
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
    backBt.frame = CGRectMake(235 / 2.0, 156 / 2.0, 300, 30);
    [backBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
}

-(void)buildTitleLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 600 / 2.0, 30)];
    self.titleLabel.text = @"绩优主管收入演示";
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GOTONext:(id)sender {
    DYrevenueExampleDetailViewController *vc = [[DYrevenueExampleDetailViewController alloc] init];
    if (sender == self.btn1) {
        vc.index = 0;
    } else if (sender == self.btn2) {
        vc.index = 1;
    } else if (sender == self.btn3) {
        vc.index = 2;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
