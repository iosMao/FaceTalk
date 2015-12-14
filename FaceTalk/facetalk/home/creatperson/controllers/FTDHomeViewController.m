//
//  FTDHomeViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/9.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDHomeViewController.h"
#import "FTDHomeLeadViewController.h"
#import "UIView+MaterialDesign.h"
#import "TFDNavViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "FTDDataPacketManager.h"
#import "FTJsonManager.h"
#import "Person.h"
#import "Report.h"
#import "FTDDataProvider.h"
#import "FTDDBManager.h"
#import "FTDAES256.h"
#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
@interface FTDHomeViewController ()
{
    NSTimer *loadTimer;
    int timeIndex;
}
@end

@implementation FTDHomeViewController
@synthesize btnKey,scrollBG;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getlocalResourse];
    //[self reminderBtn];
    [self getFinishDate];
     
    [self getJsonUrl];
    
    NSLog(@"%@",self.navigationController);
    TFDNavViewController *nav = (TFDNavViewController *) self.navigationController;
    nav.btnSlider.hidden    = YES;
    nav.btnRightMenu.hidden = YES;
    
    scrollBG.contentSize   = CGSizeMake(1024, 748);
    scrollBG.pagingEnabled = YES;
    scrollBG.scrollEnabled = NO;
    //[btnKey addTarget:self action:@selector(homeLeadViewclick:event:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getlocalResourse) name:@"FTDUNZIPSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backIMOclick:) name:@"FTDREQUESTFAILED" object:nil];
    [self getLoginUserInfo];
    
    
//    Person *person = [Person MR_createEntity];
//    person.name = @"xiaomao";
//    person.sex = @1;
//    person.birthday = @"19023";
//    
//    Report *report = [Report MR_createEntity];
//    report.imgurl = @"http://sdsdsdsds";
//    NSOrderedSet *order = [[NSOrderedSet alloc]initWithArray:@[report]];
//    person.report = order;
//    
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    
//    NSArray *persons=[Person MR_findAll];
//    for (int i=0; i<persons.count; i++) {
//        Person *persong1=[persons objectAtIndex:i];
//        NSLog(@"personidw为哈哈：%@",persong1.personid);
//        NSOrderedSet *orderset = persong1.report;
//        if (orderset.count > 0) {
//            for (int m = 0; m <orderset.count; m++) {
//                Report *report = [persong1.report objectAtIndex:m];
//                NSLog(@"报告：%@",report.imgurl);
//            }
//            
//        }
//        
//    }
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"m"];//模糊查询本地数据库
//    [self push: [[FTDDBManager searchLocalDBWithKeys:pred] objectAtIndex:0]];
 
}
-(void)getJsonUrl
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    FTDDataProvider *dataProvider = [[FTDDataProvider alloc] init];
    __weak FTDHomeViewController *weakself = self;
    
    [dataProvider setFinishBlock:^(NSDictionary *resultDict){
        
        NSLog(@"json文件url：%@",resultDict);
        if ([[resultDict  objectForKey:@"success"] intValue] == 1) {
            
            [weakself updateJsonFile:[resultDict objectForKey:@"msg"]];
            
        }
        else{
            [SVProgressHUD dismiss];
        }
        
        
        
    }];
    
    [dataProvider setFailedBlock:^(NSString *strError){
        [SVProgressHUD dismiss];
    }];
    
    [dataProvider getJsonUrl];
}


