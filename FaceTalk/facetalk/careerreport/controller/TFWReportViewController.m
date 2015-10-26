//
//  TFWReportViewController.m
//  demo
//
//  Created by wen on 15/8/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWReportViewController.h"
#import "TFWReportView.h"
#import "FTDShareView.h"
#import "FTDbackgroundView.h"
#import "FTDCreatImage.h"
#import "FTDHomeViewController.h"
#import <MessageUI/MessageUI.h>
#import <ShareSDK/ShareSDK.h>

@interface TFWReportViewController ()<FTDShareViewDeledate,FTDbackgroundView,MFMailComposeViewControllerDelegate>
{
    NSData *imgData;
}
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *customNameLabel;
@property (nonatomic,strong) UILabel *adviserNameLabel;
@property (nonatomic,strong) TFWReportView *reportView;
@property (nonatomic,strong) FTDShareView *shareView;
@property (nonatomic,strong) FTDbackgroundView *backgroundView;
@end

@implementation TFWReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildBackGround];
    //[self buildBackButton];
    [self buildTitleLabel];
    [self buildNameLabel];
    [self buildReportView];
    //[self buildPopButton];
    [self buildShadow];
    [self buildOkButton];
    [self buildEOPButton];
    [self buildShareButton];
    [self buildShareView];
    CANCREATREPORT = NO;
    
    
}
-(void)buildShareView
{
    _backgroundView= [[FTDbackgroundView alloc]initWithFrame:self.view.frame];
    _backgroundView.delegate=self;
    _shareView=[FTDShareView initCustomview];
    _shareView.delegate=self;
    _shareView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
    
    
}
-(void)buildBackGround
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 2046 / 2.0, 1496 / 2.0)];
    back.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ftw_share_back" ofType:@"png"]];
    [self.view addSubview:back];
}

-(void)buildBackButton
{
    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame = CGRectMake(235 / 2.0, 156 / 2.0, 13, 23);
    [backBt setImage:[UIImage imageNamed:@"tfw_tf_back"] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
}

-(void)buildTitleLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(296 / 2.0, 148 / 2.0, 700 / 2.0, 30)];
    self.titleLabel.text = @"生成职业评估报告";
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self.view addSubview:self.titleLabel];
}

-(void)buildNameLabel
{
    _customNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(386, 378, 320, 56)];
    _customNameLabel.font = [UIFont systemFontOfSize:43];
    _customNameLabel.textColor = [UIColor whiteColor];
    _customNameLabel.textAlignment = NSTextAlignmentCenter;
    _customNameLabel.text = @"致 李月月";
    [self.view addSubview:_customNameLabel];
    
    _adviserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(582, 441, 80, 30)];
    _adviserNameLabel.font = [UIFont systemFontOfSize:19];
    _adviserNameLabel.textColor = [UIColor whiteColor];
    _adviserNameLabel.textAlignment = NSTextAlignmentCenter;
    _adviserNameLabel.text = @"马萧萧";
    [self.view addSubview:_adviserNameLabel];
}


-(void)buildPopButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_customNameLabel.frame), CGRectGetMinY(_customNameLabel.frame), CGRectGetWidth(_customNameLabel.frame), CGRectGetHeight(_customNameLabel.frame) * 4)];
    [button addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buildShadow
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 435 + 46, 804, 102)];
    imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ftw_share_shadow" ofType:@"png"]];
    [self.view addSubview:imageView];
}

-(void)buildReportView
{
    _reportView = [[TFWReportView alloc] init];
    _reportView.center = CGPointMake(CGRectGetMidX(_customNameLabel.frame), CGRectGetHeight(_reportView.frame) / 2.0);
    [self.view addSubview:_reportView];
}

