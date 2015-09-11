//
//  TFDNavViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/27.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFDNavViewController.h"
#import "FTDNavTableCell.h"
#import "TFWRealOrderViewController.h"
#import "FTDGoodAgentHomeController.h"
#import "TFWRealHelpViewController.h"
#import "FTDPersonTController.h"
#import "TFWReportViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "FTWDataManager.h"
#import "TFWOrderModel.h"
#import "TFWCustomTalkViewController.h"
@interface TFDNavViewController ()

@end

@implementation TFDNavViewController
@synthesize tableMenu,btnSlider,btnScreen,btnRightMenu,viewRightMenu;
- (void)viewDidLoad {
    [super viewDidLoad];
    indexID=10000;
    [self buildSliderBtn];
    [self buildSliderTable];
    [self buildRightBtn];
    [self buildRightViewMenu];
    
    [self.view insertSubview:btnSlider atIndex:10000];
    [self.view insertSubview:tableMenu atIndex:10001];
    [self.view insertSubview:btnScreen atIndex:10002];
    [self.view insertSubview:btnRightMenu atIndex:10003];
    [self.view insertSubview:viewRightMenu atIndex:10004];
    // Do any additional setup after loading the view.
    
    
}
-(void)buildRightBtn
{
    btnRightMenu=[[UIButton alloc]initWithFrame:CGRectMake(1024-249/1.8, 70, 249/1.8, 109/1.8)];
    [btnRightMenu setImage:[UIImage imageNamed:@"FTD_shortBG.png"] forState:UIControlStateNormal];
    [btnRightMenu addTarget:self action:@selector(showRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)buildRightViewMenu
{
    viewRightMenu=[[UIView alloc]initWithFrame:CGRectMake(1024-249/1.8, 70, 653/1.8, 109/1.8)];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 653/1.8, 109/1.8)];
    imageView.image=[UIImage imageNamed:@"FTD_longBG.png"];
    [viewRightMenu addSubview:imageView];
   
    UIButton *btnHidden=[[UIButton alloc]initWithFrame:CGRectMake(0,0,100,109/1.8)];
    [btnHidden addTarget:self action:@selector(hiddenRightMenu) forControlEvents:UIControlEventTouchUpInside];
    [viewRightMenu addSubview:btnHidden];
    
    for (int i=0; i<5; i++) {
        UIButton *btnMenu=[[UIButton alloc]initWithFrame:CGRectMake(100+i*(90/1.8),5,90/1.8,100/1.8)];
        btnMenu.tag=i+300;
        switch (i) {
            case 0:
                [btnMenu setImage:[UIImage imageNamed:@"FTD_creatreport.png"] forState:UIControlStateNormal];
                break;
            case 1:
                [btnMenu setImage:[UIImage imageNamed:@"FTD_firstpart.png"] forState:UIControlStateNormal];
                break;
            case 2:
                [btnMenu setImage:[UIImage imageNamed:@"FTD_secondpart.png"] forState:UIControlStateNormal];
                break;
            case 3:
                [btnMenu setImage:[UIImage imageNamed:@"FTD_thirdpart.png"] forState:UIControlStateNormal];
                break;
            case 4:
                [btnMenu setImage:[UIImage imageNamed:@"FTD_fourpart.png"] forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        [btnMenu addTarget:self action:@selector(Menuclick:) forControlEvents:UIControlEventTouchUpInside];
        [viewRightMenu addSubview:btnMenu];
    }
     viewRightMenu.hidden=YES;
    
}

-(void)buildSliderTable
{
    tableMenu=[[UITableView alloc]initWithFrame:CGRectMake(-120, 20, 120, self.view.frame.size.height)];
    tableMenu.delegate=self;
    tableMenu.dataSource=self;
    //tableMenu.scrollEnabled=NO;
    tableMenu.separatorColor=[UIColor clearColor];
    tableMenu.backgroundColor=[UIColor colorWithRed:0.72 green:0.01 blue:0.21 alpha:1];
    tableMenu.hidden=YES;
    //[self.view addSubview:tableMenu];
    
    UIView *viewBG=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
    viewBG.backgroundColor=[UIColor colorWithRed:0.72 green:0.01 blue:0.21 alpha:1];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(12.5, 0, 95, 120)];
    imageView.image=[UIImage imageNamed:@"FTD_slider_icon.png"];
    [viewBG addSubview:imageView];
    tableMenu.tableHeaderView=viewBG;
    
    btnScreen=[[UIButton alloc]initWithFrame:CGRectMake(120, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [btnScreen addTarget:self action:@selector(removetable) forControlEvents:UIControlEventTouchUpInside];
    btnScreen.backgroundColor=[UIColor clearColor];
    btnScreen.hidden=YES;
    
    
    
    
}
-(void)buildSliderBtn
{
    btnSlider=[[UIButton alloc]initWithFrame:CGRectMake(0,20,40,748)];
    [btnSlider setImage:[UIImage imageNamed:@"FTD_slider_btn.png"] forState:UIControlStateNormal];
    [btnSlider addTarget:self action:@selector(showtable) forControlEvents:UIControlEventTouchUpInside];
    btnSlider.backgroundColor=[UIColor clearColor];
    //[self.view addSubview:btnSlider];
}

-(void)Menuclick:(UIButton *)sender
{
    [self hiddenRightMenu];
    NSLog(@"%ld",sender.tag-300);
    NSString *classString = nil;
    if (sender.tag-300==0) {
        NSLog(@"UERdefaut%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"FTD_isFinishMark"]);
        
        if ( [[[NSUserDefaults standardUserDefaults]objectForKey:@"FTD_isFinishMark"]isEqualToString:@"0"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请完成“真选择成就事业”的评分！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
         
        TFWReportViewController *vc=[[TFWReportViewController alloc]init];
        [self setViewControllers:@[vc] animated:YES];
        NSLog(@"%@",self.viewControllers);
        classString = [TFWReportViewController description];
    }
    else if (sender.tag-300==1) {
        TFWRealOrderViewController *vc=[[TFWRealOrderViewController alloc]init];
        [self setViewControllers:@[vc] animated:YES];
        NSLog(@"%@",self.viewControllers);
        classString = [TFWRealOrderViewController description];
    }
    else if (sender.tag-300==2)
    {
        FTDGoodAgentHomeController *vc=[[FTDGoodAgentHomeController alloc]init];
         [self setViewControllers:@[vc] animated:YES];
        classString = [FTDGoodAgentHomeController description];
    }
    else if (sender.tag-300==3)
    {
        TFWRealHelpViewController *vc=[[TFWRealHelpViewController alloc]init];
         [self setViewControllers:@[vc] animated:YES];
        classString = [TFWRealHelpViewController description];
    }
    else if (sender.tag-300==4)
    {
        FTDPersonTController *vc=[[FTDPersonTController alloc]init];
        [self setViewControllers:@[vc] animated:YES];
        classString = [FTDPersonTController description];

    }
    NSInteger index = 0;
    for (NSString * item in [FTWDataManager shareManager].classArray) {
        if ([item isEqualToString:classString]) {
            break;
        }
        index++;
    }
    TFWOrderModel *model = [[FTWDataManager shareManager] selectOrder];
    if (index < 4) {
        if (index + 1 == model.first) {
            index = 0;
        }else if(index + 1 == model.second)
        {
            index = 1;
        }else if(index + 1 == model.third)
        {
            index = 2;
        }else if(index + 1 == model.fourth)
        {
            index = 3;
        }
        [FTWDataManager shareManager].currentIndex = index;
    }
    
}

-(void)showRightMenu
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        viewRightMenu.hidden=NO;
        viewRightMenu.frame= CGRectMake(1024-653/1.8, 70, 653/1.8, 109/1.8);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hiddenRightMenu
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        viewRightMenu.frame= CGRectMake(1024-249/1.8, 70, 653/1.8, 109/1.8);
    } completion:^(BOOL finished) {
        viewRightMenu.hidden=YES;
    }];

}

-(void)showtable
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        tableMenu.hidden=NO;
        tableMenu.frame=CGRectMake(0, 20, 120, self.view.frame.size.height);
 
        btnScreen.hidden=NO;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)removetable
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        tableMenu.frame=CGRectMake(-120, 20, 120, self.view.frame.size.height);
        btnScreen.hidden=YES;
        //btnSlider.frame = CGRectMake(120,20,50,748);
    } completion:^(BOOL finished) {
        tableMenu.hidden=YES;
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 6;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView
    //                             dequeueReusableCellWithIdentifier:@"Cell"];
    static NSString *CellIdentifier = @"FTDNavTableCellIdentifier";
    FTDNavTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FTDNavTableCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor colorWithRed:0.72 green:0.01 blue:0.21 alpha:1];
        
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.lblTitle.text=@"首页";
             cell.imgIcon.image=[UIImage imageNamed:@"FTD_slider_home.png"];
            break;
        case 1:
            cell.lblTitle.text=@"EOP报名";
            cell.imgIcon.image=[UIImage imageNamed:@"FTD_slider_image4.png"];
            
            break;
        case 2:
            cell.lblTitle.text=@"职涯演示";
            cell.imgIcon.image=[UIImage imageNamed:@"FTD_slider_image0.png"];
            break;
        case 3:
            cell.lblTitle.text=@"培训导航";
            cell.imgIcon.image=[UIImage imageNamed:@"FTD_slider_image1.png"];
            break;
        case 4:
            cell.lblTitle.text=@"测测跳槽成本";
            cell.imgIcon.image=[UIImage imageNamed:@"FTD_slider_image2.png"];
            break;
        case 5:
            cell.lblTitle.text=@"我的24小时";
            cell.imgIcon.image=[UIImage imageNamed:@"FTD_slider_image3.png"];
            break;
        default:
            break;
    }
    
    
    
    
    
    
    // Configure the cell...
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        [FTWDataManager shareManager].currentIndex=-1;
        [self popToRootViewControllerAnimated:NO];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        if (indexID==indexPath.row) {
            return;
        }
        else{
            if (indexPath.row==1)
            {
                NSLog(@"EOP报名");
            }
        }
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        TFWCustomTalkViewController *vc=[[TFWCustomTalkViewController
                                          alloc]init];
        [self pushViewController:vc animated:YES];
        [self removetable];
    }
    else{
        indexID=10000;
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