-(void)updateJsonFile:(NSString *)url
{
    
    FTDDataProvider *dataProvider = [[FTDDataProvider alloc] init];
    __weak FTDHomeViewController *weakself = self;
    
    [dataProvider setFinishBlock:^(NSDictionary *resultDict){
        
        NSLog(@"登录结果：%@",resultDict);
        if ([[resultDict  objectForKey:@"success"] intValue] == 1) {
            [SVProgressHUD dismiss];
            [[FTJsonManager shareManager]initData];
            [weakself checkPicUpdate];
        }
        else{
            [SVProgressHUD dismiss];
        }
        
        
        
    }];
    
    [dataProvider setFailedBlock:^(NSString *strError){
        [SVProgressHUD dismiss];
    }];
    
    [dataProvider upDateJsonFile:url];
}
-(void)checkPicUpdate
{
    if ([[FTJsonManager shareManager].lastUpdatePicDate isEqualToString:get_sp(@"DLASTUPDATEPIC")]) {
        NSLog(@"没更新");
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"检测到图片有更新，是否更新资源包？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[FTDDataPacketManager sharedInstance] downloadFile];
    }
}
-(void)getFinishDate
{
    
    FTDDataProvider *dataProvider = [[FTDDataProvider alloc] init];
    __weak FTDHomeViewController *weakself = self;
    
    [dataProvider setFinishBlock:^(NSDictionary *resultDict){
        
        NSLog(@"最后日期：%@",resultDict);
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

-(void)getLoginUserInfo//由QUIX协助调用获取登录信息接口  说明下“TblProfile”模型的结构
{
    
}



-(void)getlocalResourse
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dstResourcePath = [[FTDDataPacketManager sharedInstance]unzipDestinationPath];
    NSLog(@"沙盒路径：%@",dstResourcePath);
    dstResourcePath = [dstResourcePath stringByAppendingPathComponent:@"uploads"];
    dstResourcePath = [dstResourcePath stringByAppendingPathComponent:@"data.json"];
    if ([fileManager fileExistsAtPath:dstResourcePath]) {
        [self getbackgroundImg];
        if ([FTDDataPacketManager sharedInstance].firstID == 0) {
            if (get_sp(@"DLASTUPDATEPIC") == nil) {
                //set_sp(@"DLASTUPDATEPIC", @"2014-12-29");
                
                set_sp(@"DLASTUPDATEPIC", [FTJsonManager shareManager].lastUpdatePicDate);
                [FTDDataPacketManager sharedInstance].firstID = 1;
            }
        }
        else{
            set_sp(@"DLASTUPDATEPIC", [FTJsonManager shareManager].lastUpdatePicDate);
        }
        
        
    
        loadTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reminderBtn) userInfo:nil repeats:YES];
        [loadTimer fire];
    }
    else{
         
        [[FTDDataPacketManager sharedInstance] downloadFile];
    }
}


-(void)getbackgroundImg
{
    NSString *strImg = [FTJsonManager shareManager].index_background;
    
    UIImageView *scrollImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 1024, 748)];
     scrollImage.image = [UIImage imageWithContentsOfFile:strImg] ;
     //scrollImage.image=[UIImage imageNamed:@"FTD_home_aiaoffice.png"];
    [scrollBG addSubview:scrollImage];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.btnyinKey.enabled = YES;
    NSLog(@"%@",self.navigationController);
    TFDNavViewController *nav = (TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden = YES;
    nav.btnRightMenu.hidden = YES;
    nav.viewRightMenu.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
     //[SVProgressHUD showProgress:0.5 status:@"已下载50%" maskType:SVProgressHUDMaskTypeBlack];
}
-(void)viewDidDisappear:(BOOL)animated
{
    btnKey.alpha = 1;
    btnKey.frame = CGRectMake(700, 350, 260, 180);
    
}

-(void)reminderBtn
{
//    CGAffineTransform trans = btnKey.transform;
//    btnKey.transform = CGAffineTransformScale(trans, 0.7, 0.7);
//    if (timeIndex==3) {
//        [loadTimer invalidate];
//        
//    }
    [UIView animateWithDuration:1.0 animations:^{
        btnKey.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            btnKey.alpha = 1;
        } completion:^(BOOL finished) {
            //timeIndex++;
        }];
    }];
    
}

-(void)homeLeadViewclick
{
    
    
   
    [loadTimer invalidate];
     btnKey.alpha = 1;
    __weak FTDHomeViewController *weak = self;
    FTDHomeLeadViewController *FTDHomeLeadViewCol = [[FTDHomeLeadViewController alloc] init];
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            btnKey.center=CGPointMake(512, 440);
            btnKey.alpha = 0;
        } completion:^(BOOL finished) {
            
            CGPoint exactTouchPosition = CGPointMake(512, 440);
            
            
            [UIView mdInflateTransitionFromView:weak.view toView:FTDHomeLeadViewCol.view originalPoint:exactTouchPosition duration:1.5 completion:^{
                NSLog(@"completed!");
                [weak.navigationController pushViewController:FTDHomeLeadViewCol animated:YES];
                
            }];
        }];

        // code to be executed on the main queue after delay
    });
    
    
    
    
//    CATransition *  tran=[CATransition animation];
//    tran.type =kCATransitionFade;
//     tran.subtype = kCATransitionFromRight;
//    tran.duration=1;
//    tran.delegate=self;
//    [self.view.superview.layer addAnimation:tran forKey:@"kongyu"];
    
}
- (IBAction)backIMOclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)keyclick:(id)sender {
    self.btnyinKey.enabled = NO;
    [self homeLeadViewclick];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
