//
//  FTDWaterFullHeadView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/27.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDWaterFullHeadView.h"
#import "FTWDataManager.h"
#import "TFWSRResultView.h"
@interface FTDWaterFullHeadView ()
@property (nonatomic,strong) NSArray *roundArray;
@property (nonatomic,strong) UILabel *allRateLabel;
@property (nonatomic,strong) UILabel *careerRateLabel;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation FTDWaterFullHeadView
+(id)createWaterFullHeadView
{
    FTDWaterFullHeadView *reportView = [[FTDWaterFullHeadView alloc] initWithFrame:CGRectZero];
    
    
    return reportView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 771, 330)];
    
    if (self) {
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    [self creatHeadview];
    
    [self createFiveRound];
    
    [self createMessage];
}

-(void)creatHeadview
{
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20,5,240,20)];
    lblTitle.text =@"真选择理想事业";
    lblTitle.numberOfLines = 0;
    lblTitle.textAlignment=NSTextAlignmentLeft;
    lblTitle.font = [UIFont boldSystemFontOfSize:24];
    lblTitle.textColor = [UIColor colorWithRed:0.82 green:0.06 blue:0.27 alpha:1];
    lblTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:lblTitle];
    
    _btnHead = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 50, 0, 30, 30)];
    _btnHead.tag = 11;
    _btnHead.selected = YES;
    [_btnHead addTarget:self action:@selector(checkclick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnHead setImage:[UIImage imageNamed:@"ftw_share_check_null"] forState:UIControlStateNormal];
    [_btnHead setImage:[UIImage imageNamed:@"ftw_share_check_ok"] forState:UIControlStateSelected];
    [self addSubview:_btnHead];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 40, CGRectGetMaxX(self.frame)-40, 2)];
    
    line.backgroundColor = [UIColor colorWithRed:0.82 green:0.06 blue:0.27 alpha:1];
    [self addSubview:line];
    
}

-(void)createFiveRound
{
    CGFloat num = 150.0f;
    CGFloat start = 85.0f;
    
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    NSMutableArray *orderArray = ((FTWElementItem *)[[FTWDataManager shareManager].tenElementArray firstObject]).orderArray;
    
    for (NSNumber *number in orderArray) {
        for (FTWElementItem *item in [FTWDataManager shareManager].tenElementArray) {
            if (item.type == [number integerValue]) {
                [mutArray addObject:item];
                break;
            }
        }
    }
    
    _dataSource = [NSArray arrayWithArray:mutArray];
    
    
    NSMutableArray *round = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        TFWSRResultView *first = [TFWSRResultView createResultViewCenter:CGPointMake(start + num * i, 80+43) andTitle:((FTWElementItem *)[mutArray objectAtIndex:i]).title andText:@"满意度" andRate:((FTWElementItem *)[mutArray objectAtIndex:i]).currentScore / ((FTWElementItem *)[mutArray objectAtIndex:i]).hopeScore roundTitle:@"现状与\n期望相差" roundScore:(int)(((FTWElementItem *)[mutArray objectAtIndex:i]).hopeScore - ((FTWElementItem *)[mutArray objectAtIndex:i]).currentScore)];
        CGFloat scale = 0.30;
        first.transform = CGAffineTransformMakeScale(scale, scale);
        [round addObject:first];
        [self addSubview:first];
    }
    _roundArray = [NSArray arrayWithArray:round];
}

