//
//  FTJsonPeopleModel.m
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTJsonPeopleModel.h"

@implementation FTJsonPeopleModel

-(void)setOld_mark:(NSArray *)old_mark
{
    NSMutableArray *mutArray = [NSMutableArray new];
    for (NSDictionary *dict in old_mark) {
        FTJsonMarkModel *model = [FTJsonMarkModel new];
        model.mark = [[dict objectForKey:@"mark"] integerValue];
        model.name = [dict objectForKey:@"name"];
        [mutArray addObject:model];
    }
    
    _old_mark = mutArray;
}

-(void)setMarkArray:(NSArray *)markArray
{
    NSMutableArray *mutArray = [NSMutableArray new];
    for (NSDictionary *dict in markArray) {
        FTJsonMarkModel *model = [FTJsonMarkModel new];
        model.mark = [[dict objectForKey:@"mark"] integerValue];
        model.name = [dict objectForKey:@"name"];
        [mutArray addObject:model];
    }
    
    _markArray = mutArray;

}

@end
