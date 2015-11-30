//
//  DYPictureInstructionViewController.m
//  FaceTalk
//
//  Created by niehonglei on 15/11/12.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "DYPictureInstructionViewController.h"
#import "TFWHelpResultMenuView.h"
#import "DYPictureInstructionDetailViewController.h"

@interface DYPictureInstructionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBG;
@property(strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) TFWHelpResultMenuView *leftMenu;
@property (weak, nonatomic) UIButton *btn;
@end

@implementation DYPictureInstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildTitleLabel];
    [self buildBackButton];
    [self buildLeftMenu];
    
    [self menuClickAction:0];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(770, 487, 100, 30);
    [btn addTarget:self action:@selector(GOTONext) forControlEvents:UIControlEventTouchUpInside];
    self.btn = btn;
    [self.view addSubview:self.btn];
}

- (void)buildLeftMenu
{
    _leftMenu = [TFWHelpResultMenuView  createMenuwithArray:@[@"营销员", @"业务经理", @"业务总监"] andBottom:CGPointMake(78, 745) andHightBtnIndex:0];
    
    __weak DYPictureInstructionViewController *weakSelf = self;
    [_leftMenu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_leftMenu];
}

-(void)menuClickAction:(NSInteger)index
{
    if (index == 0) {
        NSString *str = [NSString stringWithFormat:@"dySellMan.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgBG.image = img;
        
        self.titleLabel.text = @"营销员收入来源";
        self.btn.hidden = NO;
    } else if (index == 1) {
        NSString *str = [NSString stringWithFormat:@"dySellWoman.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgBG.image = img;
        
        self.titleLabel.text = @"业务经理收入来源";
        self.btn.hidden = YES;
    } else if (index == 2) {
        NSString *str = [NSString stringWithFormat:@"dySellManage.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgBG.image = img;
        
        self.titleLabel.text = @"业务总监收入来源";
        self.btn.hidden = YES;
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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 600 / 2.0, 30)];
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)GOTONext {
    DYPictureInstructionDetailViewController *vc = [[DYPictureInstructionDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
