//
//  FTJsonPeopleModel.m
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTJsonPeopleModel.h"

@implementation FTJsonPeopleModel



-(void)setMarkArray:(NSArray *)markArray
{
    NSMutableArray *mutArray = [NSMutableArray new];
    for (NSDictionary *dict in markArray) {
        FTJsonMarkModel *model = [FTJsonMarkModel new];
        model.old_mark = [[dict objectForKey:@"old_mark"] integerValue];
        model.new_mark = [[dict objectForKey:@"new_mark"] integerValue];
        model.name = [dict objectForKey:@"name"];
        model.desc = [dict objectForKey:@"desc"];
        [mutArray addObject:model];
    }
    
    _markArray = mutArray;

}

@end
