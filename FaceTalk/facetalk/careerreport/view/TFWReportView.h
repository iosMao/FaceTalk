//
//  TFWReportView.h
//  demo
//
//  Created by wen on 15/8/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFWReportView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end
