//
//  TFWRealHelpViewController.m
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWRealHelpViewController.h"
#import "TFWRealHelpImageView.h"
#import "TFWRealHelpResultController.h"
#import "FTDPersonTController.h"
@interface TFWRealHelpViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSMutableArray *mutArray;
@property (nonatomic,assign) int index;

@end

@implementation TFWRealHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildTenElement];
    [self buildOkButton];
    
    _index = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self startAnimation];
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
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

-(void)buildTenElement
{
    __weak TFWRealHelpViewController *weakself = self;
    
    self.mutArray = [[NSMutableArray alloc] init];
    TFWRealHelpImageView *v0 = [TFWRealHelpImageView createImagewithTitle:@"" andCenter:CGPointMake(535, 400) andImageName:@"ft_ten_LOGO"];
    v0.alpha = 0.0;
    [self.mutArray addObject:v0];
    [self.view addSubview:v0];
    
    TFWRealHelpImageView *v1 = [TFWRealHelpImageView createImagewithTitle:@"收入丰厚" andCenter:CGPointMake(180, 245) andImageName:@"ft_ten_income"];
    [self.mutArray addObject:v1];
    v1.tag = 1001;
    v1.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    v1.alpha = 0.0;
    [self.view addSubview:v1];
    
    TFWRealHelpImageView *v2 = [TFWRealHelpImageView createImagewithTitle:@"社会贡献" andCenter:CGPointMake(400, 230) andImageName:@"ft_ten_socity"];
    v2.tag = 1002;
    v2.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v2];
    v2.alpha = 0.0;
    [self.view addSubview:v2];
    
    TFWRealHelpImageView *v3 = [TFWRealHelpImageView createImagewithTitle:@"发展空间" andCenter:CGPointMake(685, 190) andImageName:@"ft_ten_pro"];
    v3.tag = 1003;
    v3.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v3];
    v3.alpha = 0.0;
    [self.view addSubview:v3];
    
    TFWRealHelpImageView *v4 = [TFWRealHelpImageView createImagewithTitle:@"荣誉奖励" andCenter:CGPointMake(885, 250) andImageName:@"ft_ten_honour"];
    v4.tag = 1004;
    v4.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v4];
    v4.alpha = 0.0;
    [self.view addSubview:v4];
    
    TFWRealHelpImageView *v5 = [TFWRealHelpImageView createImagewithTitle:@"适合度" andCenter:CGPointMake(285, 400) andImageName:@"ft_ten_suit"];
    v5.tag = 1005;
    v5.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v5];
    v5.alpha = 0.0;
    [self.view addSubview:v5];
    
    TFWRealHelpImageView *v6 = [TFWRealHelpImageView createImagewithTitle:@"学习成长" andCenter:CGPointMake(180, 590) andImageName:@"ft_ten_book"];
    v6.tag = 1006;
    v6.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v6];
    v6.alpha = 0.0;
    [self.view addSubview:v6];
    
    TFWRealHelpImageView *v7 = [TFWRealHelpImageView createImagewithTitle:@"生活平衡" andCenter:CGPointMake(360, 600) andImageName:@"ft_ten_flower"];
    v7.tag = 1007;
    v7.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v7];
    v7.alpha = 0.0;
    [self.view addSubview:v7];
    
    TFWRealHelpImageView *v8 = [TFWRealHelpImageView createImagewithTitle:@"品牌实力" andCenter:CGPointMake(500, 610) andImageName:@"ft_ten_key"];
    v8.tag = 1008;
    v8.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v8];
    [self.view addSubview:v8];
    v8.alpha = 0.0;
    
    TFWRealHelpImageView *v9 = [TFWRealHelpImageView createImagewithTitle:@"工作自主" andCenter:CGPointMake(650, 600) andImageName:@"ft_ten_clock"];
    v9.tag = 1009;
    v9.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v9];
    v9.alpha = 0.0;
    [self.view addSubview:v9];
    
    TFWRealHelpImageView *v10 = [TFWRealHelpImageView createImagewithTitle:@"自由晋级" andCenter:CGPointMake(820, 500) andImageName:@"ft_ten_plane"];
    v10.tag = 1010;
    v10.tapBlock = ^(NSInteger tag){
        [weakself tapAction:tag];
    };
    [self.mutArray addObject:v10];
    v10.alpha = 0.0;
    [self.view addSubview:v10];
}

-(void)buildOkButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(822, 600, 103, 107);
    [bt setImage:[UIImage imageNamed:@"ft_ten_next"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

-(void)startAnimation
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(timerAction:) userInfo:nil repeats:NO];
}

-(void)timerAction:(NSTimer *)timer
{
    if ([self.mutArray count] == 0) {
        [timer invalidate];
        _timer = nil;
        return;
    }
    TFWRealHelpImageView *imageView;
    if (_index == 0) {
        imageView = [self.mutArray firstObject];
        [self.mutArray removeObject:imageView];
        imageView.alpha = 1.0f;
        CGAffineTransform trans = imageView.transform;
        imageView.transform = CGAffineTransformScale(trans, 5.0, 5.0);
        
        [UIView animateWithDuration:1.0 animations:^{
            imageView.transform = trans;
        } completion:^(BOOL finished) {
            [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        }];
        
        
    }
    else
    {
        imageView = [self.mutArray objectAtIndex:(rand() % [self.mutArray count])];
        [self.mutArray removeObject:imageView];
        [UIView animateWithDuration:0.5 animations:^{
            imageView.alpha = 1.0f;
        }];
    }
    
    _index++;
}

-(void)back:(UIButton *)button
{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)okAction
{
    FTDPersonTController *VC=[[FTDPersonTController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
//    NSLog(@"OK");
//    TFWRealHelpResultController *vc = [[TFWRealHelpResultController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tapAction:(NSInteger)tag
{
    TFWRealHelpResultController *vc = [[TFWRealHelpResultController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%ld",tag);
}

-(void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
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
