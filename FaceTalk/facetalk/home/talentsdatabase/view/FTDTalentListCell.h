//
//  FTDTalentListCell.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/20.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDTalentListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblChatTime;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSex;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UIButton *btnReport;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
 

@end
