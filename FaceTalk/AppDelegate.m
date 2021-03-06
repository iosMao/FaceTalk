//
//  AppDelegate.m
//  FaceTalk
//
//  Created by wen on 15/7/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "AppDelegate.h"
#import "BDRootViewController.h"
#import "TFDNavViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "FTDPersonTController.h"
#import "WXApi.h"
#import "FTDLoginViewController.h"
#import "FTDTalentsListViewController.h"
#import <AFNetworkReachabilityManager.h>
#import "FTDFileManager.h"
#import "FTDHomeViewController.h"
#import "FTDTableViewController.h"
#import <MagicalRecord+Setup.h>
#import "FTDRevenueTrialDetailViewController.h"
#import "FTDChangeDate.h"
#import <SVProgressHUD.h>
#import "FTDDBManager.h"
#import "FTDAES256.h"
#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]

@interface AppDelegate ()
@property (nonatomic,assign) int NetID;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.NetID = 1;
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,100)];
    lblTitle.text =@"该APP已经到期啦！，请点击home键返回桌面";
    lblTitle.center = self.backgroundView.center;
    lblTitle.numberOfLines = 0;
    [lblTitle.layer setMasksToBounds:YES];
    [lblTitle.layer setCornerRadius:5.0];
    lblTitle.textAlignment=NSTextAlignmentCenter;
    lblTitle.font = [UIFont boldSystemFontOfSize:28];
    lblTitle.textColor = [UIColor blackColor];
    lblTitle.backgroundColor = [UIColor whiteColor];
    [self.backgroundView addSubview:lblTitle];
    _LoginLockView = [[FTDLoginLockController alloc]init];
    [self getFinishDate];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"MyDatabase.sqlite"];
    
    [ShareSDK registerApp:@"9b3c933e2258"];
    
    //qq的初始化
    [ShareSDK connectQQWithQZoneAppKey:@"1102803885" qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:@"wx23f27a9377c0b827"        //此参数为申请的微信AppID
                           wechatCls:[WXApi class]];
    
     
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //TFDNavViewController *navBDRootViewCol=[[TFDNavViewController alloc]initWithRootViewController:[[BDRootViewController alloc] init]];
    //navBDRootViewCol.navigationBar.hidden=YES;
    
    FTDHomeViewController *FTDHomeViewCol = [[FTDHomeViewController alloc] init];
    TFDNavViewController *navFTDHomeViewCol = [[TFDNavViewController alloc]initWithRootViewController:FTDHomeViewCol];
    navFTDHomeViewCol.navigationBar.hidden=YES;
     //remove_sp(@"DUSERINFO");
    
    
    if (get_Dsp(@"DUSERINFO")) {
        set_sp(@"DFIRST", @"是");
          //self.window.rootViewController = [[FTDRevenueTrialDetailViewController alloc]init];
          self.window.rootViewController = navFTDHomeViewCol;
        
        
    }
    else{
        set_sp(@"DFIRST", @"否");
        self.window.rootViewController = [[FTDLoginViewController alloc] init];
        
    }
    
    
    NSLog(@"Hello world");
    
    [self.window makeKeyAndVisible];
    
    [self netWorkStatus];
    
    return YES;
}
-(void)getFinishDate
{
    
    FTDDataProvider *dataProvider = [[FTDDataProvider alloc] init];
    __weak FTDHomeViewController *weakself = self;
    
    [dataProvider setFinishBlock:^(NSDictionary *resultDict){
        
        NSLog(@"最后日期：%@",[FTDAES256 AES256DecryptWithString:[resultDict objectForKey:@"msg"]]);
        if ([[resultDict  objectForKey:@"success"] intValue] == 1) {
             
            set_sp(@"DFINISHDATE", [FTDAES256 AES256DecryptWithString:[resultDict objectForKey:@"msg"]]);
            
        }
        else{
            
        }
        
        
        
    }];
    
    [dataProvider setFailedBlock:^(NSString *strError){
        //        [SVProgressHUD dismiss];
        //        [SVProgressHUD showErrorWithStatus:@"哎呀！请求服务器出错啦！请检查本地网络配置！" maskType:SVProgressHUDMaskTypeBlack];
    }];
    
    [dataProvider getFinishDate];
}

