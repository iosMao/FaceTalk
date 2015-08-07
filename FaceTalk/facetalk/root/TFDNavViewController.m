//
//  TFDNavViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/27.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFDNavViewController.h"
#import "FTDNavTableCell.h"
@interface TFDNavViewController ()

@end

@implementation TFDNavViewController
@synthesize tableMenu,btnSlider,btnScreen,btnRightMenu,viewRightMenu;
- (void)viewDidLoad {
    [super viewDidLoad];
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
        UIButton *btnMenu=[[UIButton alloc]initWithFrame:CGRectMake(100+i*(90/1.8),0,90/1.8,100/1.8)];
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
        [btnMenu addTarget:self action:@selector(hiddenRightMenu) forControlEvents:UIControlEventTouchUpInside];
        [viewRightMenu addSubview:btnMenu];
    }
    
    
    
    
    
    
    
    
    
    
     viewRightMenu.hidden=YES;
    
}

-(void)buildSliderTable
{
    tableMenu=[[UITableView alloc]initWithFrame:CGRectMake(-120, 20, 120, self.view.frame.size.height)];
    tableMenu.delegate=self;
    tableMenu.dataSource=self;
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
    return 5;
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
    NSString *strImg=[NSString stringWithFormat:@"FTD_slider_image%ld.png",(long)indexPath.row];
    cell.imgIcon.image=[UIImage imageNamed:strImg];
    
    switch (indexPath.row) {
        case 0:
            cell.lblTitle.text=@"职涯演示";
            break;
        case 1:
            cell.lblTitle.text=@"培训导航";
            break;
        case 2:
            cell.lblTitle.text=@"收入试算";
            break;
        case 3:
            cell.lblTitle.text=@"营销员的一天";
            break;
        case 4:
            cell.lblTitle.text=@"EOP报名";
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
