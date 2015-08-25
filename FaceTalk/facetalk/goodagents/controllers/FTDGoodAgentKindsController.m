//
//  FTDGoodAgentKindsController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/22.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDGoodAgentKindsController.h"
#import "FTDAgentListCell.h"
#import "FTDGoodAgentDetailController.h"
#import "TFWHelpResultMenuView.h"
#import "FTJsonManager.h"
#import "FTJsonExcellentModel.h"
#import "FTJsonSubClassModel.h"
@interface FTDGoodAgentKindsController ()
@property (nonatomic,strong)FTJsonExcellentModel *model;
@property (nonatomic,strong) TFWHelpResultMenuView *menu;

@end

@implementation FTDGoodAgentKindsController
@synthesize tableKind;
- (void)viewDidLoad {
    [super viewDidLoad];
    tableKind.separatorColor=[UIColor clearColor];
    tableKind.contentInset=UIEdgeInsetsMake(100, 0, 0, 0);
    tableKind.backgroundColor=[UIColor colorWithRed:0.82 green:0.1 blue:0.28 alpha:1];
    [self getClassModel];
    [self CreatMoviePlayer];
    [self  buildMenu];
    // Do any additional setup after loading the view from its nib.
}

-(void)getClassModel
{
     self.model=[[FTJsonManager shareManager]getElementItemAtIndex:self.index];
    self.lblTitle.text=self.model.name;
}





-(void)CreatMoviePlayer
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test_movie" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:file];
    
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    moviePlayer.repeatMode = MPMovieRepeatModeOne;
    [moviePlayer setFullscreen:YES animated:YES];
    moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    moviePlayer.view.frame=CGRectMake(106, 134, 338, 250);
    [self.view addSubview:moviePlayer.view];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [moviePlayer play];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [moviePlayer stop];
}
-(void)buildMenu
{
    _menu=[TFWHelpResultMenuView createMenuwithArray:@[@"企业单位",@"事业单位",@"自由职业"] andBottom:CGPointMake(76, 730) andHightBtnIndex:self.index];
    //_menu = [TFWHelpResultMenuView createMenuwithArray:@[@"企业单位",@"事业单位",@"自由职业"] andBottom:CGPointMake(76, 730)];
    __weak FTDGoodAgentKindsController *weakSelf = self;
    [_menu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_menu];
}
-(void)menuClickAction:(NSInteger)index
{
    NSLog(@"index : %ld",(long)index);
    self.model=[[FTJsonManager shareManager]getElementItemAtIndex:index];
    self.lblTitle.text=self.model.name;
    [tableKind reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.model.subClass_count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView
    //                             dequeueReusableCellWithIdentifier:@"Cell"];
    static NSString *CellIdentifier = @"FTDAgentListCellIdentifier";
    FTDAgentListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FTDAgentListCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor colorWithRed:0.82 green:0.1 blue:0.28 alpha:1];
        
    }
    FTJsonSubClassModel *subclassModel=[self.model.subClassArray objectAtIndex:indexPath.row];
    cell.lblKindName.text=subclassModel.name;
    cell.imgKind.image=[UIImage imageWithContentsOfFile:subclassModel.icon];
//    switch (indexPath.row) {
//        case 0:
//            cell.imgKind.image=[UIImage imageNamed:@"FTD_ownWork.png"];
//            cell.lblKindName.text=@"自主创业";
//            break;
//        case 1:
//            cell.imgKind.image=[UIImage imageNamed:@"FTD_NewGraduates.png"];
//            cell.lblKindName.text=@"应届毕业生";
//            break;
//        case 2:
//            cell.imgKind.image=[UIImage imageNamed:@"FTD_HomeWoman.png"];
//            cell.lblKindName.text=@"家庭主妇";
//            break;
//        case 3:
//            cell.imgKind.image=[UIImage imageNamed:@"FTD_Other.png"];
//            cell.lblKindName.text=@"其他";
//            break;
//        default:
//            break;
//    }
    
    
    
    // Configure the cell...
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 176;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    FTDGoodAgentDetailController *vc=[[FTDGoodAgentDetailController alloc]init];
    vc.indexID=indexPath.row;
    vc.arraySubclass=[[NSArray alloc]initWithArray:self.model.subClassArray];
    vc.ExcellentModel=self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
