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
#import "FTWDataManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface TFWCustomTalkViewController ()

@property (nonatomic,strong) TFWCFLeftToolView *leftToolView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) TFWCFPickerView *cspickerView;

@end

@implementation TFWCustomTalkViewController

- (void)viewDidLoad {
    NSLog(@"%@",self.navigationController);
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNum) name:@"FTWPOSTPICKERVIEWSELECTEDNUMBER" object:nil];
    [super viewDidLoad];
}




-(void)viewWillAppear:(BOOL)animated
{
    TFDNavViewController *nav=(TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden=NO;
    nav.btnRightMenu.hidden=YES;
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 2046 / 2.0, 1496 / 2.0)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tfw_cf_background" ofType:@"png"]];
    [self.view addSubview:back];
}

-(void)buildBackButton
{
    UIImageView *imageBack=[[UIImageView alloc]initWithFrame:CGRectMake(235 / 2.0, 156 / 2.0, 13, 23)];
    imageBack.image=[UIImage imageNamed:@"tfw_tf_back.png"];
    [self.view addSubview:imageBack];
    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame = CGRectMake(235 / 2.0, 156 / 2.0, 200, 23);
    //[backBt setImage:[UIImage imageNamed:@"tfw_tf_back"] forState:UIControlStateNormal];
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
    TFWCFModelView *view = [TFWCFModelView createModelViewwithX:210 / 2.0 Y:585 / 2.0 title:@"真选择" subTitle:@"理想事业" index:1];
    view.tag=1001;
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
    view.tag=1002;
    [self.view addSubview:view];
    
    view.layer.anchorPoint = CGPointMake(0, 0);
    view.center = CGPointMake(374, -50);
    [UIView animateWithDuration:1.5 animations:^{
        view.center = CGPointMake(374, 150);
    }];
}

-(void)createThree
{
    TFWCFModelView *view = [TFWCFModelView createModelViewwithX:620 Y:240 title:@"真精彩" subTitle:@"友我邦你" index:3];
    view.tag=1003;
    [self.view addSubview:view];
    
    view.layer.anchorPoint = CGPointMake(0, 0);
    view.center = CGPointMake(620, 440);
    [UIView animateWithDuration:1.5 animations:^{
        view.center = CGPointMake(620, 240);
    }];
}

-(void)createFour
{
    TFWCFModelView *view = [TFWCFModelView createModelViewwithX:855 Y:175 title:@"真成就" subTitle:@"璀璨友邦" index:4];
    view.tag=1004;
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


-(void)changeNum
{
    TFWCFModelView *view1 =(TFWCFModelView *)[self.view viewWithTag:1001];
    TFWCFModelView *view2 =(TFWCFModelView *)[self.view viewWithTag:1002];
    TFWCFModelView *view3 =(TFWCFModelView *)[self.view viewWithTag:1003];
    TFWCFModelView *view4 =(TFWCFModelView *)[self.view viewWithTag:1004];
    NSArray *orderArray = [_cspickerView getCurrentSelected];
    [view1 setNumImage:[[orderArray objectAtIndex:0] integerValue]];
    [view2 setNumImage:[[orderArray objectAtIndex:1] integerValue]];
    [view3 setNumImage:[[orderArray objectAtIndex:2] integerValue]];
    [view4 setNumImage:[[orderArray objectAtIndex:3] integerValue]];
    
}

-(void)back:(UIButton *)button
{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)okAction
{
    TFWOrderModel *model = [[TFWOrderModel alloc] init];
    NSArray *orderArray = [_cspickerView getCurrentSelected];
    if (orderArray.count == 4) {
        for (int i = 0; i < 4; i++) {
            if ([[orderArray objectAtIndex:i] integerValue] == 1) {
                model.first = i + 1;
            }
            else if ([[orderArray objectAtIndex:i] integerValue] == 2)
            {
                model.second = i + 1;
                
            }
            else if ([[orderArray objectAtIndex:i] integerValue] == 3)
            {
                model.third = i + 1;
                
            }
            else if ([[orderArray objectAtIndex:i] integerValue] == 4)
            {
                model.fourth = i + 1;
                
            }
        }
        if (model.first==0||model.second==0||model.third==0||model.fourth==0) {
            [SVProgressHUD showInfoWithStatus:@"排序结果有误" maskType:SVProgressHUDMaskTypeBlack];
            return;
            
            
        }
        
        
//        model.first = [[orderArray objectAtIndex:0] integerValue];
//        model.second = [[orderArray objectAtIndex:1] integerValue];
//        model.third = [[orderArray objectAtIndex:2] integerValue];
//     
//        model.fourth = [[orderArray objectAtIndex:3] integerValue];
        
        if ([[FTWDataManager shareManager] saveSelectOrder:model]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FTDCHANGERIGHTMENU" object:nil ];
            if ([self.strType isEqualToString:@"first"]) {
                TFWStartTalkViewController *TFWStartTalkViewCol=[[TFWStartTalkViewController alloc]init];
                [self.navigationController pushViewController:TFWStartTalkViewCol animated:YES];
            }
            else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
            return;
        }
    }
    
    [SVProgressHUD showInfoWithStatus:@"排序结果有误" maskType:SVProgressHUDMaskTypeBlack];
    
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"排序有误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alertView show];
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
