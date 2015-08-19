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

@property (nonatomic,strong) NSArray *tenElementArray;

@end

static FTWDataManager *shareManager;

@implementation FTWDataManager

+(FTWDataManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[FTWDataManager alloc] init];

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
}

@end
