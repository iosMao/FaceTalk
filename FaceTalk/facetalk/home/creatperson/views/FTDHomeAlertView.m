//
//  FTDHomeAlertView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeAlertView.h"
#import "FTDDBManager.h"
#import "FTDNameCell.h"
#import "FTDCreatIDManager.h"
#import "FTDChangeDate.h"
#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
@implementation FTDHomeAlertView
@synthesize tableName,tableSex,textBirthday,textName,textSex;

+(FTDHomeAlertView *)initCustomview
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FTDHomeAlertView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}

-(void)awakeFromNib
{
    isLock=YES;
    
//agentModel=[[FTDCustomerModel alloc]init];
    self.backgroundColor=[UIColor clearColor];
    [self.viewBG.layer setMasksToBounds:YES];
    [self.viewBG.layer setCornerRadius:5];
    arrayList=[[NSMutableArray alloc]init];
    textName.delegate=self;
    [textName addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventEditingChanged];
    
    [self initTable];
    [self initPick];
    
}
-(void)initTable
{
    tableName.delegate = self;
    tableName.dataSource = self;
    tableName.hidden = YES;
    
    tableSex.delegate = self;
    tableSex.dataSource = self;
    [tableSex reloadData];
    tableSex.hidden = YES;
}
-(void)initPick
{
    self.viewPick.center = CGPointMake(self.center.x, self.center.y+200);
    self.viewPick.hidden = YES;
    [self.datePick addTarget:self action:@selector(datechange) forControlEvents:UIControlEventValueChanged];
    [self.textBirthday setInputView:self.datePick];
    //[self addSubview:self.viewPick];
}

- (void)textchange:(UITextField *)textField
{
    if (textField.text.length > 0) {
        [self searchAgentList:textField.text];
    }
    else{
        tableName.hidden = YES;
        [arrayList removeAllObjects];
        [tableName reloadData];
    }
    
}
//////////////////////////以下两个由quix提供
//-(NSArray *)searchContactWithKeywords:(NSString *)keywords
//{
//    
//}
//
-(void)createContact:(NSDictionary *)person
{
    [FTDDBManager LocalAddToDB:person];
}
//-(void)saveLocalDBData//QUIX的保存数据库接口
//{
//    
//}
//////////////////////////



-(void)searchAgentList:(NSString *)agentName//fix me 此处调用本地数据库查询接口
{
    [arrayList removeAllObjects];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS %@",agentName];//模糊查询本地数据库
      arrayList = [NSMutableArray arrayWithArray:[FTDDBManager searchLocalDBWithKeys:pred]];//这里调查询数据库接口
    
    if (arrayList.count > 0) {
        tableName.hidden = NO;
        isLock = YES;
        textBirthday.enabled = NO;
        [tableName reloadData];
    }
    else{
        textBirthday.enabled = YES;
        tableName.hidden = YES;
        isLock = NO;
    }
}

-(void)addAgent:(NSDictionary *)personmodel//fix me 此处调用本地数据库新增人才接口
{
    
    [self createContact:personmodel];//这里创建用户
    
    if ([self.delegate respondsToSelector:@selector(homeAlertCreatclick)]) {
        [self.delegate homeAlertCreatclick];
    }
}

-(void)datechange
{
    selectedDate = [self.datePick date];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    
//    [formatter setTimeZone:timeZone];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    
    textBirthday.text = [FTDChangeDate dateStr:selectedDate];
}

