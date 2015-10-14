//
//  FTJsonPeopleModel.h
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTJsonMarkModel.h"

@interface FTJsonPeopleModel : NSObject

@property (nonatomic,copy) NSString *join_date;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *old_job;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,copy) NSString *share_word;
@property (nonatomic,copy) NSString *sub_company;
@property (nonatomic,copy) NSArray *markArray;
@end