- (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
      __weak AppDelegate *weakself = self;
    // 检测网络连接的单例,网络变化时的回调方法
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //这是单利＋模型，用来记录网络状态
        FTDFileManager *maa = [FTDFileManager shareFTDFileManager];
        maa.netState = status;
        
        
        weakself.NetID ++;
        
        if (weakself.NetID > 2 && status == 2) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"检测到有网络，是否同步下人才库呢？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            alert.tag = 703;
            
        }
        
        NSLog(@"-----网络状态----%ld---%d", status,maa.netState);
    }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 700) {
        if (buttonIndex == 0) {
            [SVProgressHUD showWithStatus:@"正在上传..." maskType:SVProgressHUDMaskTypeBlack];
            
            NSArray *array = [FTDDBManager searchLocalDB];
            if (array.count > 0) {
                [self push:array];
            }
        }
    }
    else if (alertView.tag == 701)
    {
        [self.window addSubview:self.backgroundView];
    }
    else if (alertView.tag == 702)
    {
        if (buttonIndex == 0) {
            [SVProgressHUD showWithStatus:@"正在上传..." maskType:SVProgressHUDMaskTypeBlack];
            
            NSArray *array = [FTDDBManager searchLocalDB];
            if (array.count > 0) {
                [self push:array];
            }
        }
    }
    else if (alertView.tag == 703)
    {
        if (buttonIndex == 1) {
            [SVProgressHUD showWithStatus:@"正在上传..." maskType:SVProgressHUDMaskTypeBlack];
            
            NSArray *array = [FTDDBManager searchLocalDB];
            if (array.count > 0) {
                [self netWorkpush:array];
            }
        }
    }
    
}
-(void)netWorkpush:(NSArray *)array//没网到有网同步数据
{
    
    self.dataProvider= [[FTDDataProvider alloc] init];
    __weak AppDelegate *weakself = self;
    
    [self.dataProvider setFinishBlock:^(NSDictionary *resultDict){
        [SVProgressHUD dismiss];
        
        [SVProgressHUD showSuccessWithStatus:@"同步成功" maskType:SVProgressHUDMaskTypeBlack];
        
        
        
        
    }];
    
    [self.dataProvider setFailedBlock:^(NSString *strError){
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"同步失败，请检查网络设置" maskType:SVProgressHUDMaskTypeBlack];
    }];
    
    [self.dataProvider pushTalentsInfoArray:array];
}

-(void)push:(NSArray *)array
{
    
    self.dataProvider= [[FTDDataProvider alloc] init];
     __weak AppDelegate *weakself = self;
    
    [self.dataProvider setFinishBlock:^(NSDictionary *resultDict){
        [SVProgressHUD dismiss];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"成功了" delegate:weakself cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        alert.tag = 701;
//        [SVProgressHUD showSuccessWithStatus:@"同步成功，您可以去IMO使用我们的友待开启了" maskType:SVProgressHUDMaskTypeBlack];
        
        
        
        
    }];
    
    [self.dataProvider setFailedBlock:^(NSString *strError){
        [SVProgressHUD dismiss];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络请求出错啦！再试一下吧～" delegate:weakself cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        alert.tag = 702;
    }];
    
    [self.dataProvider pushTalentsInfoArray:array];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    self.beginDate = [NSDate date];
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSString *strFinishDate = get_sp(@"DFINISHDATE");
    if (strFinishDate.length > 0) {
        NSDate *nowDate = [NSDate date];
        NSString *strNowDate = [FTDChangeDate dateStr:nowDate];
        NSDate *nowDate1 = [FTDChangeDate dateFromString:strNowDate];
        
        NSDate *finishDate = [FTDChangeDate dateFromString:strFinishDate];
        
        if ([finishDate timeIntervalSinceDate:nowDate1] <= 0.0) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"APP到期啦！同步下数据吧！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            alert.tag = 700;
        }
    }
    
    if ([get_sp(@"DFIRST")isEqualToString:@"是"]) {
        if ( [self.window.rootViewController.presentedViewController isKindOfClass:[_LoginLockView class]]) {
            
            return;
        }
        [self.window.rootViewController presentViewController:_LoginLockView animated:YES completion:nil];
        
    }
    self.endDate = [NSDate date];
    NSLog(@"时间差%f",[self.endDate timeIntervalSinceDate:self.beginDate]);
     if ( [self.endDate timeIntervalSinceDate:self.beginDate] > 3600 ) {
         [self.window.rootViewController presentViewController:_LoginLockView animated:YES completion:nil];
     }
    
    
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该关啦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [alert show];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
    set_sp(@"DFIRST", @"是");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    [ShareSDK handleOpenURL:url wxDelegate:self];
    return  [TencentOAuth HandleOpenURL:url];
    
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    [ShareSDK handleOpenURL:url
          sourceApplication:sourceApplication
                 annotation:annotation
                 wxDelegate:self];
    
    NSLog(@"url: %@, annotation: %@", url, annotation);
    return [TencentOAuth HandleOpenURL:url];
}
@end
