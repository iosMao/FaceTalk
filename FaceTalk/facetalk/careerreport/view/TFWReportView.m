//
//  TFWReportView.m
//  demo
//
//  Created by wen on 15/8/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWReportView.h"
#import "TFWReportTenElementCell.h"
#import "TFWReportCareerCell.h"
#import "TFWReportSuggestCell.h"

static NSString *cellTenElementIdentifier = @"cellTenElementIdentifier";
static NSString *cellCareerIdentifier = @"cellCareerIdentifier";
static NSString *cellSuggestIdentifier = @"cellSuggestIdentifier";

@interface TFWReportView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UILabel *customNameLabel;
@property (nonatomic,strong) UILabel *adviserNameLabel;

@end

@implementation TFWReportView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createReportView
{
    TFWReportView *reportView = [[TFWReportView alloc] initWithFrame:CGRectZero];
    
    return reportView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 771, 550)];
    
    if (self) {
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[TFWReportTenElementCell class] forCellReuseIdentifier:cellTenElementIdentifier];
    [_tableView registerClass:[TFWReportCareerCell class] forCellReuseIdentifier:cellCareerIdentifier];
    [_tableView registerClass:[TFWReportSuggestCell class] forCellReuseIdentifier:cellSuggestIdentifier];
    _tableView.rowHeight = 140.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self createHeadView];
    
    [self addSubview:_tableView];
}

-(void)createHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 771, 407 + 177)];
    headView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 177, 771, 407)];
    imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ftw_share_head" ofType:@"png"]];
    [headView addSubview:imageView];
    
    _customNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 202 + 177, 320, 56)];
    _customNameLabel.font = [UIFont systemFontOfSize:43];
    _customNameLabel.textColor = [UIColor whiteColor];
    _customNameLabel.textAlignment = NSTextAlignmentCenter;
    _customNameLabel.text = @"致 李月月";
    [headView addSubview:_customNameLabel];
    
    _adviserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(420, 265 + 177, 80, 30)];
    _adviserNameLabel.font = [UIFont systemFontOfSize:19];
    _adviserNameLabel.textColor = [UIColor blackColor];
    _adviserNameLabel.textAlignment = NSTextAlignmentCenter;
    _adviserNameLabel.text = @"马萧萧";
    [headView addSubview:_adviserNameLabel];

    _tableView.tableHeaderView = headView;

}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 330;
    }
    else if(indexPath.section == 1){
        return 140;
    }
    else{
        return 230;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TFWReportCareerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellCareerIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        TFWReportTenElementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTenElementIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configImageName:@"ftw_share_pro" Title:@"         收入丰厚" SubTitle:@"dadwadwadwadwadwa dacawaawdadawxawxawdawadxwxdawxawxdawawxawxawdawxdawxawwaawxawawxawxaw" andCheck:NO];
        return cell;
    }
    else{
        TFWReportCareerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSuggestIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 60)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(headView.frame) - 30, CGRectGetHeight(headView.frame))];
    titleLabel.textColor = [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1.0];
    titleLabel.font = [UIFont boldSystemFontOfSize:24];
    
    switch (section) {
        case 0:
            titleLabel.text = @"真选择成就事业";
            break;
        case 1:
            titleLabel.text = @"友邦十大要素";
            break;
        case 2:
            titleLabel.text = @"建议与祝愿";
            break;
            
        default:
            break;
    }
    [headView addSubview:titleLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(18, CGRectGetHeight(headView.frame) - 2, CGRectGetWidth(headView.frame) - 36, 2)];
    line.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1.0];
    [headView addSubview:line];
    
    UIButton *checkButton = [[UIButton alloc] init];
    [checkButton setImage:[UIImage imageNamed:@"ftw_share_check_null"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"ftw_share_check_ok"] forState:UIControlStateSelected];
    [checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    checkButton.frame = CGRectMake(CGRectGetWidth(headView.frame) - 50, 25, 29, 29);
    [headView addSubview:checkButton];

    
    return headView;
}

-(void)checkAction:(UIButton *)button
{
    button.selected = !button.selected;
}


@end
