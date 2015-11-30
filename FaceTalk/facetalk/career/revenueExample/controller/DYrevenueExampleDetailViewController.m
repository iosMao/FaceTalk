//
//  DYrevenueExampleDetailViewController.m
//  FaceTalk
//
//  Created by niehonglei on 15/11/11.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "DYrevenueExampleDetailViewController.h"
#import "FTDRightMenuView.h"

@interface DYrevenueExampleDetailViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageC;
@property (weak, nonatomic) IBOutlet UILabel *lblJoin;

@property(strong, nonatomic) UILabel *titleLabel;
@property (nonatomic,strong) FTDRightMenuView *rightMenu;

@end

@implementation DYrevenueExampleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, 0);
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.scrollView.delegate = self;
    
    self.lblJoin.backgroundColor = [UIColor colorWithRed:199/255.0 green:0 blue:53/255.0 alpha:1];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.lblJoin.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.lblJoin.bounds;
    maskLayer.path = maskPath.CGPath;
    self.lblJoin.layer.mask = maskLayer;
    
    [self buildTitleLabel];
    [self buildBackButton];
    [self buildRightMenu];
    
    [self menuClickAction:self.index];
}

-(void)buildRightMenu
{
    _rightMenu = [FTDRightMenuView createMenuwithArray:@[@"业务经理", @"业务总监", @"销售经理"] andBottom:CGPointMake(1000, 745) andHightBtnIndex:(int)self.index];
    __weak DYrevenueExampleDetailViewController *weakSelf = self;
    [_rightMenu setRightMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_rightMenu];
    
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

-(void)menuClickAction:(NSInteger)index
{
    UIImageView *img1 = [[UIImageView alloc] init];
    UIImageView *img2 = [[UIImageView alloc] init];
    img1.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    img2.frame = CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    if (index == 0) {
        NSString *str = [NSString stringWithFormat:@"dySellManageLiu.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgView.image = img;
        
        img1.image = [UIImage imageNamed:@"dySelllb"];
        img2.image = [UIImage imageNamed:@"dySellla"];
    } else if (index == 1) {
        NSString *str = [NSString stringWithFormat:@"dySellManageXu.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgView.image = img;
        
        img1.image = [UIImage imageNamed:@"dySellxb"];
        img2.image = [UIImage imageNamed:@"dySellxa"];
    } else if (index == 2) {
        NSString *str = [NSString stringWithFormat:@"dySellManageGao.png"];
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        self.imgView.image = img;
        
        img1.image = [UIImage imageNamed:@"dySellgb"];
        img2.image = [UIImage imageNamed:@"dySellga"];
    }
    
    [self.scrollView addSubview:img1];
    [self.scrollView addSubview:img2];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pianyi = scrollView.contentOffset.x;
    CGFloat yige = self.scrollView.frame.size.width;
    int page = pianyi / yige + 0.5;
    
    if (page == 0) {
        self.lblJoin.text = @"入司前";
    } else if (page == 1) {
        self.lblJoin.text = @"入司后";
    }
    
    self.pageC.currentPage = page;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
