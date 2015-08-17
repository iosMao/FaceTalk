//
//  FTDHomeAlertView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeAlertView.h"

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
    agentModel=[[FTDCustomerModel alloc]init];
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
    tableName.delegate=self;
    tableName.dataSource=self;
    tableName.hidden=YES;
    
    tableSex.delegate=self;
    tableSex.dataSource=self;
    [tableSex reloadData];
    tableSex.hidden=YES;
}
-(void)initPick
{
    self.viewPick.center=CGPointMake(self.center.x, self.center.y+200);
    self.viewPick.hidden=YES;
    [self.datePick addTarget:self action:@selector(datechange) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.viewPick];
}

- (void)textchange:(UITextField *)textField
{
    if (textField.text.length>0) {
        [self searchAgentList:textField.text];
    }
    else{
        [arrayList removeAllObjects];
        [tableName reloadData];
    }
    
}
//////////////////////////以下两个由quix提供
-(NSArray *)searchContactWithKeywords:(NSString *)keywords//这个方法由quix提供
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int i=0; i<6; i++) {
        NSDictionary *dicInfo=@{@"id":@"800008",@"name":@"nick",@"sex":@"男",@"birthday":@"1978-01-18"};
        [array addObject:dicInfo];
    }
    return array;
}

-(BOOL)createContact//这个方法由quix提供,增加用户  调用- (TblContact *)createContact 接口   说明下TblContact的结构
{
    return YES;
}
-(void)saveLocalDBData//QUIX的保存数据库接口
{
    
}
//////////////////////////



-(void)searchAgentList:(NSString *)agentName//fix me 此处调用本地数据库查询接口
{
    [arrayList removeAllObjects];
     arrayList=[NSMutableArray arrayWithArray:[self searchContactWithKeywords:agentName]];//这里调查询数据库接口
    
    if (arrayList.count>0) {
        tableName.hidden=NO;
        isLock=YES;
        [tableName reloadData];
    }
    else{
        tableName.hidden=YES;
        isLock=NO;
    }
}

-(void)addAgent:(FTDCustomerModel *)model//fix me 此处调用本地数据库新增人才接口
{
    BOOL isSuccess;
    isSuccess=[self createContact];//这里创建用户
    
    if (isSuccess) {
        NSLog(@"用户插入成功");
        [self saveLocalDBData];
        if ([self.delegate respondsToSelector:@selector(homeAlertCreatclick)]) {
            [self.delegate homeAlertCreatclick];
        }
    }
    else
    {
        NSLog(@"用户插入失败");
    }
}

-(void)datechange
{
    NSDate *selectedDate = [self.datePick date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd"];
 
    
    textBirthday.text=[formatter stringFromDate:selectedDate];
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
    if (tableView==tableSex) {
        return 2;
    }
    return arrayList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==tableName) {
        static NSString *identifier = @"tableNameIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14.0];
        cell.textLabel.text=[[arrayList objectAtIndex:indexPath.row] objectForKey:@"name"];
        
        
        
        // Configure the cell...
        return cell;
    }
    else if (tableView==tableSex)
    {
        static NSString *identifier = @"tableSexIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14.0];
        if (indexPath.row==0) {
            cell.textLabel.text=@"男";
        }
        else{
            cell.textLabel.text=@"女";
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
        agentModel.name=[[arrayList objectAtIndex:indexPath.row] objectForKey:@"name"];
        agentModel.sex=[[arrayList objectAtIndex:indexPath.row] objectForKey:@"sex"];
        agentModel.birthday=[[arrayList objectAtIndex:indexPath.row] objectForKey:@"birthday"];
        textName.text=agentModel.name;
        textSex.text=agentModel.sex;
        textBirthday.text=agentModel.birthday;
        
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
- (IBAction)showBirthdayPickClick:(id)sender {
    if (isLock) {
        return;
    }
    
    //[self.delegate showDatePicker];
    
    if (self.viewPick.hidden==YES) {
         self.viewPick.hidden=NO;
    }else{
         self.viewPick.hidden=YES;
    }
   
}

- (IBAction)cancelclick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(homeAlertCancelClick)]) {
        [self.delegate homeAlertCancelClick];
    }
}

- (IBAction)creatclick:(id)sender {
    if (textName.text.length>0&&textSex.text.length>0&&textBirthday.text.length>0) {
        if (arrayList.count==0) {
            agentModel.name=textName.text;
            agentModel.sex=textSex.text;
            agentModel.birthday=textBirthday.text;
            agentModel.userid=nil;
            [self addAgent:agentModel];
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(homeAlertCreatclick)]) {
                [self.delegate homeAlertCreatclick];
            }
        }
        //fix me 此处要进行数据操作
        
        
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
