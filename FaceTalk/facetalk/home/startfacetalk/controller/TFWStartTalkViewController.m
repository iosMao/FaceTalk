//
//  TFWStartTalkFaceViewController.m
//  demo
//
//  Created by wen on 15/7/18.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWStartTalkViewController.h"
#import "TFWSTOrderView.h"
#import "TFWRealOrderViewController.h"
#import "TFDNavViewController.h"
#import "FTWDataManager.h"
#import "FTWDataManager.h"
#import "TFWCustomTalkViewController.h"
@interface TFWStartTalkViewController ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation TFWStartTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildOkButton];
    [[FTWDataManager shareManager] createTenElementArray];
    [self buildSettingOrderBtn];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    TFDNavViewController *nav=(TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden=NO;
    nav.btnRightMenu.hidden=NO;
    [self buildOrderView];
}

-(void)buildSettingOrderBtn
{
    UIButton *btn=[[UIButton alloc]initWithFrame: CGRectMake(130, 675, 60, 60)];
    [btn setImage:[UIImage imageNamed:@"FTD_slider_image5.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(SettingOrderAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor clearColor];
    [self.view addSubview:btn];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(200,690,160,30)];
     lbl.text =@"排序设置";
    lbl.numberOfLines = 0;
    //lbl.textAlignment=NSTextAlignmentRight;
    lbl.font = [UIFont boldSystemFontOfSize:15];
    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lbl];
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 1024, 748)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tfw_sf_back" ofType:@"png"]];
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
    [bt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

-(void)buildOrderView
{
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[TFWSTOrderView class]]) {
            [subView removeFromSuperview];
            break;
        }
    }
    TFWOrderModel *model = [[FTWDataManager shareManager] selectOrder];
    NSArray *order = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",model.first],[NSString stringWithFormat:@"%d",model.second],[NSString stringWithFormat:@"%d",model.third],[NSString stringWithFormat:@"%d",model.fourth], nil];
    TFWSTOrderView *orderView = [TFWSTOrderView createItemWithCenter:CGPointMake(530, 380) andIndex:order];
    [self.view addSubview:orderView];
}

-(void)back:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"back");
}

-(void)okAction
{
    TFWOrderModel *orderModel = [[FTWDataManager shareManager] selectOrder];
    NSInteger index = orderModel.first;
    [FTWDataManager shareManager].currentIndex++;
    id vc = nil;
    vc = [[NSClassFromString([[FTWDataManager shareManager].classArray objectAtIndex:index - 1]) alloc] init];
    [self.navigationController setViewControllers:@[vc] animated:YES];
//    TFWRealOrderViewController *vc=[[TFWRealOrderViewController alloc]init];
//    [self.navigationController setViewControllers:@[vc] animated:YES];
    //[self.navigationController pushViewController:vc animated:YES];
    NSLog(@"OK");
}
-(void)SettingOrderAction
{
    TFWCustomTalkViewController *vc=[[TFWCustomTalkViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