#pragma mark tableviewdelegate
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
    if (tableView == tableSex) {
        return 2;
    }
    return arrayList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableName) {
        static NSString *CellIdentifier = @"FTDNameCellIdentifier";
        FTDNameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FTDNameCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            //cell.backgroundColor=[UIColor colorWithRed:0.82 green:0.1 blue:0.28 alpha:1];
            
        }
        Person *person = [arrayList objectAtIndex:indexPath.row];
        
        
        cell.lblName.text = person.name;
        if ([person.sex isEqualToNumber:@1]) {
            cell.lblsex.text = @"男";
        }
        else{
            cell.lblsex.text = @"女";
        }
        
        cell.lblBirthday.text = [FTDChangeDate dateStr:person.birthday];
        
        
        return cell;
    }
    else if (tableView == tableSex)
    {
        static NSString *identifier = @"tableSexIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            
        }
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"男";
        }
        else{
            cell.textLabel.text = @"女";
        }
        
        
        
        // Configure the cell...
        return cell;
    }
    return nil;
    
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
    if (tableView==tableName) {
        choosePerson = [arrayList objectAtIndex:indexPath.row];
        
        textName.text=choosePerson.name;
        if ([choosePerson.sex isEqualToNumber:@1]) {
            textSex.text=@"男";
        }
        else{
            textSex.text=@"女";
        }
        
        textBirthday.text= [FTDChangeDate  dateStr:choosePerson.birthday];
        
        tableName.hidden=YES;
    }
    else if (tableView==tableSex)
    {
        if (indexPath.row==0) {
            textSex.text=@"男";
        }
        else{
            textSex.text=@"女";
        }
        tableSex.hidden=YES;
        
        
        
    }
    
    
}
#pragma mark FTDHomeAlertdelegate
//- (IBAction)showBirthdayPickClick:(id)sender {
//    if (isLock) {
//        return;
//    }
//    
//    //[self.delegate showDatePicker];
//    
//    if (self.viewPick.hidden==YES) {
//         self.viewPick.hidden=NO;
//    }else{
//         self.viewPick.hidden=YES;
//    }
//   
//}

- (IBAction)cancelclick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(homeAlertCancelClick)]) {
        [self.delegate homeAlertCancelClick];
    }
}

- (IBAction)creatclick:(id)sender {
    if (textName.text.length>0&&textSex.text.length>0&&textBirthday.text.length>0) {
        if (arrayList.count==0) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:textName.text forKey:@"name"];
            
            //choosePerson.name = textName.text;
            if ([textSex.text isEqualToString:@"男"]) {
                choosePerson.sex = @1;
                [dic setObject:@"1" forKey:@"sex"];
            }
            else{
                [dic setObject:@"2" forKey:@"sex"];
            }
            NSDate *senddate = [NSDate date];
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
            NSString *  locationString = [dateformatter stringFromDate:senddate];
            NSLog(@"locationString:%@",locationString);
            NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc] init];
            [dateformatter1 setDateFormat:@"YYYY-MM-dd"];
            NSDate *destDate = [dateformatter1 dateFromString:locationString];
            [dic setObject:destDate forKey:@"chattime"];
            [dic setObject:selectedDate forKey:@"birthday"];
            [dic setObject:[FTDCreatIDManager creatTalentId] forKey:@"personid"];
            set_sp(@"DTALENTINFO", dic);
            [self addAgent:dic];
//            choosePerson.birthday = textBirthday.text;
//            choosePerson.personid = [FTDCreatIDManager creatTalentId];
            
//            agentModel.name=textName.text;
//            agentModel.sex=textSex.text;
//            agentModel.birthday=textBirthday.text;
//            agentModel.userid=nil;
           
        }
        else
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:choosePerson.name forKey:@"name"];
            [dic setObject:choosePerson.personid forKey:@"personid"];
            NSDictionary *dic1 = [[NSDictionary alloc]initWithDictionary:dic];
            set_sp(@"DTALENTINFO", dic1);
            
            
            
            if ([self.delegate respondsToSelector:@selector(homeAlertCreatclick)]) {
                [self.delegate homeAlertCreatclick];
            }
        }
        
        
        
    }
    else{
        return;
    }
    
    
}

- (IBAction)showSexListClick:(id)sender {
    if (isLock) {
        return;
    }
    if (tableSex.hidden==YES) {
        tableSex.hidden=NO;
    }
    else{
        tableSex.hidden=YES;
    }
}



@end
