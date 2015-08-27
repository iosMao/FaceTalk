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

@interface TFWReportView ()
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
    self = [super initWithFrame:CGRectMake(0, 0, 771, 570)];
    
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
    //_tableView.backgroundColor=[UIColor blueColor];
    
    [self createHeadView];
    
    [self addSubview:_tableView];
    
    _isShowSuggest = YES;
    _isShowTenElement = YES;
    _isShowCareer = YES;
    [self initChoickArray];
}

-(void)initChoickArray
{
    _choiceArray = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        [_choiceArray addObject:[NSNumber numberWithBool:_isShowTenElement]];
    }
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
    if (section == 0) {
        if (_endEdit && _isShowCareer == NO) {
            return 0;
        }else{
            return 1;
        }
    }
    else if (section == 1) {
        if (_endEdit) {
            if (_isShowTenElement) {
                return _selectArray.count;
            }else{
                return 0;
            }
        }
        else{
            return 10;
        }
    }else{
        if (_endEdit && _isShowSuggest == NO) {
            return 0;
        }else{
            return 1;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_endEdit) {
        if (section == 0) {
            if (_isShowCareer) {
                return 60;
            }else{
                return 0;
            }
        }else if(section == 1)
        {
            if (_isShowTenElement) {
                return 60.0;
            }else{
                return 0;
            }
        }else{
            if (_isShowSuggest) {
                return 60.0;
            }else{
                return 0;
            }
        }
    }
    
    return 60;
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
        if (_endEdit) {
            cell.userInteractionEnabled = NO;
            switch ([[_selectArray objectAtIndex:indexPath.row] integerValue]) {
                case 0:
                    [cell configImageName:@"ftw_share_money" Title:@"         收入丰厚" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 1:
                    [cell configImageName:@"ftw_share_key" Title:@"         品牌实力" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 2:
                    [cell configImageName:@"ftw_share_book" Title:@"         学习成长" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 3:
                    [cell configImageName:@"ftw_share_clock" Title:@"         工作自主" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 4:
                    [cell configImageName:@"ftw_share_start" Title:@"         社会贡献" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 5:
                    [cell configImageName:@"ftw_share_heart" Title:@"         适合度" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 6:
                    [cell configImageName:@"ftw_share_pro" Title:@"         发展空间" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 7:
                    [cell configImageName:@"ftw_share_honour" Title:@"         荣誉奖励" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 8:
                    [cell configImageName:@"ftw_share_flower" Title:@"         生活平衡" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                case 9:
                    [cell configImageName:@"ftw_share_plane" Title:@"         自由晋级" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:NO andHideCheck:YES];
                    break;
                default:
                    break;
            }
        }
        else{
            switch (indexPath.row) {
                case 0:
                    [cell configImageName:@"ftw_share_money" Title:@"         收入丰厚" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 1:
                    [cell configImageName:@"ftw_share_key" Title:@"         收入丰厚" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 2:
                    [cell configImageName:@"ftw_share_book" Title:@"         学习成长" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 3:
                    [cell configImageName:@"ftw_share_clock" Title:@"         工作自主" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 4:
                    [cell configImageName:@"ftw_share_start" Title:@"         社会贡献" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 5:
                    [cell configImageName:@"ftw_share_heart" Title:@"         适合度" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 6:
                    [cell configImageName:@"ftw_share_pro" Title:@"         发展空间" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 7:
                    [cell configImageName:@"ftw_share_honour" Title:@"         荣誉奖励" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 8:
                    [cell configImageName:@"ftw_share_flower" Title:@"         生活平衡" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 9:
                    [cell configImageName:@"ftw_share_plane" Title:@"         自由晋级" SubTitle:@"我们会继续投资在Agency,因为你们是业界最优秀的营销员，我们要把更多的精英吸引在友邦，我相信未来Agency将会继续成为友邦带领整个保险行业的旗帜，我们仍然要拓宽渠道" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                default:
                    break;
            }
            __weak TFWReportView *weakSelf = self;
            [cell setCheckBlock:^(UIButton *bt) {
                [weakSelf.choiceArray replaceObjectAtIndex:bt.tag withObject:[NSNumber numberWithBool:bt.selected]];
            }];
        }
        
        //[cell configImageName:@"ftw_share_pro" Title:@"         收入丰厚" SubTitle:@"dadwadwadwadwadwa dacawaawdadawxawxawdawadxwxdawxawxdawawxawxawdawxdawxawwaawxawawxawxaw" andCheck:NO];
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
    
    if (_endEdit == NO) {
        UIButton *checkButton = [[UIButton alloc] init];
        [checkButton setImage:[UIImage imageNamed:@"ftw_share_check_null"] forState:UIControlStateNormal];
        [checkButton setImage:[UIImage imageNamed:@"ftw_share_check_ok"] forState:UIControlStateSelected];
        [checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
        checkButton.tag = section;
        checkButton.frame = CGRectMake(CGRectGetWidth(headView.frame) - 50, 25, 29, 29);
        if (section == 1) {
            checkButton.selected = _isShowTenElement;
        }else{
            checkButton.selected = YES;
        }
        [headView addSubview:checkButton];
    }

    
    return headView;
}

-(void)checkAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.tag == 0) {
        if (button.selected) {
            _isShowCareer = YES;
        }else{
            _isShowCareer = NO;
        }
    }else if (button.tag == 1)
    {
        if (button.selected) {
            _isShowTenElement = YES;
        }else{
            _isShowTenElement = NO;
        }
        [self initChoickArray];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        if (button.selected) {
            _isShowSuggest = YES;
        }else{
            _isShowSuggest = NO;
        }
    }
}


@end
