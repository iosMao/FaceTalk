//
//  FTDHomeAlertView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeAlertView.h"
#import "FTDCustomerModel.h"
@implementation FTDHomeAlertView
@synthesize tableName,tableSex,textBirthday,textName,textSex;

+(FTDHomeAlertView *)initCustomview
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FTDHomeAlertView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}
- (void)drawRect:(CGRect)rect {
    arrayList=[[NSMutableArray alloc]init];
    
    tableName.delegate=self;
    tableName.dataSource=self;
    tableName.hidden=YES;
    
    tableSex.delegate=self;
    tableSex.dataSource=self;
    tableSex.hidden=YES;
    
    textName.delegate=self;
    [textName addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    
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

-(void)searchAgentList:(NSString *)agentName//此处调用本地数据库查询接口
{
    [arrayList removeAllObjects];
    for (int i=0; i<6; i++) {
        [arrayList addObject:@"小李"];
    }
    
    if (arrayList.count>0) {
        tableName.hidden=NO;
        [tableName reloadData];
    }
    
}
-(void)addAgent:(FTDCustomerModel *)model//此处调用本地数据库新增人才接口
{
    
    
    
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
        cell.textLabel.text=[arrayList objectAtIndex:indexPath.row];
        
        
        
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
        textName.text=[arrayList objectAtIndex:indexPath.row];
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
- (IBAction)cancelclick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(homeAlertCancelClick)]) {
        [self.delegate homeAlertCancelClick];
    }
}

- (IBAction)creatclick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(homeAlertCreatclick)]) {
        [self.delegate homeAlertCreatclick];
    }
}



@end
