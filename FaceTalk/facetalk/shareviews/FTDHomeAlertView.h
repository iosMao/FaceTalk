//
//  FTDHomeAlertView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FTDHomeAlertViewDeledate <NSObject>

- (void)homeAlertCancelClick;
-(void)homeAlertCreatclick;
@end

@interface FTDHomeAlertView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *arrayList;
}
@property(nonatomic, weak)id<FTDHomeAlertViewDeledate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textName;
@property (strong, nonatomic) IBOutlet UITextField *textSex;
@property (strong, nonatomic) IBOutlet UITextField *textBirthday;
@property (strong, nonatomic) IBOutlet UITableView *tableName;
- (IBAction)cancelclick:(id)sender;
- (IBAction)creatclick:(id)sender;

+(FTDHomeAlertView *)initCustomview;
@end
