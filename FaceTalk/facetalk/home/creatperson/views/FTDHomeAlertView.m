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
    self.strState = @"0";
    self.lblReminder.hidden = YES;
    arrayList = [[NSMutableArray alloc]init];
    talentDic = [[NSMutableDictionary alloc]init];
//agentModel=[[FTDCustomerModel alloc]init];
    self.backgroundColor = [UIColor clearColor];
    [self.viewBG.layer setMasksToBounds:YES];
    [self.viewBG.layer setCornerRadius:5];
    
    textName.delegate = self;
    textBirthday.delegate = self;
    textSex.delegate = self;
    [textName addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventAllEditingEvents];
    
//    [textBirthday addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventAllEditingEvents];
//    [textSex addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventAllEditingEvents];
    
    [self initTable];
    [self initPick];
    
}
-(void)drawRect:(CGRect)rect
{
    [textSex addObserver:self forKeyPath:@"text" options:0 context:nil];
    [textBirthday addObserver:self forKeyPath:@"text" options:0 context:nil];
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

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == textSex) {
        if ([textSex.text isEqualToString:@"男"]) {
            //choosePerson.sex = @1;
            [talentDic setObject:@"1" forKey:@"sex"];
        }
        else{
            [talentDic setObject:@"2" forKey:@"sex"];
        }
        NSLog(@"haha");
    }
    else if (object == textBirthday)
    {
        if (textBirthday.text.length > 0) {
            [talentDic setObject:[FTDChangeDate dateFromString:textBirthday.text] forKey:@"birthday"];
        }
        NSLog(@"birthday");
    }
    
    if ([[talentDic objectForKey:@"name"]length] > 0 && [[talentDic objectForKey:@"sex"]length] > 0 && [talentDic objectForKey:@"birthday"]!= nil) {
        [self checkTalent];
    }
}
- (void)textchange:(UITextField *)textField
{
    if (textField == textName) {
        if (textField.text.length > 0) {
            [talentDic setObject:textName.text forKey:@"name"];
            [self searchAgentList:textName.text];
        }
        else{
            tableName.hidden = YES;
            [arrayList removeAllObjects];
            [tableName reloadData];
        }
    }
    if ([[talentDic objectForKey:@"name"]length] > 0 && [[talentDic objectForKey:@"sex"]length] > 0 && [talentDic objectForKey:@"birthday"]!= nil) {
         [self checkTalent];
    }
    
    
}

-(void)checkTalent
{
   self.strState = [FTDDBManager localDBisContainTalent:talentDic];
    
    if ([self.strState isEqualToString:@"0"]) {
        self.lblReminder.hidden = YES;
    }
    else if ([self.strState isEqualToString:@"1"])
    {
        //1是有人才没报告
         self.lblReminder.hidden = NO;
        self.lblReminder.text = @"人才库已包含该人才，但未生成报告";
    }
    else if ([self.strState isEqualToString:@"2"])
    {
         self.lblReminder.hidden = NO;
        self.lblReminder.text = @"该人才已经生成过报告";
    }
    
    
}
-(void)searchAgentList:(NSString *)agentName//fix me 此处调用本地数据库查询接口
{
    [arrayList removeAllObjects];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS %@",agentName];//模糊查询本地数据库
    arrayList = [NSMutableArray arrayWithArray:[FTDDBManager searchLocalDBWithKeys:pred]];//这里调查询数据库接口
    
    if (arrayList.count > 0) {
        tableName.hidden = NO;
        [tableName reloadData];
    }
    else{
        textBirthday.enabled = YES;
        tableName.hidden = YES;
        
    }
}

-(void)addAgent:(NSDictionary *)personmodel//fix me 此处调用本地数据库新增人才接口
{
    
    [FTDDBManager LocalAddToDB:personmodel];//这里创建用户
    
    if ([self.delegate respondsToSelector:@selector(homeAlertCreatclick)]) {
//        [textSex removeObserver:self forKeyPath:@"text" context:nil];
//        [textBirthday removeObserver:self forKeyPath:@"text" context:nil];
        [self.delegate homeAlertCreatclick];
    }
}

-(void)datechange
{
    selectedDate = [self.datePick date];
    textBirthday.text = [FTDChangeDate dateStr:selectedDate];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    
//    [formatter setTimeZone:timeZone];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
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
//        [textSex removeObserver:self forKeyPath:@"text" context:nil];
//        [textBirthday removeObserver:self forKeyPath:@"text" context:nil];
        [self.delegate homeAlertCancelClick];
    }
}

- (IBAction)creatclick:(id)sender {
    if (textName.text.length>0&&textSex.text.length>0&&textBirthday.text.length>0) {
        if ([self.strState isEqualToString:@"0"]) {

            NSDate *senddate = [NSDate date];
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
            NSString *  locationString = [dateformatter stringFromDate:senddate];
            
            NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc] init];
            [dateformatter1 setDateFormat:@"YYYY-MM-dd"];
            NSDate *destDate = [dateformatter1 dateFromString:locationString];
            [talentDic setObject:destDate forKey:@"chattime"];
            
            [talentDic setObject:[FTDCreatIDManager creatTalentId] forKey:@"personid"];
            set_sp(@"DTALENTINFO", talentDic);
            [self addAgent:talentDic];
            
//            if () {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"本地人才库已经包含该人才，不能重复创建！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                [alert show];
//            }
//            else{
            
//            }
            
//            choosePerson.birthday = textBirthday.text;
//            choosePerson.personid = [FTDCreatIDManager creatTalentId];
            
//            agentModel.name=textName.text;
//            agentModel.sex=textSex.text;
//            agentModel.birthday=textBirthday.text;
//            agentModel.userid=nil;
           
        }
        else if ([self.strState isEqualToString:@"1"])
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:choosePerson.name forKey:@"name"];
            [dic setObject:choosePerson.personid forKey:@"personid"];
            NSDictionary *dic1 = [[NSDictionary alloc]initWithDictionary:dic];
            set_sp(@"DTALENTINFO", dic1);
            
            
            
            if ([self.delegate respondsToSelector:@selector(homeAlertCreatclick)]) {
//                [textSex removeObserver:self forKeyPath:@"text" context:nil];
//                [textBirthday removeObserver:self forKeyPath:@"text" context:nil];
                [self.delegate homeAlertCreatclick];
            }
        }
        else if ([self.strState isEqualToString:@"2"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"已生成职业评估报告" delegate:self cancelButtonTitle:@"取消操作" otherButtonTitles:@"再做一次", nil];
            [alert show];
        }
        
        
        
    }
    else{
        return;
    }
    
    
}

- (IBAction)showSexListClick:(id)sender {
    
    if (tableSex.hidden==YES) {
        tableSex.hidden=NO;
    }
    else{
        tableSex.hidden=YES;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
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
        //isNewTalent = NO;
        
        choosePerson = [arrayList objectAtIndex:indexPath.row];
        
        textName.text=choosePerson.name;
         [talentDic setObject:textName.text forKey:@"name"];
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
-(void)dealloc{
    [textSex removeObserver:self forKeyPath:@"text" context:nil];
    [textBirthday removeObserver:self forKeyPath:@"text" context:nil];
}

@end
