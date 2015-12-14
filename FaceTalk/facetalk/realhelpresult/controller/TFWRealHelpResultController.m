//
//  TFWRealHelpResultController.m
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWRealHelpResultController.h"
#import "TFWHelpResultMenuView.h"
#import "FTDRightMenuView.h"
#import "FTDAIADetailScrollView.h"
#import "FTDTimeTableView.h"
#import "TFDNavViewController.h"
@interface TFWRealHelpResultController ()
{
    NSMutableArray *arrayChildrenList;
}
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) TFWHelpResultMenuView *menu;//左导航
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) FTDRightMenuView *rightMenu;//右导航
@property (nonatomic,strong) FTDAIADetailScrollView *detailScrollView;
@property (nonatomic,strong) FTDTimeTableView *timeView;
@end

@implementation TFWRealHelpResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayChildrenList = [[NSMutableArray alloc]initWithArray:[_dicDesc objectForKey:@"children"]];
    // Do any additional setup after loading the view.
    NSLog(@"友邦详情：%@",[_dicDesc objectForKey:@"name"]);
    
    [self buildBackGround];
    [self buildBackButton];
    [self buildTitleLabel];
    [self buildMenu];
    _detailScrollView = [FTDAIADetailScrollView initCustomview];
    _detailScrollView.frame = CGRectMake(97, 122, 887, 622);
    [self.view addSubview:_detailScrollView];
    
    _timeView = [FTDTimeTableView initCustomview];
    _timeView.frame = CGRectMake(97, 122, 887, 622);
    
    
    if ([[[arrayChildrenList objectAtIndex:0] objectForKey:@"name"] isEqualToString:@"专业培训"]) {
        _rightMenu.hidden = NO;
        [_detailScrollView creatImageScroll: [[[[arrayChildrenList objectAtIndex:0]objectForKey:@"children"] objectAtIndex:0] objectForKey:@"pictures"]];
    }
    else{
        _rightMenu.hidden = YES;
        if ([[[arrayChildrenList objectAtIndex:0] objectForKey:@"name"]isEqualToString:@"自主选择时间分配"]||[[[arrayChildrenList objectAtIndex:0] objectForKey:@"name"]isEqualToString:@"时间自主"] ) {
            
            [_detailScrollView removeFromSuperview];
            [self.view addSubview:_timeView];
            
        
            
        }
        else{
            [_detailScrollView creatImageScroll:[[arrayChildrenList objectAtIndex:0] objectForKey:@"pictures"]];
            
        }
    }
    
    
    
    
    //[self buildImageView];
}
-(void)viewWillAppear:(BOOL)animated
{
    TFDNavViewController *nav=(TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden=NO;
    nav.btnRightMenu.hidden=NO;
    
}
-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 1024, 748)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FTDbackgroundImage" ofType:@"png"]];
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
    self.titleLabel.text = [_dicDesc objectForKey:@"name"];
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

-(void)buildMenu
{
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int i=0; i<arrayChildrenList.count; i++) {
        
        [array addObject:[[arrayChildrenList objectAtIndex:i] objectForKey:@"name"]];
    }
    
    
    _menu = [TFWHelpResultMenuView  createMenuwithArray:array andBottom:CGPointMake(74, 745) andHightBtnIndex:0];
     
    __weak TFWRealHelpResultController *weakSelf = self;
    [_menu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_menu];
    
    if ([[[arrayChildrenList objectAtIndex:0] objectForKey:@"name"] isEqualToString:@"专业培训"]){
        _rightMenu = [FTDRightMenuView createMenuwithArray:@[[[[[arrayChildrenList objectAtIndex:0]objectForKey:@"children"] objectAtIndex:0] objectForKey:@"name"],[[[[arrayChildrenList objectAtIndex:0]objectForKey:@"children"] objectAtIndex:1] objectForKey:@"name"]] andBottom:CGPointMake(1000, 745) andHightBtnIndex:0];
        
            [_rightMenu setRightMenuTapBlock:^(NSInteger index){
            [weakSelf RightMenuClickAction:index];
        }];
        [self.view addSubview:_rightMenu];
        _rightMenu.hidden = YES;
    }
}

-(void)buildImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(95, 122, 890, 620)];
    _imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ftw_shourufenghou_fulidaiyu" ofType:@"png"]];
    [self.view addSubview:_imageView];
}

-(void)back:(UIButton *)button
{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)menuClickAction:(NSInteger)index
{
    NSLog(@"index : %ld",(long)index);
    if ([[[arrayChildrenList objectAtIndex:index] objectForKey:@"name"] isEqualToString:@"专业培训"]) {
        _rightMenu.hidden = NO;
        [self.view addSubview:_detailScrollView];
        [_detailScrollView creatImageScroll: [[[[arrayChildrenList objectAtIndex:index]objectForKey:@"children"] objectAtIndex:0] objectForKey:@"pictures"]];
    }
    else{
        _rightMenu.hidden = YES;
        if ([[[arrayChildrenList objectAtIndex:index] objectForKey:@"name"]isEqualToString:@"自主选择时间分配"]||[[[arrayChildrenList objectAtIndex:index] objectForKey:@"name"]isEqualToString:@"时间自主"]) {
            [_detailScrollView removeFromSuperview];
            [self.view addSubview:_timeView];
            
        }
        else {
            
            
            
            
            [_timeView removeFromSuperview];
            [self.view addSubview:_detailScrollView];
//            if ([[[arrayChildrenList objectAtIndex:index] objectForKey:@"name"]isEqualToString:@"收入水平"]) {
//                [_detailScrollView creatImageScroll:[[NSArray alloc]init]];
//            }
//            else{
            [_detailScrollView creatImageScroll:[[arrayChildrenList objectAtIndex:index] objectForKey:@"pictures"]];
            //}
            
        }
        
        
    }
    
    
    
    
    
    
}
-(void)RightMenuClickAction:(NSInteger)index
{
    int num = 0;
    for (int i = 0; i < arrayChildrenList.count; i++) {
        if ([[[arrayChildrenList objectAtIndex:i] objectForKey:@"name"] isEqualToString:@"专业培训"]) {
            num = i;
        }
    }
    
    [_detailScrollView creatImageScroll: [[[[arrayChildrenList objectAtIndex:num]objectForKey:@"children"] objectAtIndex:index] objectForKey:@"pictures"]];
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
