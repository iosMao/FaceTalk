//
//  FTDLoginViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/16.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDLoginViewController.h"
#import "FTDDataProvider.h"
#import <SVProgressHUD.h>
@interface FTDLoginViewController ()
{
    NSMutableDictionary *dicLoginInfo;
}
@property (strong, nonatomic) IBOutlet UITextField *textAccount;
@property (strong, nonatomic) IBOutlet UITextField *textPasword;
@property (strong, nonatomic) IBOutlet UITextField *textCo;
- (IBAction)loginclick:(id)sender;

@end

@implementation FTDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dicLoginInfo = [[NSMutableDictionary alloc]init];
    // Do any additional setup after loading the view from its nib.
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getLoginInfo
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    FTDDataProvider *dataProvider = [[FTDDataProvider alloc] init];
    [dataProvider setFinishBlock:^(NSDictionary *resultDict){
        [SVProgressHUD dismiss];
        NSLog(@"登录结果：%@",resultDict);
        if ([[resultDict  objectForKey:@"success"] intValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeBlack];
        }
        else{
           [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"] maskType:SVProgressHUDMaskTypeBlack];
        }
        
        
        
    }];
    
    [dataProvider setFailedBlock:^(NSString *strError){
        
        
    }];
    
    [dataProvider userLogin:dicLoginInfo];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginclick:(id)sender {
    
    if (_textAccount.text.length>0&&_textPasword.text>0&&_textCo.text.length>0) {
        [dicLoginInfo setObject:_textAccount.text forKey:@"account"];
        [dicLoginInfo setObject:_textPasword.text forKey:@"password"];
        [dicLoginInfo setObject:_textCo.text forKey:@"co"];
        [self getLoginInfo];
        
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请将信息填写完整！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
    
    
    
    
    
    
    
    
}
@end
