//
//  DYPictureInstructionDetailViewController.m
//  FaceTalk
//
//  Created by niehonglei on 15/11/12.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "DYPictureInstructionDetailViewController.h"

@interface DYPictureInstructionDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBG;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;

- (IBAction)showLblBody;

- (IBAction)changeImg:(id)sender;
@property(strong, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *lblBody;
@end

@implementation DYPictureInstructionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildTitleLabel];
    [self buildBackButton];
    
    [self changeImg:self.btn1];
}

- (IBAction)showLblBody {
    self.btn5.selected = !self.btn5.isSelected;
    self.lblBody.hidden = !self.btn5.selected;
}

- (IBAction)changeImg:(id)sender {
    if (sender == self.btn1) {
        NSString *str = [NSString stringWithFormat:@"NPA10day.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgBG.image = img;
    } else if (sender == self.btn3) {
        NSString *str = [NSString stringWithFormat:@"NPA4-12mouth.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgBG.image = img;
    } else if (sender == self.btn4) {
        NSString *str = [NSString stringWithFormat:@"NPA13-18mouth.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgBG.image = img;
    } else if (sender == self.btn2) {
        NSString *str = [NSString stringWithFormat:@"NPA1-3mouth.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgBG.image = img;
    }
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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 800 / 2.0, 30)];
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.text = @"NPA2.0人才计划一图说明";
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    
    [self.view addSubview:self.titleLabel];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