-(void)buildOkButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(672, 600, 150/1.2,154/1.2);
    [bt setImage:[UIImage imageNamed:@"ftw_share_continue"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}
-(void)buildShareButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(522, 600, 150/1.2,154/1.2);
    [bt setImage:[UIImage imageNamed:@"ftw_share_complete"] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@"ftw_share_share"] forState:UIControlStateSelected];
    [bt addTarget:self action:@selector(ShareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}
-(void)buildEOPButton
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(822, 600, 150/1.2,154/1.2);
    [bt setImage:[UIImage imageNamed:@"ftw_share_EOP"] forState:UIControlStateNormal];
    
    [bt addTarget:self action:@selector(EOPClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
}

-(void)downkeyboard{
    [_shareView.textEmail resignFirstResponder];
}
-(void)popAction:(UIButton *)button
{
    
//    [UIView animateWithDuration:1.0 animations:^{
//        _reportView.center = CGPointMake(CGRectGetMidX(_customNameLabel.frame), 295);
//        _reportView.alpha = 1.0f;
//    }];
}

-(void)back:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ShareAction:(UIButton *)bt
{
    if (_reportView.endEdit) {
        
        
        
        [self.view addSubview:_backgroundView];
        [self.view addSubview:_shareView];
        
        CGAffineTransform transform = _shareView.transform;
        _shareView.transform = CGAffineTransformScale(transform, 0.2, 0.2);
        [UIView animateWithDuration:0.4 animations:^{
            _shareView.transform = CGAffineTransformScale(transform, 1.0, 1.0);
            _shareView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
        }];
    }else{
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 10; i++) {
            if ([[_reportView.choiceArray objectAtIndex:i] boolValue]) {
                [array addObject:[NSNumber numberWithInteger:i]];
            }
        }
        _reportView.selectArray = [NSArray arrayWithArray:array];
        if (_reportView.selectArray.count > 0) {
            _reportView.isShowTenElement = YES;
        }else{
            _reportView.isShowTenElement = NO;
        }
        _reportView.endEdit = YES;
        bt.selected = YES;
        CANCREATREPORT = YES;
        [_reportView.tableView reloadData];
        [self CreatReportImage];
        
    }
}

-(void)CreatReportImage
{
    UIImage *reportImage= [FTDCreatImage getImage:_reportView.tableView];
    imgData=UIImageJPEGRepresentation(reportImage, 0.5) ;
    [self SendReportImage:imgData];
}
-(void)SendReportImage:(NSData *)imgdata//这个接口用来向QUIX发送报告照片的data
{
    //NSLog(@"%@",imgdata);
    
}

-(void)continueAction
{
    if (CANCREATREPORT) {
        FTDHomeViewController *vc=[[FTDHomeViewController alloc]init];
        [self.navigationController setViewControllers:@[vc] animated:YES];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"为了更好的记录本次信息，请先生成报告！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
    
}
-(void)shareQQ{
    NSLog(@"qq分享");
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入要分享的QQ邮箱账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *nameField = [alert textFieldAtIndex:0];
    [nameField setKeyboardType:UIKeyboardTypeEmailAddress];
    [alert show];
    
    
    
//    id<ISSContent> publishContent = [ShareSDK content:@"评估报告"
//                                       defaultContent:@""
//                                                image:[ShareSDK jpegImageWithImage:[UIImage imageWithData:imgData] quality:1.0]
//                                                title:@"评估报告"
//                                                  url:nil
//                                          description:@""
//                                            mediaType:SSPublishContentMediaTypeImage];
//    
//    
//    [ShareSDK shareContent:publishContent
//                      type:ShareTypeQQ
//               authOptions:nil
//              shareOptions:nil
//             statusBarTips:YES
//                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                        if (state == SSPublishContentStateSuccess)
//                        {
//                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
//                        }
//                        else if (state == SSPublishContentStateFail)
//                        {
//                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
//                        }
//                        
//                    }];
//    
    
    
}
-(void)shareWeChat{
    NSLog(@"wechat分享");
    id<ISSContent> publishContent = [ShareSDK content:@"评估报告"
                                       defaultContent:@""
                                                image:[ShareSDK pngImageWithImage:[UIImage imageWithData:imgData]]
                                                title:@"评估报告"
                                                  url:nil
                                          description:@""
                                            mediaType:SSPublishContentMediaTypeImage];
    
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeWeixiSession
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                        }
                        
                    }];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setToRecipients:[NSArray arrayWithObject:nameField.text]];
        [mc setSubject:@"“友待开启”报告"];
        [mc addAttachmentData:imgData mimeType:@"image/png" fileName:@"报告页"];
        [self presentViewController:mc animated:YES completion:nil];
        //TODO
    }

}

-(void)sendtextEmail:(NSString *)textEmail
{
    NSLog(@"%@",textEmail);
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setToRecipients:[NSArray arrayWithObject:textEmail]];
    [mc setSubject:@"“友待开启”报告"];
    [mc addAttachmentData:imgData mimeType:@"image/png" fileName:@"报告页"];
    [self presentViewController:mc animated:YES completion:nil];
    
    
    
    
    
}
-(void)EOPClick:(UIButton *)btn
{
    NSLog(@"报名EOP");
    
    NSURL *url =[NSURL URLWithString: @"calshow://"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    
    
}


-(void)cancelview
{
     CGAffineTransform transform = _shareView.transform;
     [UIView animateWithDuration:0.4 animations:^{
        _shareView.transform = CGAffineTransformScale(transform,0.01,0.01);
    }
                      completion:^(BOOL finished){
                          [_backgroundView removeFromSuperview];
                          [_shareView removeFromSuperview];
                          _shareView.transform = CGAffineTransformScale(transform,1,1);
                      }];
    
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
