//
//  FTDGoodAgentKindsController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/22.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDGoodAgentKindsController.h"
#import "FTDAgentListCell.h"
@interface FTDGoodAgentKindsController ()

@end

@implementation FTDGoodAgentKindsController
@synthesize tableKind;
- (void)viewDidLoad {
    [super viewDidLoad];
    tableKind.separatorColor=[UIColor clearColor];
    tableKind.backgroundColor=[UIColor colorWithRed:0.82 green:0.1 blue:0.28 alpha:1];
    [self CreatMoviePlayer];
    // Do any additional setup after loading the view from its nib.
}
-(void)CreatMoviePlayer
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test_movie" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:file];
    
    MoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    MoviePlayer.controlStyle = MPMovieControlStyleDefault;
    MoviePlayer.shouldAutoplay = YES;
    MoviePlayer.repeatMode = MPMovieRepeatModeOne;
    [MoviePlayer setFullscreen:YES animated:YES];
    MoviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    MoviePlayer.view.frame=CGRectMake(106, 134, 338, 250);
    [self.view addSubview:MoviePlayer.view];
    [MoviePlayer play];
    
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
    return 4;
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
    switch (indexPath.row) {
        case 0:
            cell.imgKind.image=[UIImage imageNamed:@"FTD_ownWork.png"];
            cell.lblKindName.text=@"自主创业";
            break;
        case 1:
            cell.imgKind.image=[UIImage imageNamed:@"FTD_NewGraduates.png"];
            cell.lblKindName.text=@"应届毕业生";
            break;
        case 2:
            cell.imgKind.image=[UIImage imageNamed:@"FTD_HomeWoman.png"];
            cell.lblKindName.text=@"家庭主妇";
            break;
        case 3:
            cell.imgKind.image=[UIImage imageNamed:@"FTD_Other.png"];
            cell.lblKindName.text=@"其他";
            break;
        default:
            break;
    }
    
    
    
    // Configure the cell...
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 176;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
