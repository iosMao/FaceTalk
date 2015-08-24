//
//  FTJsonSubClassModel.m
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTJsonSubClassModel.h"
#import "FTJsonManager.h"
#import "FTDDataPacketManager.h"
@implementation FTJsonSubClassModel

-(void)setPeoples:(NSArray *)peoples
{
    _peoples = peoples;
    NSMutableArray *mutArray = [NSMutableArray new];
    for (NSDictionary *dict in peoples) {
        FTJsonPeopleModel *model = [FTJsonPeopleModel new];
        model.join_date = [dict objectForKey:@"join_date"];
        model.name = [dict objectForKey:@"name"];
        model.markArray = [dict objectForKey:@"newMark"];
        model.old_job = [dict objectForKey:@"old_job"];
        model.old_mark = [dict objectForKey:@"old_mark"];
         model.picture = [NSString stringWithFormat:@"%@%@",[self basePath],[dict objectForKey:@"picture"]];
        //model.picture = [dict objectForKey:@"picture"];
        model.share_word = [dict objectForKey:@"share_word"];
        [mutArray addObject:model];
    }
    
    _peoples = mutArray;
    _peoples_count = (int)_peoples.count;
    
}

-(FTJsonSubClassModel *)getPeoplesItemAtIndex:(int)index
{
    if (index >= _peoples_count) {
        return nil;
    }
    _peoples_index = index;
    return [_peoples objectAtIndex:index];
}
-(NSString *)basePath
{
    NSString *file1=[[FTDDataPacketManager sharedInstance]basePath];
    return file1;
}
@end
