//
//  FTDTalentsListViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/20.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDTalentsListViewController.h"
#import "FTDTalentListCell.h"
#import "FTDDBManager.h"
#import "Person.h"
#import "Report.h"
#import "FTDChangeDate.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "FTDShareView.h"
#import "FTDbackgroundView.h"
#import <MessageUI/MessageUI.h>
#import <ShareSDK/ShareSDK.h>
#import <SVProgressHUD.h>
#import "FTWDataManager.h"
#import "TFWOrderModel.h"
#import "TFDNavViewController.h"
#import "FTDDataProvider.h"

#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
@interface FTDTalentsListViewController ()<FTDShareViewDeledate,FTDbackgroundView,MFMailComposeViewControllerDelegate>
{
    BOOL isNameSearch;
    NSMutableArray *arrayList;
    NSMutableDictionary *dicTalent;//保存未生成报告的人才的信息，用来生成报告提供相关信息
}
@property (nonatomic,strong) FTDShareView *shareView;
@property (nonatomic,strong) FTDbackgroundView *backgroundView;
@property (nonatomic,strong) NSData *imgData;
@property (nonatomic,strong) FTDDataProvider *dataProvider;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIView *viewListBG;
@property (strong, nonatomic) IBOutlet UITableView *tableList;
@property (strong, nonatomic) IBOutlet UIView *viewBG;
@property (strong, nonatomic) IBOutlet UIView *viewSearch;
@property (strong, nonatomic) IBOutlet UIButton *btnSearchTitle;
@property (strong, nonatomic) IBOutlet UITextField *textName;

@property (strong, nonatomic) IBOutlet UITextField *textBeginDate;
@property (strong, nonatomic) IBOutlet UITextField *textEndDate;

@property (strong, nonatomic) IBOutlet UIView *viewSearchClass;


@property (strong, nonatomic) IBOutlet UIDatePicker *datePickBegin;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickEnd;

- (IBAction)showSearchClass:(id)sender;
- (IBAction)pushDBAction:(id)sender;

- (IBAction)backclick:(id)sender;
- (IBAction)nameclick:(id)sender;
- (IBAction)dateclick:(id)sender;
- (IBAction)searchclick:(id)sender;

@end

