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
@property (nonatomic,assign) BOOL endEdit;
@property (nonatomic,strong) NSMutableArray *choiceArray;
@property (nonatomic,strong) NSArray *selectArray;

@property (nonatomic,assign) BOOL isShowCareer;
@property (nonatomic,assign) BOOL isShowTenElement;
@property (nonatomic,assign) BOOL isShowSuggest;

@end
