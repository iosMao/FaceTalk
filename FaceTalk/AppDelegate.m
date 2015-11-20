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
#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
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
          //self.window.rootViewController = [[FTDRevenueTrialDetailViewController alloc]init];
          self.window.rootViewController = navFTDHomeViewCol;
    }
    else{
        self.window.rootViewController = [[FTDLoginViewController alloc] init];
    }
    
    
    NSLog(@"Hello world");
    
    [self.window makeKeyAndVisible];
    
    [AppDelegate netWorkStatus];
    
    return YES;
}


+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //这是单利＋模型，用来记录网络状态
        FTDFileManager *maa = [FTDFileManager shareFTDFileManager];
        maa.netState = status;
        NSLog(@"-----网络状态----%ld---%d", status,maa.netState);
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
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