@implementation FTDTalentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isNameSearch = YES;
    self.tableList.separatorColor = [UIColor clearColor];
    [self setviewRound];
    
    self.textBeginDate.hidden = YES;
    self.textEndDate.hidden = YES;
    
    [self buildDatePick];
    [self buildShareView];
    arrayList = [[NSMutableArray alloc]init];
    dicTalent = [[NSMutableDictionary alloc]init];
    [self searchLocalDB];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    TFDNavViewController *nav = (TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden = NO;
    nav.btnRightMenu.hidden = YES;
    
}
-(void)setviewRound
{
    [self.viewListBG.layer setMasksToBounds:YES];
    [self.viewListBG.layer setCornerRadius:3.0];
    
    self.viewBG.backgroundColor = [UIColor whiteColor];
    self.viewBG.layer.shadowColor = [UIColor grayColor].CGColor;
    self.viewBG.layer.shadowOffset = CGSizeMake(4,4);
    self.viewBG.layer.shadowOpacity = 0.8;
    self.viewBG.layer.shadowRadius = 4;
    
    [self.viewSearch.layer setMasksToBounds:YES];
    [self.viewSearch.layer setCornerRadius:3.0];
    [self.viewSearch.layer setBorderWidth:0.5];
    [self.viewSearch.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    self.viewSearchClass.hidden = YES;
    [self.viewSearchClass.layer setBorderWidth:0.7];
    [self.viewSearchClass.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
}
-(void)buildDatePick
{
//    self.viewDatePick.center=CGPointMake(self.view., self.center.y+200);
//    self.viewPick.hidden=YES;
    [self.datePickBegin addTarget:self action:@selector(dateBeginChange) forControlEvents:UIControlEventValueChanged];
    [self.textBeginDate setInputView:self.datePickBegin];
    
    [self.datePickEnd addTarget:self action:@selector(dateEndChange) forControlEvents:UIControlEventValueChanged];
    [self.textEndDate setInputView:self.datePickEnd];
    //[self addSubview:self.viewPick];
}
-(void)buildShareView
{
    _backgroundView= [[FTDbackgroundView alloc]initWithFrame:self.view.frame];
    _backgroundView.delegate=self;
    _shareView=[FTDShareView initCustomview];
    _shareView.delegate=self;
    _shareView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchLocalDB
{
    arrayList = [NSMutableArray arrayWithArray:[FTDDBManager searchLocalDB]];
    _lblTitle.text = [NSString stringWithFormat:@"共有%lu个人才",(unsigned long)arrayList.count];
}

-(void)downkeyboard{
    [_shareView.textEmail resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.textBeginDate) {
        [self dateBeginChange];
    }
    else if (textField == self.textEndDate){
        [self dateEndChange];
    }
}

#pragma mark tableview datasource

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
    static NSString *CellIdentifier = @"FTDTalentListCellCellIdentifier";
    FTDTalentListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FTDTalentListCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
    }
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    else{
        cell.backgroundColor = [UIColor colorWithRed:0.94 green:0.95 blue:0.96 alpha:1];
    }
    Person *person = [arrayList objectAtIndex:indexPath.row];
    cell.lblName.text = person.name;
    cell.lblChatTime.text =  [FTDChangeDate dateStr:person.chattime];
    if ([person.sex isEqualToNumber:@1]) {
        cell.lblSex.text = @"男";
    }
    else{
        cell.lblSex.text = @"女";
    }
//    NSTimeInterval dateDiff = [person.birthday timeIntervalSinceNow];
//    
//    int age=trunc(dateDiff/(60*60*24))/365;
    cell.lblAge.text = [FTDChangeDate dateStr:person.birthday];
    [cell.btnReport setTag:indexPath.row+600];
    [cell.btnReport addTarget:self action:@selector(reportAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnShare setTag:indexPath.row + 900];
    [cell.btnShare addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)reportAction:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag-600);
    
    Person *person = [arrayList objectAtIndex:sender.tag-600];
   
    NSOrderedSet *orderset = person.report;
    if (orderset.count > 0) {
        
        Report *report = [person.report lastObject];
         NSLog(@"报告url：%@",report.imgurl);
        
        NSString* localPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",localPath,report.imgurl];
        if (imagePath.length>0) {
            
            JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
            imageInfo.image = [UIImage imageWithContentsOfFile:imagePath];
             
            imageInfo.referenceView = self.view;
            
            JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                                   initWithImageInfo:imageInfo
                                                   mode:JTSImageViewControllerMode_Image
                                                   backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
            // Present the view controller.
            [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
            
            
            
        }
        else{
            
        }

        
        
        
        
        
    }
    else{
        
        [dicTalent setObject:person.name forKey:@"name"];
        [dicTalent setObject:person.personid forKey:@"personid"];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"还没有相关报告哦！是否立即去创建一份？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert setTag:40000];
    }
}

-(void)shareAction:(UIButton *)sender
{
    Person *person = [arrayList objectAtIndex:sender.tag-900];
    
    NSOrderedSet *orderset = person.report;
    if (orderset.count > 0) {
        
        Report *report = [person.report lastObject];
        NSLog(@"报告url：%@",report.imgurl);
        
        NSString* localPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",localPath,report.imgurl];
        if (report.imgurl.length>0) {
            self.imgData = [NSData dataWithContentsOfFile:imagePath];
            [self.view addSubview:_backgroundView];
            [self.view addSubview:_shareView];
            
            CGAffineTransform transform = _shareView.transform;
            _shareView.transform = CGAffineTransformScale(transform, 0.2, 0.2);
            [UIView animateWithDuration:0.4 animations:^{
                _shareView.transform = CGAffineTransformScale(transform, 1.0, 1.0);
                _shareView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-80);
            }];
        }
    }
    else{
        [dicTalent setObject:person.name forKey:@"name"];
        [dicTalent setObject:person.personid forKey:@"personid"];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"还没有相关报告哦！是否立即去创建一份？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert setTag:40001];
    }
    
    
    
    
    
    
    
}
-(void)shareQQ{
    NSLog(@"qq分享");
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入要分享的QQ邮箱账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 30000;
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *nameField = [alert textFieldAtIndex:0];
    [nameField setKeyboardType:UIKeyboardTypeEmailAddress];
    [alert show];
    
}

-(void)shareWeChat{
    NSLog(@"wechat分享");
    id<ISSContent> publishContent = [ShareSDK content:@"评估报告"
                                       defaultContent:@""
                                                image:[ShareSDK pngImageWithImage:[UIImage imageWithData:self.imgData]]
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
    if (alertView.tag == 30000) {
        if (buttonIndex == 1) {
            UITextField *nameField = [alertView textFieldAtIndex:0];
            Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
            
            if (![mailClass canSendMail]) {
                [SVProgressHUD showErrorWithStatus:@"用户没有设置系统邮箱账号！"];
                return;
            }
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setToRecipients:[NSArray arrayWithObject:nameField.text]];
            [mc setSubject:@"“友待开启”报告"];
            [mc addAttachmentData:self.imgData mimeType:@"image/png" fileName:@"报告页.png"];
            [self presentViewController:mc animated:YES completion:nil];
            //TODO
        }
    }
    else if (alertView.tag == 40000 || alertView.tag == 40001)
    {
        if (buttonIndex == 1) {
            NSDictionary *dic1 = [[NSDictionary alloc]initWithDictionary:dicTalent];
            set_sp(@"DTALENTINFO", dic1);
            
            TFWOrderModel *orderModel = [[FTWDataManager shareManager] selectOrder];
            NSInteger index = orderModel.first;
            NSLog(@"当前%ld",(long)[FTWDataManager shareManager].currentIndex);
            [FTWDataManager shareManager].currentIndex = -1;
            [FTWDataManager shareManager].currentIndex++;
            id vc = nil;
            vc = [[NSClassFromString([[FTWDataManager shareManager].classArray objectAtIndex:index - 1]) alloc] init];
            [self.navigationController setViewControllers:@[vc] animated:YES];
        }
    }
    else if (alertView.tag == 50000)
    {
        if (buttonIndex == 1) {
            [SVProgressHUD showWithStatus:@"正在上传..." maskType:SVProgressHUDMaskTypeBlack];
            
            NSArray *array = [FTDDBManager searchLocalDB];
            if (array.count > 0) {
                [self push:array];
            }
        }
    }
    
    
}
-(void)push:(NSArray *)array
{
    
    self.dataProvider= [[FTDDataProvider alloc] init];
    __weak FTDTalentsListViewController *weakself = self;
    
    [self.dataProvider setFinishBlock:^(NSDictionary *resultDict){
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"同步成功！" maskType:SVProgressHUDMaskTypeBlack];
        //        if ([[resultDict  objectForKey:@"success"] intValue] == 1) {
        ////            [SVProgressHUD showSuccessWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeBlack];
        ////            set_sp(@"DUSERINFO", [resultDict objectForKey:@"msg"]);
        //
        //        }
        //        else{
        //           // [SVProgressHUD showErrorWithStatus:[resultDict objectForKey:@"msg"] maskType:SVProgressHUDMaskTypeBlack];
        //        }
        
        
        
    }];
    
    [self.dataProvider setFailedBlock:^(NSString *strError){
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"哎呀！请求服务器出错啦！请检查本地网络配置！" maskType:SVProgressHUDMaskTypeBlack];
    }];
    
    [self.dataProvider pushTalentsInfoArray:array];
}

