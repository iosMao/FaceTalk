//
//  FTDLoginLockController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/12/1.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDLoginLockController.h"
#import "FTDDataProvider.h"
#import "FTDHomeViewController.h"
#import "TFDNavViewController.h"
#import <SVProgressHUD.h>
#import "NSData+Encryption.h"
#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
@interface FTDLoginLockController ()
{
    NSMutableDictionary *dicLoginInfo;
    NSMutableArray *arrayCity;
}
@property (strong, nonatomic) IBOutlet UITextField *textAccount;
@property (strong, nonatomic) IBOutlet UITextField *textPasword;
@property (strong, nonatomic) IBOutlet UITextField *textCo;
@property (strong, nonatomic) IBOutlet UIView *viewAccount;
@property (strong, nonatomic) IBOutlet UIView *viewPasword;
@property (strong, nonatomic) IBOutlet UIView *viewCo;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UITableView *tableCity;

- (IBAction)showCityList:(id)sender;

- (IBAction)loginclick:(id)sender;
@end

@implementation FTDLoginLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dicLoginInfo = [[NSMutableDictionary alloc]init];
    arrayCity = [[NSMutableArray alloc]init];
    [arrayCity addObject:@"上海分公司"];
    [arrayCity addObject:@"深圳分公司"];
    [arrayCity addObject:@"北京分公司"];
    [arrayCity addObject:@"江苏分公司"];
    [arrayCity addObject:@"广东分公司"];
    [arrayCity addObject:@"佛山支公司"];
    [arrayCity addObject:@"江门支公司"];
    [arrayCity addObject:@"东莞支公司"];
    self.tableCity.hidden = YES;
    [self setViewRound];
    // Do any additional setup after loading the view from its nib.
}
-(void)setViewRound
{
    [_viewAccount.layer setMasksToBounds:YES];
    [_viewAccount.layer setCornerRadius:5.0];
    [_viewAccount.layer setBorderWidth:1.0];
    [_viewAccount.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [_viewPasword.layer setMasksToBounds:YES];
    [_viewPasword.layer setCornerRadius:5.0];
    [_viewPasword.layer setBorderWidth:1.0];
    [_viewPasword.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [_viewCo.layer setMasksToBounds:YES];
    [_viewCo.layer setCornerRadius:5.0];
    [_viewCo.layer setBorderWidth:1.0];
    [_viewCo.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [_btnLogin.layer setMasksToBounds:YES];
    [_btnLogin.layer setCornerRadius:3.0];
    //    [_btnLogin.layer setBorderWidth:1.0];
    //    [_btnLogin.layer setBorderColor:[[UIColor grayColor] CGColor]];
}

-(void)getLoginInfo
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    FTDDataProvider *dataProvider = [[FTDDataProvider alloc] init];
    __weak FTDLoginLockController *weakself = self;
    
    [dataProvider setFinishBlock:^(NSDictionary *resultDict){
        [SVProgressHUD dismiss];
        NSLog(@"登录结果：%@",resultDict);
        if ([[resultDict  objectForKey:@"success"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeBlack];
            set_sp(@"DUSERACOUNT", self.textAccount.text);
            set_sp(@"DUSERPASWOD", self.textPasword.text);
            set_sp(@"DCITY", self.textCo.text);
            
            set_sp(@"DUSERINFO", [resultDict objectForKey:@"msg"]);
            weakself.textAccount.text = nil;
            weakself.textPasword.text = nil;
            weakself.textCo.text = nil;
            set_sp(@"DFIRST", @"否");
            [weakself dismissViewControllerAnimated:YES completion:nil];
            
            
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"] maskType:SVProgressHUDMaskTypeBlack];
        }
        
        
        
    }];
    
    [dataProvider setFailedBlock:^(NSString *strError){
        //[SVProgressHUD dismiss];
        [weakself checkLocalLogin];
        
        
        
//        [SVProgressHUD showErrorWithStatus:@"哎呀！请求服务器出错啦！请检查本地网络配置！" maskType:SVProgressHUDMaskTypeBlack];
    }];
    
    [dataProvider userLogin:dicLoginInfo];
    
}

-(void)checkLocalLogin
{
    NSLog(@"%@",get_sp(@"DUSERACOUNT"));
    NSLog(@"%@",get_sp(@"DUSERPASWOD"));
    NSLog(@"%@",get_sp(@"DCITY"));
    
    if ([self.textAccount.text isEqualToString:get_sp(@"DUSERACOUNT")] && [self.textPasword.text isEqualToString:get_sp(@"DUSERPASWOD")] && [self.textCo.text isEqualToString:get_sp(@"DCITY")]) {
        [SVProgressHUD showSuccessWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeBlack];
        self.textAccount.text = nil;
        self.textPasword.text = nil;
        self.textCo.text = nil;
        set_sp(@"DFIRST", @"否");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"验证失败，请检查用户名密码是否正确" maskType:SVProgressHUDMaskTypeBlack];
    }
    
    
}




- (IBAction)showCityList:(id)sender {
    if (self.tableCity.hidden == YES) {
        self.tableCity.hidden = NO;
    }
    else{
        self.tableCity.hidden = YES;
    }
}

- (IBAction)loginclick:(id)sender {
    if (_textAccount.text.length > 0 &&_textPasword.text > 0 && _textCo.text.length > 0) {
        
        NSString *strAccount;
        if ([_textAccount.text length] < 9) {
            switch ([_textAccount.text length]) {
                case 1:
                    strAccount = [NSString stringWithFormat:@"00000000%@",_textAccount.text];
                    break;
                    
                case 2:
                    strAccount = [NSString stringWithFormat:@"0000000%@",_textAccount.text];
                    break;
                    
                case 3:
                    strAccount = [NSString stringWithFormat:@"000000%@",_textAccount.text];
                    break;
                    
                case 4:
                    strAccount = [NSString stringWithFormat:@"00000%@",_textAccount.text];
                    break;
                    
                case 5:
                    strAccount = [NSString stringWithFormat:@"0000%@",_textAccount.text];
                    break;
                    
                case 6:
                    strAccount = [NSString stringWithFormat:@"000%@",_textAccount.text];
                    break;
                    
                case 7:
                    strAccount = [NSString stringWithFormat:@"00%@",_textAccount.text];
                    break;
                    
                case 8:
                    strAccount = [NSString stringWithFormat:@"0%@",_textAccount.text];
                    break;
                    
                default:
                    break;
            }
            
            
            
            
            [dicLoginInfo setObject:strAccount forKey:@"account"];
        }
        else{
            [dicLoginInfo setObject:_textAccount.text forKey:@"account"];
        }
        [dicLoginInfo setObject:_textPasword.text forKey:@"password"];
        //        986	上海分公司
        //        1086	深圳分公司
        //        1186	北京分公司
        //        1286	江苏分公司
        //        2586	广东分公司
        //        2686	佛山支公司
        //        2786	江门支公司
        //        2886	东莞支公司
        if ([_textCo.text isEqualToString:@"上海分公司"]) {
            [dicLoginInfo setObject:@"0986" forKey:@"co"];
        }
        else if ([_textCo.text isEqualToString:@"深圳分公司"])
        {
            [dicLoginInfo setObject:@"1086" forKey:@"co"];
        }
        else if ([_textCo.text isEqualToString:@"北京分公司"])
        {
            [dicLoginInfo setObject:@"1186" forKey:@"co"];
        }
        else if ([_textCo.text isEqualToString:@"江苏分公司"])
        {
            [dicLoginInfo setObject:@"1286" forKey:@"co"];
        }
        else if ([_textCo.text isEqualToString:@"广东分公司"])
        {
            [dicLoginInfo setObject:@"2586" forKey:@"co"];
        }
        else if ([_textCo.text isEqualToString:@"佛山支公司"])
        {
            [dicLoginInfo setObject:@"2686" forKey:@"co"];
        }
        else if ([_textCo.text isEqualToString:@"江门支公司"])
        {
            [dicLoginInfo setObject:@"2786" forKey:@"co"];
        }
        else if ([_textCo.text isEqualToString:@"东莞支公司"])
        {
            [dicLoginInfo setObject:@"2886" forKey:@"co"];
        }
        [self getLoginInfo];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请将信息填写完整！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}
#pragma mark tableview datasource delegate

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
    return arrayCity.count;
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
    
    cell.textLabel.text = [arrayCity objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    
    
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
    self.tableCity.hidden = YES;
    self.textCo.text = [arrayCity objectAtIndex:indexPath.row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
