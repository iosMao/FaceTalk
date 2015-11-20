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
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
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
    
    _customNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 202 + 170, 320, 56)];
    _customNameLabel.font = [UIFont systemFontOfSize:43];
    _customNameLabel.textColor = [UIColor whiteColor];
    _customNameLabel.textAlignment = NSTextAlignmentCenter;
    _customNameLabel.text = [NSString stringWithFormat:@"致 %@",[get_Dsp(@"DTALENTINFO")objectForKey:@"name"]];
    [headView addSubview:_customNameLabel];
    
    _adviserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(360, 265 + 174, 80, 30)];
    _adviserNameLabel.font = [UIFont systemFontOfSize:19];
    _adviserNameLabel.textColor = [UIColor blackColor];
    _adviserNameLabel.textAlignment = NSTextAlignmentCenter;
    _adviserNameLabel.text = [get_Dsp(@"DUSERINFO")objectForKey:@"USERNAME"];
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
        return 170;
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
                    [cell configImageName:@"ftw_share_money" Title:@"         收入丰厚" SubTitle:@"双百万计划：双百万奖金，只为敢拼搏、有梦想的你；\n收入水平：收获多少由付出多少决定；\n福利待遇：周全的保障及福利制度，为您倍添安心。" andCheck:NO andHideCheck:YES];
                    break;
                case 1:
                    [cell configImageName:@"ftw_share_key" Title:@"         品牌实力" SubTitle:@"公司介绍：最大的泛亚地区独立上市人寿保险集团；\n友邦历史：诞生于中国上海，根植于泛亚地区；\n友邦年报：财务业绩强劲，持续缔造佳绩；\n企业荣誉：友邦中国2014年共获近50项年度大奖；\n产品荣誉：完善的产品线满足客户多样化的需求；\n科技创新：科技助力，专业形象尽流露。" andCheck:NO andHideCheck:YES];
                    break;
                case 2:
                    [cell configImageName:@"ftw_share_book" Title:@"         学习成长" SubTitle:@"专业培训：专业的寿险培训与经验，让你发挥所有潜能；\n国际认证：高含金量的行业认证，见证您的专业；\nFUN体验：线上线下，室内室外，自由自主，随时随地；\n国际合作：国际专业培训，大师与您有约。" andCheck:NO andHideCheck:YES];
                    break;
                case 3:
                    [cell configImageName:@"ftw_share_clock" Title:@"         工作自主" SubTitle:@"自主选择职业生涯：双线发展路径，友邦虚席以待；\n自主选择时间分配：时间自主分配，精彩生活每一天；\n自主选择合作伙伴：选择投契的客户，选择志同道合的伙伴；\n自主选择工作地点：天南地北，五湖四海，都是办公室。" andCheck:NO andHideCheck:YES];
                    break;
                case 4:
                    [cell configImageName:@"ftw_share_start" Title:@"         社会贡献" SubTitle:@"寿险服务：坚守使命、抵御风险、积累财富、实现梦想；\n社会责任：以专业、诚信和爱，帮助个人、家庭和企业。" andCheck:NO andHideCheck:YES];
                    break;
                case 5:
                    [cell configImageName:@"ftw_share_heart" Title:@"         适合度" SubTitle:@"CC测评：判断目前是否是从事销售职业的最佳时机；\n岗前体验培训：“我为成功而来”体验培训助力起航；\n创业说明会（EOP）：深入探讨事业机会，直接对话成功典范。" andCheck:NO andHideCheck:YES];
                    break;
                case 6:
                    [cell configImageName:@"ftw_share_pro" Title:@"         发展空间" SubTitle:@"职涯规划：在公平开放的晋级制度下，自主掌握晋级速度；\n行业潜力：天时地利人和，迎来中国保险业的最好时代；\n公司五年规划：To Your First Choice 你我的共同愿景；\n渠道定位：打造卓越营销员团队，培养高产能营销员。" andCheck:NO andHideCheck:YES];
                    break;
                case 7:
                    [cell configImageName:@"ftw_share_honour" Title:@"         荣誉奖励" SubTitle:@"MDRT：友邦是目前全球MDRT人数最多的保险公司；\n荣誉颁奖典礼：在帮助他人、服务社会的同时，成就辉煌事业；\n寿险大会：分享、交流、学习、体验，这就是友邦的文化；\n华夏精英大会：世界那么大，我们带你一起去看看；\n双百万计划：双百万奖金，只为敢拼搏、有梦想的你；\n保险企业家论坛：怀抱初始心、执着真信念、争为行业翘楚。" andCheck:NO andHideCheck:YES];
                    break;
                case 8:
                    [cell configImageName:@"ftw_share_flower" Title:@"         生活平衡" SubTitle:@"全人理念：实现平衡圆满的人生；\n时间自主：时间自主分配，精彩生活每一天。" andCheck:NO andHideCheck:YES];
                    break;
                case 9:
                    [cell configImageName:@"ftw_share_plane" Title:@"         自由晋级" SubTitle:@"职涯规划：双线发展路径，公开、公平、公正、自主；\n闪耀新星：梦想派，来友邦！与你一起跑赢未来！ " andCheck:NO andHideCheck:YES];
                    break;
                default:
                    break;
            }
        }
        else{
            switch (indexPath.row) {
                case 0:
                    [cell configImageName:@"ftw_share_money" Title:@"         收入丰厚" SubTitle:@"双百万计划：双百万奖金，只为敢拼搏、有梦想的你；\n收入水平：收获多少由付出多少决定；\n福利待遇：周全的保障及福利制度，为您倍添安心。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 1:
                    [cell configImageName:@"ftw_share_key" Title:@"         品牌实力" SubTitle:@"公司介绍：最大的泛亚地区独立上市人寿保险集团；\n友邦历史：诞生于中国上海，根植于泛亚地区；\n友邦年报：财务业绩强劲，持续缔造佳绩；\n企业荣誉：友邦中国2014年共获近50项年度大奖；\n产品荣誉：完善的产品线满足客户多样化的需求；\n科技创新：科技助力，专业形象尽流露。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 2:
                    [cell configImageName:@"ftw_share_book" Title:@"         学习成长" SubTitle:@"专业培训：专业的寿险培训与经验，让你发挥所有潜能；\n国际认证：高含金量的行业认证，见证您的专业；\nFUN体验：线上线下，室内室外，自由自主，随时随地；\n国际合作：国际专业培训，大师与您有约。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 3:
                    [cell configImageName:@"ftw_share_clock" Title:@"         工作自主" SubTitle:@"自主选择职业生涯：双线发展路径，友邦虚席以待；\n自主选择时间分配：时间自主分配，精彩生活每一天；\n自主选择合作伙伴：选择投契的客户，选择志同道合的伙伴；\n自主选择工作地点：天南地北，五湖四海，都是办公室。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 4:
                    [cell configImageName:@"ftw_share_start" Title:@"         社会贡献" SubTitle:@"寿险服务：坚守使命、抵御风险、积累财富、实现梦想；\n社会责任：以专业、诚信和爱，帮助个人、家庭和企业。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 5:
                    [cell configImageName:@"ftw_share_heart" Title:@"         适合度" SubTitle:@"CC测评：判断目前是否是从事销售职业的最佳时机；\n岗前体验培训：“我为成功而来”体验培训助力起航；\n创业说明会（EOP）：深入探讨事业机会，直接对话成功典范。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 6:
                    [cell configImageName:@"ftw_share_pro" Title:@"         发展空间" SubTitle:@"职涯规划：在公平开放的晋级制度下，自主掌握晋级速度；\n行业潜力：天时地利人和，迎来中国保险业的最好时代；\n公司五年规划：To Your First Choice 你我的共同愿景；\n渠道定位：打造卓越营销员团队，培养高产能营销员。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 7:
                    [cell configImageName:@"ftw_share_honour" Title:@"         荣誉奖励" SubTitle:@"MDRT：友邦是目前全球MDRT人数最多的保险公司；\n荣誉颁奖典礼：在帮助他人、服务社会的同时，成就辉煌事业；\n寿险大会：分享、交流、学习、体验，这就是友邦的文化；\n华夏精英大会：世界那么大，我们带你一起去看看；\n双百万计划：双百万奖金，只为敢拼搏、有梦想的你；\n保险企业家论坛：怀抱初始心、执着真信念、争为行业翘楚。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 8:
                    [cell configImageName:@"ftw_share_flower" Title:@"         生活平衡" SubTitle:@"全人理念：实现平衡圆满的人生；\n时间自主：时间自主分配，精彩生活每一天。" andCheck:_isShowTenElement andTag:indexPath.row];
                    break;
                case 9:
                    [cell configImageName:@"ftw_share_plane" Title:@"         自由晋级" SubTitle:@"职涯规划：双线发展路径，公开、公平、公正、自主；\n闪耀新星：梦想派，来友邦！与你一起跑赢未来！" andCheck:_isShowTenElement andTag:indexPath.row];
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
