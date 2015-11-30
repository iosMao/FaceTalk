//
//  TFWRealOrderViewController.m
//  demo
//
//  Created by wen on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//
//数组｛0.发展空间  1.工作自主 2.品牌实力 3.荣誉奖励 4.社会贡献 5.生活平衡  6.适合度  7.收入丰厚 8.学习成长 9.自由晋级
#import "TFWRealOrderViewController.h"
#import "TFWRSCenterView.h"
#import "TFWRSButtonView.h"
#import "TFWRealMarkViewController.h"
#import "FTWDataManager.h"
#import "FTJsonManager.h"
#import "TFDNavViewController.h"
@interface TFWRealOrderViewController ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *panView;
@property (nonatomic,strong) TFWRSCenterView *centerView;
@property (nonatomic,assign) int number;
@property (nonatomic,assign) int index;
@property (nonatomic,assign) int animation_index;
@property (nonatomic,strong) NSMutableArray *viewArray;
@property (nonatomic,strong) NSTimer *circleTimer;
@property (nonatomic,strong) NSTimer *animationTimer;
@property (nonatomic,strong) UIImageView *showElementImageView;

@end

@implementation TFWRealOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewArray = [[NSMutableArray alloc] init];
    _index = 0;
    _animation_index = 0;
    // Do any additional setup after loading the view.
    [self buildBackGround];
    [self buildPan];
    //[self buildBackButton];
    [self buildTitleLabel];
    [self buildOkButton];
    [self buildCenterView];
    [self buildTenElements];
    [self createImageView];
    [[FTWDataManager shareManager] createTenElementArray];
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"FTD_isFinishMark"];
    [self.view.layer setMasksToBounds:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    TFDNavViewController *nav=(TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden=NO;
    nav.btnRightMenu.hidden=NO;
    
    
    [self startAnimation];
    _circleTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(panRound) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%@ viewWillDisappear",[self class]);
    [_circleTimer invalidate];
    [_animationTimer invalidate];
}

-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 1024, 748)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tfw_rs_background" ofType:@"png"]];
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
    self.titleLabel.text = @"真选择 理想事业";
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

-(void)buildOkButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(822, 600, 103, 107);
    [bt setImage:[UIImage imageNamed:@"tfw_rs_next"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

-(void)buildPan
{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 1024, 768 - 68)];
    back.backgroundColor = [UIColor clearColor];
    back.layer.masksToBounds = YES;
    [self.view addSubview:back];
    _panView = [UIImageView new];
    _panView.layer.anchorPoint = CGPointMake(0.5, 0);
    _panView.frame = CGRectMake(235, 340, 601, 416);
    _panView.image = [UIImage imageNamed:@"tfw_rs_pan"];
    [back addSubview:_panView];
}

-(void)buildCenterView
{
    _centerView = [TFWRSCenterView createWithCenter:CGPointMake(535, 373)];
    [self.view addSubview:_centerView];
    [_centerView setAttributeString:0];
}

