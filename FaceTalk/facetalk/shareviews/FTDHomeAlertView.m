//
//  FTDHomeAlertView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeAlertView.h"

@implementation FTDHomeAlertView
@synthesize tableName,textBirthday,textName,textSex;
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

+(FTDHomeAlertView *)initCustomview
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"FTDHomeAlertView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}
- (void)drawRect:(CGRect)rect {
    tableName.delegate=self;
    tableName.dataSource=self;
    textName.delegate=self;
    [textName addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventEditingChanged];
    tableName.hidden=YES;
    arrayList=[[NSMutableArray alloc]init];
    
}
- (void)textchange:(UITextField *)textField
{
    if (textField.text.length>0) {
        [self searchAgentList:textField.text];
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
    return arrayList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView
    //                             dequeueReusableCellWithIdentifier:@"Cell"];
    static NSString *identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
    }
    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
    cell.textLabel.text=[arrayList objectAtIndex:indexPath.row];
    
    
    
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
    textName.text=[arrayList objectAtIndex:indexPath.row];
    tableName.hidden=YES;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
