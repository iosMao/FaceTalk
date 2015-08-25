//
//  FTDGoodAgentDetailController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/28.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTJsonSubClassModel.h"
#import "FTJsonExcellentModel.h"
@interface FTDGoodAgentDetailController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int indexid;//记录选中的第几行
}
- (IBAction)backclick:(id)sender;
@property (strong, nonatomic)NSArray *arraySubclass;
@property (assign, nonatomic)int indexID;//上个页面的第几行
@property(strong,nonatomic)FTJsonExcellentModel *ExcellentModel;
@property (strong, nonatomic) IBOutlet UITableView *tableAgentList;
@property (strong, nonatomic) IBOutlet UIImageView *imgBigPhoto;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblOldJob;
@property (strong, nonatomic) IBOutlet UITextView *lblDesc;

@end
