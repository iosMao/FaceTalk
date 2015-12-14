//
//  TFWReportDemo.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/26.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "TFWReportDemo.h"
#import "FTDWaterFullHeadView.h"
#import "FTDAES256.h"
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
@interface TFWReportDemo ()
{
    NSMutableArray *arrayList;
}
@property (nonatomic,strong) UIView *headView1;
@property (nonatomic,strong) UIView *headView2;
@property (nonatomic,strong) UIView *headView3;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,assign) BOOL isShow_head1;
@property (nonatomic,assign) BOOL isShow_head2;
@property (nonatomic,assign) BOOL isShow_head3;
@property (nonatomic,assign) BOOL isShow_foot;

@property (nonatomic,strong) WaterFullCell *heightCell;
@property (nonatomic,strong) UILabel *customNameLabel;
@property (nonatomic,strong) UILabel *adviserNameLabel;
@property (nonatomic,strong) NSMutableArray *choiceArray;

@end

@implementation TFWReportDemo

+(id)createReportDemo
{
    TFWReportDemo *reportView = [[TFWReportDemo alloc] initWithFrame:CGRectZero];
    
    return reportView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 771, 570)];
    
    if (self) {
        self.isShow_head1 = YES;
        self.isShow_head2 = YES;
        self.isShow_head3 = YES;
        self.isShow_foot = YES;
        [self initView];
        
    }
    
    return self;
}

-(void)initView{
    [self initChoickArray];
    _heightCell = [[WaterFullCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) / 2.0, 40)];
    
    _waterFull = [WaterFullView createWaterFullWithFrame:self.bounds headView:nil footView:nil];
    [_waterFull setHeadView:[self creatHeadView]];
    [_waterFull setFootView:[self creatFootView]];
    [self addSubview:_waterFull];
    _waterFull.dataSource = self;
    
    arrayList = [[NSMutableArray alloc] init];
    [arrayList addObject:@{@"title":@"  学习成长",@"imgname":@"FTD_report_learn.png"}];
    [arrayList addObject:@{@"title":@"  收入丰厚",@"imgname":@"FTD_report_earnmoney.png"}];
    [arrayList addObject:@{@"title":@"  生活平衡",@"imgname":@"FTD_report_live balance.png"}];
    [arrayList addObject:@{@"title":@"  发展空间",@"imgname":@"FTD_report_developspace.png"}];
    [arrayList addObject:@{@"title":@"  适合度"  ,@"imgname":@"FTD_report_suit.png"}];
    [arrayList addObject:@{@"title":@"  荣誉奖励",@"imgname":@"FTD_report_honourreward.png"}];
    [arrayList addObject:@{@"title":@"  工作自主",@"imgname":@"FTD_report_workfree.png"}];
    [arrayList addObject:@{@"title":@"  社会贡献",@"imgname":@"FTD_report_socity.png"}];
    [arrayList addObject:@{@"title":@"  自主晋级",@"imgname":@"FTD_report_freeup.png"}];
    [arrayList addObject:@{@"title":@"  品牌实力",@"imgname":@"FTD_report_logopower.png"}];
    [_waterFull reloadData];
}

-(void)initChoickArray
{
    _choiceArray = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        [_choiceArray addObject:[NSNumber numberWithBool:YES]];
    }
}


