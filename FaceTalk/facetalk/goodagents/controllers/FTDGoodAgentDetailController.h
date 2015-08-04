//
//  FTDGoodAgentDetailController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/28.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDGoodAgentDetailController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int indexid;
}
- (IBAction)backclick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableAgentList;
@property (strong, nonatomic) IBOutlet UIImageView *imgBigPhoto;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblOldJob;
@property (strong, nonatomic) IBOutlet UITextView *lblDesc;

@end
