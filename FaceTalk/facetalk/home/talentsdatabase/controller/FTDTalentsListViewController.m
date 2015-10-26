//
//  FTDTalentsListViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/20.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDTalentsListViewController.h"
#import "FTDTalentListCell.h"
@interface FTDTalentsListViewController ()
{
    BOOL isNameSearch;
}
@property (strong, nonatomic) IBOutlet UIView *viewListBG;
@property (strong, nonatomic) IBOutlet UITableView *tableList;
@property (strong, nonatomic) IBOutlet UIView *viewBG;
@property (strong, nonatomic) IBOutlet UIView *viewSearch;
@property (strong, nonatomic) IBOutlet UIButton *btnSearchTitle;
@property (strong, nonatomic) IBOutlet UITextField *textName;

@property (strong, nonatomic) IBOutlet UITextField *textBeginDate;
@property (strong, nonatomic) IBOutlet UITextField *textEndDate;

@property (strong, nonatomic) IBOutlet UIView *viewSearchClass;


@property (strong, nonatomic) IBOutlet UIDatePicker *datePickBegin;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickEnd;

- (IBAction)showSearchClass:(id)sender;

- (IBAction)backclick:(id)sender;
- (IBAction)nameclick:(id)sender;
- (IBAction)dateclick:(id)sender;
- (IBAction)searchclick:(id)sender;

@end

@implementation FTDTalentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableList.separatorColor = [UIColor clearColor];
    [self setviewRound];
    
    self.textBeginDate.hidden = YES;
    self.textEndDate.hidden = YES;
    [self buildDatePick];
    // Do any additional setup after loading the view from its nib.
}
-(void)setviewRound
{
    [self.viewListBG.layer setMasksToBounds:YES];
    [self.viewListBG.layer setCornerRadius:3.0];
    
    self.viewBG.backgroundColor = [UIColor whiteColor];
    self.viewBG.layer.shadowColor = [UIColor grayColor].CGColor;
    self.viewBG.layer.shadowOffset = CGSizeMake(4,4);
    self.viewBG.layer.shadowOpacity = 0.8;
    self.viewBG.layer.shadowRadius = 4;
    
    [self.viewSearch.layer setMasksToBounds:YES];
    [self.viewSearch.layer setCornerRadius:3.0];
    [self.viewSearch.layer setBorderWidth:0.5];
    [self.viewSearch.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    self.viewSearchClass.hidden = YES;
    [self.viewSearchClass.layer setBorderWidth:0.7];
    [self.viewSearchClass.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
}
-(void)buildDatePick
{
//    self.viewDatePick.center=CGPointMake(self.view., self.center.y+200);
//    self.viewPick.hidden=YES;
    [self.datePickBegin addTarget:self action:@selector(dateBeginChange) forControlEvents:UIControlEventValueChanged];
    [self.textBeginDate setInputView:self.datePickBegin];
    
    [self.datePickEnd addTarget:self action:@selector(dateEndChange) forControlEvents:UIControlEventValueChanged];
    [self.textEndDate setInputView:self.datePickEnd];
    //[self addSubview:self.viewPick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview datasource

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
    return 8;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView
    //                             dequeueReusableCellWithIdentifier:@"Cell"];
    static NSString *CellIdentifier = @"FTDTalentListCellCellIdentifier";
    FTDTalentListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FTDTalentListCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
    }
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    else{
        cell.backgroundColor = [UIColor colorWithRed:0.94 green:0.95 blue:0.96 alpha:1];
    }
    
    
    
    
    // Configure the cell...
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
-(void)dateBeginChange
{
    NSDate *selectedDate = [self.datePickBegin date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.textBeginDate.text=[formatter stringFromDate:selectedDate];
}
-(void)dateEndChange
{
    NSDate *selectedDate = [self.datePickEnd date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.textEndDate.text=[formatter stringFromDate:selectedDate];
}

- (IBAction)showSearchClass:(id)sender {
    self.viewSearchClass.hidden = NO;
}

- (IBAction)backclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nameclick:(id)sender {
    [self.btnSearchTitle setTitle:@"按名字查找" forState:UIControlStateNormal];
    self.viewSearchClass.hidden = YES;
    isNameSearch = YES;
    self.textName.hidden = NO;
    self.textBeginDate.hidden = YES;
    self.textEndDate.hidden = YES;
}

- (IBAction)dateclick:(id)sender {
    [self.btnSearchTitle setTitle:@"按日期查找" forState:UIControlStateNormal];
    self.viewSearchClass.hidden = YES;
    isNameSearch = NO;
    self.textName.hidden = YES;
    self.textBeginDate.hidden = NO;
    self.textEndDate.hidden = NO;
    
}

- (IBAction)searchclick:(id)sender {
    if (isNameSearch) {
        NSLog(@"按姓名查");
    }
    else{
        
        
        
        [self dateSearch];
        
        
        
        NSLog(@"按日期查");
        
        
        
    }
}
-(void)dateSearch
{
    NSDateFormatter *dateFormatterBegin = [[NSDateFormatter alloc] init];
    [dateFormatterBegin setDateFormat: @"yyyy-MM-dd"];
    NSDate *firstDate = [dateFormatterBegin dateFromString:self.textBeginDate.text];
    NSTimeInterval _fitstDate = [firstDate timeIntervalSince1970]*1;
    
    NSDateFormatter *dateFormatterEnd = [[NSDateFormatter alloc] init];
    
    [dateFormatterEnd setDateFormat: @"yyyy-MM-dd"];
    NSDate *endDate = [dateFormatterEnd dateFromString:self.textEndDate.text];
    
    
    NSTimeInterval _endDate = [endDate timeIntervalSince1970]*1;
    
    
    
    if (_fitstDate - _endDate > 0) {
        
        NSLog(@"第一个大");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"开始时间不能比结束时间大哦！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        
    }
    
    
    
}


@end