-(UIView *)creatHeadView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 771, 407 + 177 + 360 + 100)];
    view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0];
    //第一块view 致xxx  友邦 xxx敬上
    if (_isShow_head1) {
        if (_headView1 == nil) {
            _headView1 = [self creatHeadView1];
        }
        [view addSubview:_headView1];
    }
    
    //第二块view 五个要素评分的
    if (_isShow_head2) {
        if (_headView2 == nil) {
            _headView2 = [FTDWaterFullHeadView createWaterFullHeadView];
            __weak TFWReportDemo *weakself = self;
             
            [((FTDWaterFullHeadView *)_headView2) setCheckclickBlock:^(UIButton *btn) {
                __strong TFWReportDemo *strongself = weakself;
                [strongself checkAction:btn];
                
            }];
        }
        CGFloat height = 0.0f;
        if (view.subviews.count > 0) {
            height = CGRectGetMaxY(view.subviews.lastObject.frame);
        }
        _headView2.frame = CGRectMake(0, height , 771, 360);
        _headView2.backgroundColor = [UIColor whiteColor];
        [view addSubview:_headView2];
    }
    
    
    
    
    //第三块 瀑布流的head
    
    if (_isShow_head3) {
        if (_headView3 == nil) {
            _headView3 = [[UIView alloc]initWithFrame:CGRectMake(0, _headView2.frame.origin.y+_headView2.frame.size.height, 771, 80)];
            UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20,20,240,30)];
            lblTitle.text =@"真精彩友我邦你";
            lblTitle.numberOfLines = 0;
            lblTitle.textAlignment=NSTextAlignmentLeft;
            lblTitle.font = [UIFont boldSystemFontOfSize:24];
            lblTitle.textColor = [UIColor colorWithRed:0.82 green:0.06 blue:0.27 alpha:1];
            lblTitle.backgroundColor = [UIColor clearColor];
            [_headView3 addSubview:lblTitle];
            
             UIButton *btnHead3 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_headView3.frame) - 50, 15, 30, 30)];
            btnHead3.tag = 20;
            btnHead3.selected = YES;
            [btnHead3 addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
            [btnHead3 setImage:[UIImage imageNamed:@"ftw_share_check_null"] forState:UIControlStateNormal];
            [btnHead3 setImage:[UIImage imageNamed:@"ftw_share_check_ok"] forState:UIControlStateSelected];
            [_headView3 addSubview:btnHead3];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, lblTitle.frame.origin.y+lblTitle.frame.size.height+15, CGRectGetMaxX(view.frame)-40, 2)];
            line.backgroundColor = [UIColor colorWithRed:0.82 green:0.06 blue:0.27 alpha:1];
            [_headView3 addSubview:line];
            
        }
        CGFloat height = 0.0f;
        if (view.subviews.count > 0) {
            height = CGRectGetMaxY(view.subviews.lastObject.frame);
        }
        _headView3.backgroundColor = [UIColor whiteColor];
        _headView3.frame = CGRectMake(0, height, 771, 80);
        [view addSubview:_headView3];
    }
    CGFloat height = 0.0f;
    if (view.subviews.count > 0) {
        height = CGRectGetMaxY(view.subviews.lastObject.frame);
    }
    view.frame = CGRectMake(0, 0, 711, height);
    
    if (_isEndEdit) {
        ((FTDWaterFullHeadView *)_headView2).btnHead.hidden = YES;
        UIButton *bt = (UIButton *)[_headView3 viewWithTag:20];
        
        bt.hidden = YES;
    }
    
    
    return view;
}
-(UIView *)creatHeadView1
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
    
    _adviserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(225-90, 265 + 174, 500, 30)];
    //_adviserNameLabel.backgroundColor = [UIColor blueColor];
    _adviserNameLabel.font = [UIFont systemFontOfSize:20];
    _adviserNameLabel.textColor = [UIColor blackColor];
    _adviserNameLabel.textAlignment = NSTextAlignmentCenter;
    //_adviserNameLabel.text = @"张怡";
    NSString *str = [FTDAES256 AES256DecryptWithString:[get_Dsp(@"DUSERINFO")objectForKey:@"USERNAME"]];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    _adviserNameLabel.text = [NSString stringWithFormat:@"友邦保险 %@ 敬上",str];
    [headView addSubview:_adviserNameLabel];
     
    
    return headView;
    
    
    
    
}
-(void)creatHeadView2
{
    
    
    
}
-(UIView *)creatFootView
{
    if (_isShow_foot) {
        if (_footView == nil) {
            _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 771, 440)];
            _footView.backgroundColor = [UIColor whiteColor];
            UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20,20,240,30)];
            lblTitle.text =@"建议与祝愿";
            lblTitle.numberOfLines = 0;
            lblTitle.textAlignment=NSTextAlignmentLeft;
            lblTitle.font = [UIFont boldSystemFontOfSize:24];
            lblTitle.textColor = [UIColor colorWithRed:0.82 green:0.06 blue:0.27 alpha:1];
            lblTitle.backgroundColor = [UIColor clearColor];
            [_footView addSubview:lblTitle];
            
            UIButton *btnFood = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_footView.frame) - 50, 15, 30, 30)];
            btnFood.tag = 30;
            btnFood.selected = YES;
            [btnFood addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
            [btnFood setImage:[UIImage imageNamed:@"ftw_share_check_null"] forState:UIControlStateNormal];
            [btnFood setImage:[UIImage imageNamed:@"ftw_share_check_ok"] forState:UIControlStateSelected];
            [_footView addSubview:btnFood];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, lblTitle.frame.origin.y+lblTitle.frame.size.height+15, CGRectGetMaxX(_footView.frame)-40, 2)];
            
            line.backgroundColor = [UIColor colorWithRed:0.82 green:0.06 blue:0.27 alpha:1];
            [_footView addSubview:line];
            
            UITextView *textView = [[UITextView alloc] init];
            textView.layer.masksToBounds = YES;
            textView.layer.borderColor = [UIColor grayColor].CGColor;
            textView.layer.borderWidth = 1.0f;
            [_footView addSubview:textView];
            textView.frame = CGRectMake(20, 75, CGRectGetWidth(_footView.frame) - 40, 300);
        }
    }
    
    UIButton *bt = (UIButton *)[_footView viewWithTag:30];
    if (_isEndEdit) {
        bt.hidden = YES;
    }
    return _isShow_foot ? _footView : nil;
    
}

