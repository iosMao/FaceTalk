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
//-(void)push:(Person *)person
//{
//    //[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
//    FTDDataProvider *dataProvider = [[FTDDataProvider alloc] init];
//    __weak FTDHomeViewController *weakself = self;
//    
//    [dataProvider setFinishBlock:^(NSDictionary *resultDict){
//        //[SVProgressHUD dismiss];
//        NSLog(@"登录结果：%@",resultDict);
//        if ([[resultDict  objectForKey:@"success"] intValue] == 1) {
//            //            [SVProgressHUD showSuccessWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeBlack];
//            //            set_sp(@"DUSERINFO", [resultDict objectForKey:@"msg"]);
//            
//            
//            
//            
//            
//            
//            
//        }
//        else{
//            // [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"] maskType:SVProgressHUDMaskTypeBlack];
//        }
//        
//        
//        
//    }];
//    
//    [dataProvider setFailedBlock:^(NSString *strError){
//        //        [SVProgressHUD dismiss];
//        //        [SVProgressHUD showErrorWithStatus:@"哎呀！请求服务器出错啦！请检查本地网络配置！" maskType:SVProgressHUDMaskTypeBlack];
//    }];
//    
//    [dataProvider pushTalentsInfo:person];
//}

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
    
    
    btnKey.alpha = 1;
    [loadTimer invalidate];
    
    __weak FTDHomeViewController *weak = self;
    FTDHomeLeadViewController *FTDHomeLeadViewCol = [[FTDHomeLeadViewController alloc] init];
    
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
    [self homeLeadViewclick];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
