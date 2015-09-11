//
//  FTDGoodAgentDetailController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/28.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDGoodAgentDetailController.h"
#import "FTDAgentImageCell.h"
#import "FTDAgentDetailScoreView.h"
#import "TFWHelpResultMenuView.h"
#import "FTJsonMarkModel.h"
@interface FTDGoodAgentDetailController ()
@property(nonatomic,strong)FTJsonPeopleModel *PeopleModel;
@property(nonatomic,strong)FTJsonSubClassModel *subclassModel;
@property(nonatomic,strong)NSArray *arrayPeople;
@property (nonatomic,strong) TFWHelpResultMenuView *menu;
@end

@implementation FTDGoodAgentDetailController
@synthesize tableAgentList,arraySubclass,indexID;
- (void)viewDidLoad {
    [super viewDidLoad];
    indexid=0;
    tableAgentList.separatorColor=[UIColor clearColor];
    tableAgentList.contentInset=UIEdgeInsetsMake(100, 0, 0, 0);
    NSLog(@"%@",arraySubclass);
    [self.imgBigPhoto.layer setMasksToBounds:YES];
    self.imgBigPhoto.contentMode=UIViewContentModeScaleAspectFit;
    [self getdata];
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)getdata
{
    [self buildMenu];
    _subclassModel=[_ExcellentModel getSubClassItemAtIndex:indexID];
    self.lblTitle.text=_subclassModel.name;
    _PeopleModel=[_subclassModel getPeoplesItemAtIndex:0];
    [self getdetailData];
    //[self buildScoreView];
    
}
-(void)getdetailData
{
    _lblName.text=_PeopleModel.name;
    _lblOldJob.text=[NSString stringWithFormat:@"入司前职业:%@", _PeopleModel.old_job];
    _lblTime.text= [NSString stringWithFormat:@"入司时间:%@", _PeopleModel.join_date];
    _lblDesc.text=_PeopleModel.share_word;
    _imgBigPhoto.image=[UIImage imageWithContentsOfFile:_PeopleModel.picture];
    [self buildScoreView];
}




-(void)buildScoreView
{    for(id tmpView in [self.view subviews])
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[FTDAgentDetailScoreView class]])
        {
            FTDAgentDetailScoreView *imgView = (FTDAgentDetailScoreView *)tmpView;
            
                [imgView removeFromSuperview];
                  
            
        }
    }
    NSLog(@"%@",self.view.subviews);
    for (int i=0; i<5; i++) {
        FTDAgentDetailScoreView *ScoreView=[FTDAgentDetailScoreView setCustomview];
        FTJsonMarkModel *oldMarkModel=[_PeopleModel.old_mark objectAtIndex:i];
        FTJsonMarkModel *newMarkModel=[_PeopleModel.markArray objectAtIndex:i];
        [ScoreView setTitle:newMarkModel.name andOldScore:oldMarkModel.mark andNewScore:newMarkModel.mark andDesc:@"营销员本身就是做自己的事业，加上公司的奖金津贴制度，还有产品设计，服务口碑等，都是丰厚收入的基础！"];
        ScoreView.frame=CGRectMake(510, 137+112*i, 340, 110);
        [self.view addSubview:ScoreView];
    }
}

-(void)buildMenu
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int i=0; i<arraySubclass.count; i++) {
        FTJsonSubClassModel *model=[arraySubclass objectAtIndex:i];
        [array addObject:model.name];
    }
    
    
    _menu = [TFWHelpResultMenuView createMenuwithArray:array andBottom:CGPointMake(76, 730) andHightBtnIndex:indexID];
    __weak FTDGoodAgentDetailController *weakSelf = self;
    [_menu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_menu];
}
-(void)menuClickAction:(NSInteger)index
{
    NSLog(@"index : %ld",(long)index);
    _subclassModel=[_ExcellentModel getSubClassItemAtIndex:index];
    
    _PeopleModel=[_subclassModel getPeoplesItemAtIndex:0];
    indexid=0;
    self.lblTitle.text=_subclassModel.name;
    [self getdetailData];
    [tableAgentList reloadData];
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
    return _subclassModel.peoples.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView
    //                             dequeueReusableCellWithIdentifier:@"Cell"];
    static NSString *CellIdentifier = @"FTDAgentImageCellIdentifier";
    FTDAgentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FTDAgentImageCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor colorWithRed:0.82 green:0.1 blue:0.28 alpha:1];
        
    }
    FTJsonPeopleModel *cellModel=[_subclassModel.peoples objectAtIndex:indexPath.row];
    cell.imgAgent.image=[UIImage imageWithContentsOfFile:cellModel.picture];
    [cell.imgAgent.layer setMasksToBounds:YES];
    cell.imgAgent.contentMode=UIViewContentModeScaleAspectFit;
    cell.lblName.text=cellModel.name;
    cell.lblCareer.text=cellModel.old_job;
    
    if (indexPath.row==indexid) {
        cell.imgBG.hidden=YES;
        cell.lblCareer.hidden=YES;
        cell.lblName.hidden=YES;
    }
    else{
        cell.imgBG.hidden=NO;
        cell.lblCareer.hidden=NO;
        cell.lblName.hidden=NO;
    }
    
    
    
    // Configure the cell...
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _PeopleModel=[_subclassModel getPeoplesItemAtIndex:indexPath.row];
    [self getdetailData];
    indexid=indexPath.row;
    [tableAgentList reloadData];
    
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
