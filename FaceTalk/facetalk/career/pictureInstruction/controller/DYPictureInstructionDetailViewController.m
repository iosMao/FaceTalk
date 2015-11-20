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
    
//    UILabel *lblBody = [[UILabel alloc]initWithFrame:CGRectMake(259, 427, 230, 90)];
////    testLabel.textAlignment = NSTextAlignmentCenter;
//    lblBody.numberOfLines = 0;
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"新秀计划签约首三个月完成NOP 6 件且 FYC>9,000/6,000可自第4个月起衔接       NPA2.0 菁英计划的第4个月"];
//    
////    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(2, 2)];
//    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(52, 12)];
//    lblBody.attributedText = AttributedStr;
//    lblBody.hidden = YES;
//    self.lblBody = lblBody;
//    [self.view addSubview:self.lblBody];
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
    //    backBt.backgroundColor = [UIColor blackColor];
    //[backBt setImage:[UIImage imageNamed:@"tfw_tf_back"] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
}

-(void)buildTitleLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 600 / 2.0, 30)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    self.titleLabel.text = @"2.18工程";
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.frame = CGRectMake(305, 75, 300, 30);
//    lblTitle.backgroundColor = [UIColor redColor];
    lblTitle.text = @"-NPA2.0一图说明";
    lblTitle.font = [UIFont systemFontOfSize:32];
    lblTitle.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:lblTitle];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