-(void)createMessage
{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(20, 180+43, CGRectGetMaxX(self.frame)-40, 135)];
    back.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1.0];
    [self addSubview:back];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(40, 20, 110, 4)];
    line1.backgroundColor = [UIColor whiteColor];
    [back addSubview:line1];
    
    //    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame) + 20, 20, 160, 4)];
    //    line2.backgroundColor = [UIColor whiteColor];
    //    [back addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame) + 25, 20, 284, 4)];
    line3.backgroundColor = [UIColor whiteColor];
    [back addSubview:line3];
    
    UILabel *titleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMaxY(line1.frame) + 15, CGRectGetWidth(line1.frame), 25)];
    titleLable1.font = [UIFont boldSystemFontOfSize:20];
    titleLable1.textColor = [UIColor whiteColor];
    titleLable1.textAlignment = NSTextAlignmentCenter;
    titleLable1.text = @"总体满意度";
    [back addSubview:titleLable1];
    
    //    UILabel *titleLable2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(line2.frame), CGRectGetMaxY(line2.frame) + 15, CGRectGetWidth(line2.frame), 25)];
    //    titleLable2.font = [UIFont boldSystemFontOfSize:20];
    //    titleLable2.textColor = [UIColor whiteColor];
    //    titleLable2.textAlignment = NSTextAlignmentCenter;
    //    titleLable2.text = @"职场满意度超越了";
    //    [back addSubview:titleLable2];
    
    
    UILabel *titleLable3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(line3.frame), CGRectGetMaxY(line3.frame) + 15, CGRectGetWidth(line3.frame), 25)];
    titleLable3.font = [UIFont boldSystemFontOfSize:20];
    titleLable3.textColor = [UIColor whiteColor];
    titleLable3.text = @"专家建议您";
    //[back addSubview:titleLable3];
    
    //    UILabel *subLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLable2.frame) - 15, CGRectGetMaxY(titleLable2.frame) + 2, 16, 60)];
    //    subLabel2.numberOfLines = 0;
    //    subLabel2.font = [UIFont boldSystemFontOfSize:15];
    //    subLabel2.textColor = [UIColor whiteColor];
    //    subLabel2.text = @"参与者";
    //    [back addSubview:subLabel2];
    
    
    
    _allRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLable1.frame), CGRectGetMaxX(titleLable1.frame) + 10, 60)];
    _allRateLabel.textColor = [UIColor whiteColor];
    _allRateLabel.textAlignment = NSTextAlignmentRight;
    _allRateLabel.font = [UIFont boldSystemFontOfSize:59];
    _allRateLabel.text = [NSString stringWithFormat:@"36%@",@"%"];
    [back addSubview:_allRateLabel];
    
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    for (FTWElementItem *item in [FTWDataManager shareManager].tenElementArray) {
        if (item.selected) {
            [mutArray addObject:item];
        }
    }
//    float sum = 0.0f;
//    for (int i = 0; i < 5; i++) {
//        sum += ((FTWElementItem *)[mutArray objectAtIndex:i]).currentScore / 1.0 / ((FTWElementItem *)[mutArray objectAtIndex:i]).hopeScore;
//    }
//    sum /= 5.0;
    float sum1 = 0.0f;
    float sum2 = 0.0f;
    for (int i = 0; i < 5; i++) {
        sum1 += ((FTWElementItem *)[mutArray objectAtIndex:i]).currentScore / 1.0;
        sum2 += ((FTWElementItem *)[mutArray objectAtIndex:i]).hopeScore / 1.0;
    }
    float sum = sum1 / sum2 ;
    _allRateLabel.text = [NSString stringWithFormat:@"%d%@",(int)(sum * 100),@"%"];
    
    UILabel *subLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLable3.frame), CGRectGetMaxY(titleLable3.frame)-5-23, CGRectGetWidth(line3.frame)+250, 50)];
    subLabel3.font = [UIFont boldSystemFontOfSize:18];
    subLabel3.numberOfLines=0;
    subLabel3.textColor = [UIColor whiteColor];
    //subLabel3.backgroundColor = [UIColor blueColor];
    //subLabel3.text = @" 是时候考虑下未来的职业发展啦！";
    if (sum >= 0 && sum < 0.59) {
        subLabel3.text = @"是时候考虑下未来的职业发展啦！";
        subLabel3.frame=CGRectMake(CGRectGetMinX(titleLable3.frame), CGRectGetMaxY(titleLable3.frame)-5-18, CGRectGetWidth(line3.frame)+250, 20);
    }else if (sum < 0.79){
        subLabel3.text = @"您在比较满意现有工作的同时，也可以尝试挑战新的机会！";
        subLabel3.frame=CGRectMake(CGRectGetMinX(titleLable3.frame), CGRectGetMaxY(titleLable3.frame)-5-18, CGRectGetWidth(line3.frame)+250, 20);
    }else{
        subLabel3.text = @"您目前非常满意自己的职业，您是这个领域的成功者，祝贺您！同时也建议您是时候考虑下保障和财务管理方案！";
    }
    [back addSubview:subLabel3];
    
    
    
    
    //    _careerRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLable2.frame), CGRectGetMaxY(titleLable2.frame), CGRectGetWidth(titleLable2.frame), 60)];
    //    _careerRateLabel.textColor = [UIColor whiteColor];
    //    _careerRateLabel.font = [UIFont boldSystemFontOfSize:59];
    //    _careerRateLabel.text = [NSString stringWithFormat:@"36%@",@"%"];
    //    [back addSubview:_careerRateLabel];
    
}

-(void)checkclick:(UIButton *)btn
{
    if (_checkclickBlock) {
        _checkclickBlock(btn);
    }
}


@end
