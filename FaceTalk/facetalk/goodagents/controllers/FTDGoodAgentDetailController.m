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
@interface FTDGoodAgentDetailController ()
@property (nonatomic,strong) TFWHelpResultMenuView *menu;
@end

@implementation FTDGoodAgentDetailController
@synthesize tableAgentList;
- (void)viewDidLoad {
    [super viewDidLoad];
    indexid=1000000;
    tableAgentList.separatorColor=[UIColor clearColor];
    tableAgentList.contentInset=UIEdgeInsetsMake(100, 0, 0, 0);
    [self buildScoreView];
    [self buildMenu];
    // Do any additional setup after loading the view from its nib.
}
-(void)buildScoreView
{
    for (int i=0; i<5; i++) {
        FTDAgentDetailScoreView *ScoreView=[FTDAgentDetailScoreView setCustomview];
        [ScoreView setTitle:@"丰厚收入" andOldScore:i+1 andNewScore:i+3 andDesc:@"丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入丰厚收入"];
        ScoreView.frame=CGRectMake(510, 137+112*i, 340, 110);
        [self.view addSubview:ScoreView];
    }
}

-(void)buildMenu
{
    _menu = [TFWHelpResultMenuView createMenuwithArray:@[@"自由职业",@"应届毕业生",@"家庭主妇",@"其他"] andBottom:CGPointMake(76, 730)];
    __weak FTDGoodAgentDetailController *weakSelf = self;
    [_menu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_menu];
}
-(void)menuClickAction:(NSInteger)index
{
    NSLog(@"index : %ld",(long)index);
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
    return 9;
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