-(void)sendtextEmail:(NSString *)textEmail
{
    NSLog(@"%@",textEmail);
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (![mailClass canSendMail]) {
        [SVProgressHUD showErrorWithStatus:@"用户没有设置系统邮箱账号！"];
        return;
    }
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setToRecipients:[NSArray arrayWithObject:textEmail]];
    [mc setSubject:@"“友待开启”报告"];
    [mc addAttachmentData:self.imgData mimeType:@"image/png" fileName:@"报告页.png"];
    [self presentViewController:mc animated:YES completion:nil];
    
    
    
    
    
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



-(void)dateBeginChange
{
    NSDate *selectedDate = [self.datePickBegin date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.textBeginDate.text=[formatter stringFromDate:selectedDate];
}
-(void)dateEndChange
{
    NSDate *selectedDate = [self.datePickEnd date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.textEndDate.text=[formatter stringFromDate:selectedDate];
}

- (IBAction)showSearchClass:(id)sender {
    self.viewSearchClass.hidden = NO;
}

- (IBAction)pushDBAction:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定同步人才库资源？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    alert.tag = 50000;
}

- (IBAction)backclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nameclick:(id)sender {
    [self.btnSearchTitle setTitle:@"按名字查找" forState:UIControlStateNormal];
    self.viewSearchClass.hidden = YES;
    isNameSearch = YES;
    self.textName.hidden = NO;
    self.textBeginDate.hidden = YES;
    self.textEndDate.hidden = YES;
}

- (IBAction)dateclick:(id)sender {
    [self.btnSearchTitle setTitle:@"按日期查找" forState:UIControlStateNormal];
    self.viewSearchClass.hidden = YES;
    isNameSearch = NO;
    self.textName.hidden = YES;
    self.textBeginDate.hidden = NO;
    self.textEndDate.hidden = NO;
    
}

- (IBAction)searchclick:(id)sender {
    if (isNameSearch) {
        
        
        [arrayList removeAllObjects];
        if (_textName.text.length > 0) {
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS %@",_textName.text];//模糊查询本地数据库
            arrayList = [NSMutableArray arrayWithArray:[FTDDBManager searchLocalDBWithKeys:pred]];
        }
        else{
            arrayList = [NSMutableArray arrayWithArray:[FTDDBManager searchLocalDB]];
        }
        
        [_tableList reloadData];
        NSLog(@"按姓名查");
    }
    else{
        [self dateSearch];
        
        
        
        NSLog(@"按日期查");
        
        
        
    }
}
-(void)dateSearch
{
    NSDateFormatter *dateFormatterBegin = [[NSDateFormatter alloc] init];
    [dateFormatterBegin setDateFormat: @"yyyy-MM-dd"];
    NSDate *firstDate = [dateFormatterBegin dateFromString:self.textBeginDate.text];
    NSTimeInterval _fitstDate = [firstDate timeIntervalSince1970]*1;
    
    NSDateFormatter *dateFormatterEnd = [[NSDateFormatter alloc] init];
    
    [dateFormatterEnd setDateFormat: @"yyyy-MM-dd"];
    NSDate *endDate = [dateFormatterEnd dateFromString:self.textEndDate.text];
    
    
    NSTimeInterval _endDate = [endDate timeIntervalSince1970]*1;
    
    
    
    if (_fitstDate - _endDate > 0) {
        
        NSLog(@"第一个大");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"开始时间不能比结束时间大哦！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
        
    }
    else{
        NSPredicate *predicate_date =
        [NSPredicate predicateWithFormat:@"chattime >= %@ AND chattime <= %@", firstDate,endDate];
        [arrayList removeAllObjects];
        arrayList = [NSMutableArray arrayWithArray:[FTDDBManager searchLocalDBWithKeys:predicate_date]];
        [_tableList reloadData];
        
    }
    
    
    
}


@end
