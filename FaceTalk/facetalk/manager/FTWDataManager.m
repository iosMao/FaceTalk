//
//  FTWDataManager.m
//  FaceTalk
//
//  Created by wen on 15/8/18.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTWDataManager.h"

#define TFWSelectOrderUserDefault @"TFWSelectOrderUserDefault"

@interface FTWDataManager ()

@end

static FTWDataManager *shareManager;

@implementation FTWDataManager

+(FTWDataManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[FTWDataManager alloc] init];
        [shareManager createTenElementArray];
    });
    
    return shareManager;
}

-(BOOL)saveSelectOrder:(TFWOrderModel *)order
{
    if (order.first != order.second && order.second != order.third && order.third != order.fourth && order.fourth != order.first && order.first != order.third && order.second != order.fourth) {
        NSDictionary *dict = @{@"first":[NSNumber numberWithInteger:order.first],@"second":[NSNumber numberWithInteger:order.second],@"third":[NSNumber numberWithInteger:order.third],@"fourth":[NSNumber numberWithInteger:order.fourth]};
        
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:TFWSelectOrderUserDefault];
        
        return YES;
    }
    
    return NO;
}

-(TFWOrderModel *)selectOrder
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:TFWSelectOrderUserDefault];
    TFWOrderModel *model = [[TFWOrderModel alloc] init];
    if (dict == nil) {
        model.first = 1;
        model.second = 2;
        model.third = 3;
        model.fourth = 4;
    }
    else{
        model.first = [[dict objectForKey:@"first"] integerValue];
        model.second = [[dict objectForKey:@"second"] integerValue];
        model.third = [[dict objectForKey:@"third"] integerValue];
        model.fourth = [[dict objectForKey:@"fourth"] integerValue];
    }
    
    return model;
}

-(void)createTenElementArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    FTWElementItem *item1 = [[FTWElementItem alloc] init];
    FTWElementItem *item2 = [[FTWElementItem alloc] init];
    FTWElementItem *item3 = [[FTWElementItem alloc] init];
    FTWElementItem *item4 = [[FTWElementItem alloc] init];
    FTWElementItem *item5 = [[FTWElementItem alloc] init];
    FTWElementItem *item6 = [[FTWElementItem alloc] init];
    FTWElementItem *item7 = [[FTWElementItem alloc] init];
    FTWElementItem *item8 = [[FTWElementItem alloc] init];
    FTWElementItem *item9 = [[FTWElementItem alloc] init];
    FTWElementItem *item10 = [[FTWElementItem alloc] init];
    
    [array addObject:item1];
    [array addObject:item2];
    [array addObject:item3];
    [array addObject:item4];
    [array addObject:item5];
    [array addObject:item6];
    [array addObject:item7];
    [array addObject:item8];
    [array addObject:item9];
    [array addObject:item10];
    
    _tenElementArray = [NSArray arrayWithArray:array];
    
    item1.type = TenElementTypeBrand;
    item2.type = TenElementTypeFree;
    item3.type = TenElementTypeHonour;
    item4.type = TenElementTypeIncome;
    item5.type = TenElementTypeLearn;
    item6.type = TenElementTypeLife;
    item7.type = TenElementTypeSocity;
    item8.type = TenElementTypeSpace;
    item9.type = TenElementTypeSuit;
    item10.type = TenElementTypeWork;
    
    item1.title = @"品牌实力";
    item2.title = @"自由晋级";
    item3.title = @"荣誉奖励";
    item4.title = @"收入丰厚";
    item5.title = @"学习成长";
    item6.title = @"生活平衡";
    item7.title = @"社会贡献";
    item8.title = @"发展空间";
    item9.title = @"适合度";
    item10.title = @"工作自主";
    
    item1.iconName = @"tfw_rs_brand";
    item2.iconName = @"tfw_rs_free";
    item3.iconName = @"tfw_rs_honour";
    item4.iconName = @"tfw_rs_income";
    item5.iconName = @"tfw_rs_learn";
    item6.iconName = @"tfw_rs_life";
    item7.iconName = @"tfw_rs_socity";
    item8.iconName = @"tfw_rs_space";
    item9.iconName = @"tfw_rs_suit";
    item10.iconName = @"tfw_rs_work";
    
    item1.currentScore = 5.0;
    item2.currentScore = 5.0;
    item3.currentScore = 5.0;
    item4.currentScore = 5.0;
    item5.currentScore = 5.0;
    item6.currentScore = 5.0;
    item7.currentScore = 5.0;
    item8.currentScore = 5.0;
    item9.currentScore = 5.0;
    item10.currentScore = 5.0;
    
    item1.hopeScore = 5.0;
    item2.hopeScore = 5.0;
    item3.hopeScore = 5.0;
    item4.hopeScore = 5.0;
    item5.hopeScore = 5.0;
    item6.hopeScore = 5.0;
    item7.hopeScore = 5.0;
    item8.hopeScore = 5.0;
    item9.hopeScore = 5.0;
    item10.hopeScore = 5.0;
}

@end
