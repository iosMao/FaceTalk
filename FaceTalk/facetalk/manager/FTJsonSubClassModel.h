//
//  FTJsonSubClassModel.h
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTJsonPeopleModel.h"

@interface FTJsonSubClassModel : NSObject

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *peoples;

@property (nonatomic,assign) int peoples_count;
@property (nonatomic,assign) int peoples_index;
-(FTJsonPeopleModel *)getPeoplesItemAtIndex:(int)index;

@end