-(void)buildTenElements
{
    __weak TFWRealOrderViewController *weak = self;
    TFWRSButtonView *bt_brand = [TFWRSButtonView createButtonWithTag:TenElementTypeBrand andCenter:CGPointMake(520, 619)];
    [bt_brand setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_brand setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_brand];
    [self.view addSubview:bt_brand];
    
    TFWRSButtonView *bt_free = [TFWRSButtonView createButtonWithTag:TenElementTypeFree andCenter:CGPointMake(337, 512)];
    [bt_free setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_free setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_free];
    [self.view addSubview:bt_free];
    
    TFWRSButtonView *bt_honour = [TFWRSButtonView createButtonWithTag:TenElementTypeHonour andCenter:CGPointMake(747, 511)];
    [bt_honour setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_honour setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_honour];
    [self.view addSubview:bt_honour];
    
    TFWRSButtonView *bt_income = [TFWRSButtonView createButtonWithTag:TenElementTypeIncome andCenter:CGPointMake(646, 152)];
    [bt_income setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_income setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_income];
    [self.view addSubview:bt_income];
    
    TFWRSButtonView *bt_learn = [TFWRSButtonView createButtonWithTag:TenElementTypeLearn andCenter:CGPointMake(253, 228)];
    [bt_learn setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_learn setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_learn];
    [self.view addSubview:bt_learn];
    
    TFWRSButtonView *bt_life = [TFWRSButtonView createButtonWithTag:TenElementTypeLife andCenter:CGPointMake(145, 394)];
    [bt_life setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_life setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_life];
    [self.view addSubview:bt_life];
    
    TFWRSButtonView *bt_socity = [TFWRSButtonView createButtonWithTag:TenElementTypeSocity andCenter:CGPointMake(408, 253)];
    [bt_socity setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_socity setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_socity];
    [self.view addSubview:bt_socity];
    
    TFWRSButtonView *bt_space = [TFWRSButtonView createButtonWithTag:TenElementTypeSpace andCenter:CGPointMake(858, 372)];
    [bt_space setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_space setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_space];
    [self.view addSubview:bt_space];
    
    TFWRSButtonView *bt_suit = [TFWRSButtonView createButtonWithTag:TenElementTypeSuit andCenter:CGPointMake(805, 190)];
    [bt_suit setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_suit setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_suit];
    [self.view addSubview:bt_suit];
    
    TFWRSButtonView *bt_work = [TFWRSButtonView createButtonWithTag:TenElementTypeWork andCenter:CGPointMake(215, 610)];
    [bt_work setTapBlock:^(UIButton *bt){
        [weak elementAction:bt];
    }];
    [bt_work setAddBlock:^(UIButton *bt){
        [weak addAction:bt];
    }];
    [_viewArray addObject:bt_work];
    [self.view addSubview:bt_work];

}

-(void)createImageView
{
    _showElementImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 548 / 2.0, 476 / 2.0)];
    [self.view addSubview:_showElementImageView];
    _showElementImageView.alpha = 0.0f;
}

-(void)showImageViewwithName:(NSString *)imageName andCenter:(CGPoint)center
{
    _showElementImageView.image = [UIImage imageWithContentsOfFile:imageName];
    //_showElementImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"kgten_shd_06" ofType:@"png"]];
    _showElementImageView.center = center;
    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    button.backgroundColor = [UIColor clearColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(hideImageView:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.6 animations:^{
        _showElementImageView.alpha = 1.0f;
    }];
}

-(void)hideImageView:(UIButton *)bt
{
    [UIView animateWithDuration:0.6 animations:^{
        _showElementImageView.alpha = 0.0f;
    }];
    [bt removeFromSuperview];
}

-(void)startAnimation
{
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(timerAction:) userInfo:self repeats:YES];
}

-(void)timerAction:(NSTimer *)timer
{
    if (_animation_index == 4) {
        [timer invalidate];
    }
    UIView *view1 = nil;
    UIView *view2 = nil;
    UIView *view3 = nil;
    
    switch (_animation_index) {
        case 0:
        {
            view1 = (UIView *)[self.viewArray objectAtIndex:0];
            view2 = (UIView *)[self.viewArray objectAtIndex:5];
            view3 = (UIView *)[self.viewArray objectAtIndex:8];
            [UIView animateWithDuration:1.0 animations:^{
                view1.alpha = 1.0;
                view2.alpha = 1.0;
                view3.alpha = 1.0;
            }];
        }
            break;
            
        case 1:
        {
            view1 = (UIView *)[self.viewArray objectAtIndex:1];
            view2 = (UIView *)[self.viewArray objectAtIndex:4];
            view3 = (UIView *)[self.viewArray objectAtIndex:9];
            [UIView animateWithDuration:1.0 animations:^{
                view1.alpha = 1.0;
                view2.alpha = 1.0;
                view3.alpha = 1.0;
            }];
        }
            break;
            
        case 2:
        {
            view1 = (UIView *)[self.viewArray objectAtIndex:2];
            view2 = (UIView *)[self.viewArray objectAtIndex:7];
            view3 = (UIView *)[self.viewArray objectAtIndex:8];
            [UIView animateWithDuration:1.0 animations:^{
                view1.alpha = 1.0;
                view2.alpha = 1.0;
                view3.alpha = 1.0;
            }];
        }
            break;
            
        case 3:
        {
            view1 = (UIView *)[self.viewArray objectAtIndex:3];
            view2 = (UIView *)[self.viewArray objectAtIndex:6];
            view3 = (UIView *)[self.viewArray objectAtIndex:9];
            [UIView animateWithDuration:1.0 animations:^{
                view1.alpha = 1.0;
                view2.alpha = 1.0;
                view3.alpha = 1.0;
            }];
        }
            break;
            
        default:
            break;
    }
    
    _animation_index++;
}

