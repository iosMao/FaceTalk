//
//  FTJsonExcellentModel.m
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTJsonExcellentModel.h"
#import "FTJsonManager.h"
#import "FTDDataPacketManager.h"
@interface FTJsonExcellentModel ()



@end

@implementation FTJsonExcellentModel

-(void)setSubClassArray:(NSArray *)subClassArray
{
    _subClassArray = subClassArray;
    NSMutableArray *mutArr = [NSMutableArray new];
    for (NSDictionary *dict in _subClassArray) {
        FTJsonSubClassModel *model = [FTJsonSubClassModel new];
        model.name = [dict objectForKey:@"name"];
       model.icon = [NSString stringWithFormat:@"%@%@",[self basePath],[dict objectForKey:@"icon"]];
        //model.icon = [dict objectForKey:@"icon"];
        model.peoples = [dict objectForKey:@"peoples"];
        [mutArr addObject:model];
    }
    
    _subClassArray = [NSArray arrayWithArray:mutArr];
    _subClass_count = (int)_subClassArray.count;
}

-(FTJsonSubClassModel *)getSubClassItemAtIndex:(int)index
{
    if (index >= _subClass_count) {
        return nil;
    }
    _subClass_index = index;
    return [_subClassArray objectAtIndex:index];
}
-(NSString *)basePath
{
    NSString *file1=[[FTDDataPacketManager sharedInstance]basePath];
    return file1;
}
@end
