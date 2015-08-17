//
//  FTDHomeAlertView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTDCustomerModel.h"
@protocol FTDHomeAlertViewDeledate <NSObject>

- (void)homeAlertCancelClick;
-(void)homeAlertCreatclick;
//-(void)showDatePicker;
@end

@interface FTDHomeAlertView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *arrayList;//数据库查询到的用户列表
    BOOL isLock;//若能查询到用户，则性别与生日为锁定状态
    FTDCustomerModel *agentModel;
}
@property(nonatomic, weak)id<FTDHomeAlertViewDeledate> delegate;
@property (strong, nonatomic) IBOutlet UIView *viewBG;

@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UITextField *textSex;
@property (strong, nonatomic) IBOutlet UITextField *textBirthday;
@property (strong, nonatomic) IBOutlet UITableView *tableName;
@property (strong, nonatomic) IBOutlet UITableView *tableSex;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePick;
@property (strong, nonatomic) IBOutlet UIView *viewPick;

- (IBAction)showBirthdayPickClick:(id)sender;
- (IBAction)cancelclick:(id)sender;
- (IBAction)creatclick:(id)sender;
- (IBAction)showSexListClick:(id)sender;

+(FTDHomeAlertView *)initCustomview;
@end
