//
//  TFWReportCareerCell.m
//  demo
//
//  Created by wen on 15/8/9.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWReportCareerCell.h"
#import "TFWSRResultView.h"
#import "FTWDataManager.h"

@interface TFWReportCareerCell ()

@property (nonatomic,strong) NSArray *roundArray;
@property (nonatomic,strong) UILabel *allRateLabel;
@property (nonatomic,strong) UILabel *careerRateLabel;
@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation TFWReportCareerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    [self createFiveRound];
    
    [self createMessage];
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
        TFWSRResultView *first = [TFWSRResultView createResultViewCenter:CGPointMake(start + num * i, 80) andTitle:((FTWElementItem *)[mutArray objectAtIndex:i]).title andText:@"满意度" andRate:((FTWElementItem *)[mutArray objectAtIndex:i]).currentScore / ((FTWElementItem *)[mutArray objectAtIndex:i]).hopeScore roundTitle:@"现状与\n期望相差" roundScore:(int)(((FTWElementItem *)[mutArray objectAtIndex:i]).hopeScore - ((FTWElementItem *)[mutArray objectAtIndex:i]).currentScore)];
        CGFloat scale = 0.30;
        first.transform = CGAffineTransformMakeScale(scale, scale);
        [round addObject:first];
        [self.contentView addSubview:first];
    }
    _roundArray = [NSArray arrayWithArray:round];
}

-(void)createMessage
{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 735, 135)];
    back.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1.0];
    [self.contentView addSubview:back];
    
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

    
    UILabel *titleLable3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(line3.frame), CGRectGetMaxY(line3.frame) + 10, CGRectGetWidth(line3.frame), 25)];
    titleLable3.font = [UIFont boldSystemFontOfSize:20];
    titleLable3.textColor = [UIColor whiteColor];
    titleLable3.text = @"专家建议您";
    [back addSubview:titleLable3];

//    UILabel *subLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLable2.frame) - 15, CGRectGetMaxY(titleLable2.frame) + 2, 16, 60)];
//    subLabel2.numberOfLines = 0;
//    subLabel2.font = [UIFont boldSystemFontOfSize:15];
//    subLabel2.textColor = [UIColor whiteColor];
//    subLabel2.text = @"参与者";
//    [back addSubview:subLabel2];
    
    UILabel *subLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLable3.frame), CGRectGetMaxY(titleLable3.frame) + 5, 500, 50)];
    subLabel3.numberOfLines = 0;
    subLabel3.font = [UIFont boldSystemFontOfSize:18];
    subLabel3.textColor = [UIColor whiteColor];
    
    [back addSubview:subLabel3];

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
    float sum = 0.0f;
    for (int i = 0; i < 5; i++) {
        sum += ((FTWElementItem *)[mutArray objectAtIndex:i]).currentScore / 1.0 / ((FTWElementItem *)[mutArray objectAtIndex:i]).hopeScore;
    }
    sum /= 5.0;
    _allRateLabel.text = [NSString stringWithFormat:@"%d%@",(int)(sum * 100),@"%"];
    
    if (sum > 0 && sum < 0.59) {
        subLabel3.text = @"专家建议您是时候考虑下为了的职业发展啦！";
    }else if (sum < 0.79){
        subLabel3.text = @"专家认为您目前非常满意现有工作的同时，也可以尝试挑战新的机会！";
    }else{
        subLabel3.text = @"专家认为您目前非常满意自己的职业，您是工作中得成功者，祝贺您！同时也建议您是时候考虑下保障和财务管理方案！";
    }

    
//    _careerRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLable2.frame), CGRectGetMaxY(titleLable2.frame), CGRectGetWidth(titleLable2.frame), 60)];
//    _careerRateLabel.textColor = [UIColor whiteColor];
//    _careerRateLabel.font = [UIFont boldSystemFontOfSize:59];
//    _careerRateLabel.text = [NSString stringWithFormat:@"36%@",@"%"];
//    [back addSubview:_careerRateLabel];

}

@end
