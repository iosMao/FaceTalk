//
//  TFWSRViewController.m
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSRResultViewController.h"
#import "TFWScrollView.h"
#import "FTDGoodAgentHomeController.h"
#import "FTWDataManager.h"
#import "TFWReportViewController.h"
@interface TFWSRResultViewController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) TFWScrollView *mainScroll;
@property (nonatomic,strong) UILabel *totalRateLabel;
@property (nonatomic,strong) UILabel *suggestRateLabel;
@property (nonatomic,strong) UILabel *modeRateLabel;
@property (nonatomic,strong) UILabel *suggestLabel;

@end

@implementation TFWSRResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildOkButton];
    [self buildScrollView];
    
    [self buildRateLabel];
//    [self buildModeRateLabel];
    [self buildSuggestLabel];
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 1024, 748)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tfw_sr_background" ofType:@"png"]];
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
    
    
//    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBt.frame = CGRectMake(235 / 2.0, 156 / 2.0, 13, 23);
//    [backBt setImage:[UIImage imageNamed:@"tfw_tf_back"] forState:UIControlStateNormal];
//    [backBt addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBt];
}

-(void)buildTitleLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 600 / 2.0, 30)];
    self.titleLabel.text = @"真选择成就事业";
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

-(void)buildOkButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(822, 600, 103, 107);
    [bt setImage:[UIImage imageNamed:@"ft_ten_next"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

-(void)buildScrollView
{
    _mainScroll = [TFWScrollView createScrollWithCenter:CGPointMake(550, 330)];
    [self.view addSubview:_mainScroll];
}

-(void)buildRateLabel
{
    _totalRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 620, 160, 100)];
    _totalRateLabel.textAlignment = NSTextAlignmentCenter;
    _totalRateLabel.font = [UIFont systemFontOfSize:58];
    _totalRateLabel.textColor = [UIColor whiteColor];
    _totalRateLabel.text = [NSString stringWithFormat:@"%d%@",32,@"%"];
    [self.view addSubview:_totalRateLabel];
    
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    for (FTWElementItem *item in [FTWDataManager shareManager].tenElementArray) {
        if (item.selected) {
            [mutArray addObject:item];
        }
    }
    float sum = 0.0f;
    for (int i = 0; i < 5; i++) {
        sum += ((FTWElementItem *)[mutArray objectAtIndex:i]).currentScore / 1.0 / ((FTWElementItem *)[mutArray objectAtIndex:i]).hopeScore;
    }
    sum /= 5.0;
    _totalRateLabel.text = [NSString stringWithFormat:@"%d%@",(int)(sum * 100),@"%"];
    
    _suggestLabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 612, 500, 50)];
    _suggestLabel.numberOfLines = 0;
    _suggestLabel.textAlignment = NSTextAlignmentLeft;
    _suggestLabel.font = [UIFont boldSystemFontOfSize:18];
    _suggestLabel.textColor = [UIColor whiteColor];
    //_suggestLabel.backgroundColor = [UIColor blueColor];
    if (sum >= 0 && sum < 0.59) {
        _suggestLabel.text = @"是时候考虑下未来的职业发展啦！";
        _suggestLabel.frame = CGRectMake(285, 617, 500, 20);
    }else if (sum < 0.79){
        _suggestLabel.text = @"您在比较满意现有工作的同时，也可以尝试挑战新的机会！";
        _suggestLabel.frame = CGRectMake(285, 617, 500, 20);
    }else{
        _suggestLabel.text = @"您目前非常满意自己的职业，您是这个领域的成功者，祝贺您！同时也建议您是时候考虑下保障和财务管理方案！";
    }
    [self.view addSubview:_suggestLabel];
}

-(void)buildModeRateLabel
{
    _modeRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(290, 620, 125, 100)];
    _modeRateLabel.textAlignment = NSTextAlignmentCenter;
    _modeRateLabel.font = [UIFont systemFontOfSize:58];
    _modeRateLabel.textColor = [UIColor whiteColor];
    _modeRateLabel.text = [NSString stringWithFormat:@"%d%@",32,@"%"];
    [self.view addSubview:_modeRateLabel];
}

-(void)buildSuggestLabel
{
    
}

-(void)back:(UIButton *)button
{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)okAction
{
    NSLog(@"OK");
//    id vc=[FTWDataManager shareManager].classArray objectAtIndex:<#(NSUInteger)#>
    TFWOrderModel *orderModel = [[FTWDataManager shareManager] selectOrder];
    NSInteger index = 0;
    
    switch ([FTWDataManager shareManager].currentIndex++ + 1) {
        case 0:
            index = orderModel.first;
            break;
        case 1:
            index = orderModel.second;
            break;
        case 2:
            index = orderModel.third;
            break;
        case 3:
            index = orderModel.fourth;
            break;
            
        default:
            index = -1;
            break;
    }
    id vc = nil;
    if (index == -1) {
        vc = [[TFWReportViewController alloc] init];
    }else
    {
        vc = [[NSClassFromString([[FTWDataManager shareManager].classArray objectAtIndex:index - 1]) alloc] init];
    }
    [self.navigationController setViewControllers:@[vc] animated:YES];
    //[self.navigationController pushViewController:vc animated:YES];
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