-(void)checkAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.tag == 11) {
        if (btn.selected) {
            _isShow_head2 = YES;
        }
        else{
            _isShow_head2 = NO;
        }
    }
    else if (btn.tag == 20) {
        if (btn.selected) {
            _isShow_head3 = YES;
        }
        else{
            _isShow_head3 = NO;
        }
        
        _choiceArray = [NSMutableArray new];
        for (int i = 0; i < 10; i++) {
            [_choiceArray addObject:[NSNumber numberWithBool:btn.selected]];
        }
        [_waterFull reloadData];
    }
    else if (btn.tag == 30)
    {
        if (btn.selected) {
            _isShow_foot = YES;
        }
        else{
            _isShow_foot = NO;
        }

    }
    else{
        [_choiceArray replaceObjectAtIndex:btn.tag - 101 withObject:[NSNumber numberWithBool:btn.selected]];
        _isShow_head3 = NO;
        for (int m = 0; m < _choiceArray.count; m++) {
            if ([[_choiceArray objectAtIndex:m] boolValue]) {
                _isShow_head3 = YES;
            }
        }
        [_waterFull reloadData];
    }
    
    [btn.superview layoutIfNeeded];
}





-(NSInteger)numberOfRowInWaterFullView:(WaterFullView *)waterFullView{
    return arrayList.count;
}

-(CGFloat)heightForRowInWaterFullView:(WaterFullView *)waterFullView inRow:(NSInteger)row{
    NSLog(@"%f",[_heightCell setHead:@"学习成长" ImageName:@"ftw_share_head"]);
    
    return [_heightCell setHead:@"学习成长" ImageName:[NSString stringWithFormat:@"%@",[[arrayList objectAtIndex:row] objectForKey:@"imgname"]]];
}

-(UIView *)cellForRowInWaterFullView:(WaterFullView *)waterFullView inRow:(NSInteger)row{
    WaterFullCell *cell = [[WaterFullCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) / 2.0, 30)];
    [cell.headButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.headButton.tag = 101 + row;
    if (_isEndEdit) {
        cell.headButton.hidden = YES;
    }
    else{
        cell.headButton.hidden = NO;
    }
    cell.headButton.selected = [[_choiceArray objectAtIndex:row] boolValue];
    [cell setHead:[[arrayList objectAtIndex:row] objectForKey:@"title"] ImageName:[NSString stringWithFormat:@"%@",[[arrayList objectAtIndex:row] objectForKey:@"imgname"]]];
    return cell;
}
-(void)reloadData
{
    [_waterFull setHeadView:[self creatHeadView]];
    [_waterFull setFootView:[self creatFootView]];
    
    NSMutableArray *dataArray = [arrayList mutableCopy];
    arrayList = [NSMutableArray new];
    for (int i = 0; i < dataArray.count; i++) {
        if ([[_choiceArray objectAtIndex:i] boolValue]) {
            [arrayList addObject:[dataArray objectAtIndex:i]];
        }
    }
    [_waterFull reloadData];
}



@end