-(void)elementAction:(UIButton *)bt
{
    if (self.number == 5 && bt.selected == NO) {
        NSLog(@"more");
        return;
    }
    
    NSMutableArray *orderArray = ((FTWElementItem *)[[FTWDataManager shareManager].tenElementArray firstObject]).orderArray;
    if (bt.selected) {
        for (NSNumber *number in orderArray) {
            if ([number integerValue] == bt.tag) {
                [orderArray removeObject:number];
                break;
            }
        }
        bt.layer.borderWidth = 0.0f;
        self.number--;
    }
    else
    {
        self.number++;
        bt.layer.borderColor = [UIColor colorWithRed:172 / 255.0 green:0 blue:42 / 255.0 alpha:1.0].CGColor;
        bt.layer.borderWidth = 1.0f;
        [orderArray addObject:[NSNumber numberWithInteger:bt.tag]];
    }
    bt.selected = !bt.selected;
    
    [self setCenterViewNumber:self.number * 20];
    
    ((FTWElementItem *)[FTWDataManager shareManager].tenElementArray[bt.tag]).selected = bt.selected;
    NSLog(@"%d",bt.tag);
}

-(void)addAction:(UIButton *)bt
{
    NSLog(@"%d",bt.tag);
    switch (bt.tag) {
        case TenElementTypeBrand:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:2] andCenter:CGPointMake(bt.superview.center.x + 190, bt.superview.center.y - 170)];
            break;
            
        case TenElementTypeFree:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:9]  andCenter:CGPointMake(bt.superview.center.x + 200, bt.superview.center.y - 180)];
            break;
            
        case TenElementTypeHonour:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:3]  andCenter:CGPointMake(bt.superview.center.x - 120, bt.superview.center.y - 170)];
            break;
            
        case TenElementTypeIncome:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:7]  andCenter:CGPointMake(bt.superview.center.x - 120, bt.superview.center.y + 100)];
            break;
            
        case TenElementTypeLearn:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:8]  andCenter:CGPointMake(bt.superview.center.x + 200, bt.superview.center.y + 100)];
            break;
            
        case TenElementTypeLife:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:5]  andCenter:CGPointMake(bt.superview.center.x + 190, bt.superview.center.y + 100)];
            break;
            
        case TenElementTypeSocity:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:4]  andCenter:CGPointMake(bt.superview.center.x + 180, bt.superview.center.y + 100)];
            break;
            
        case TenElementTypeSpace:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:0]  andCenter:CGPointMake(bt.superview.center.x - 120, bt.superview.center.y + 100)];
            break;
            
        case TenElementTypeSuit:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:6]  andCenter:CGPointMake(bt.superview.center.x - 120, bt.superview.center.y + 100)];
            break;
            
        case TenElementTypeWork:
            [self showImageViewwithName:[[FTJsonManager shareManager].ten_objective_elements objectAtIndex:1]  andCenter:CGPointMake(bt.superview.center.x + 180, bt.superview.center.y - 160)];
            break;
            
        default:
            break;
    }
}

-(void)setCenterViewNumber:(int)number
{
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(numberChange:) userInfo:nil repeats:YES];
}

-(void)numberChange:(NSTimer *)timer
{
    if (self.number * 20 < self.centerView.number) {
        [self.centerView setAttributeString:self.centerView.number - 1];
    }
    else if(self.number * 20 > self.centerView.number)
    {
        [self.centerView setAttributeString:self.centerView.number + 1];
    }
    else{
        [timer invalidate];
    }
}

-(void)panRound
{
    _panView.transform = CGAffineTransformMakeRotation(-M_PI / 50 * _index++);
    
}

-(void)back:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"back");
}

-(void)okAction
{
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    for (FTWElementItem *item in [FTWDataManager shareManager].tenElementArray) {
        if (item.selected) {
            [mutArray addObject:item];
        }
    }
    if (mutArray.count != 5) {
        UIAlertView *alretView = [[UIAlertView alloc] initWithTitle:nil message:@"最少选择5个" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alretView show];
        
        return;
    }

    
    TFWRealMarkViewController *vc=[[TFWRealMarkViewController
                                    alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"OK");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"%@",[self class]);
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
