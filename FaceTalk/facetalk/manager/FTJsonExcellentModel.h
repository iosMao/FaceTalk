//
//  FTJsonExcellentModel.h
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTJsonSubClassModel.h"

@interface FTJsonExcellentModel : NSObject

@property (nonatomic,copy) NSString *index;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSArray *subClassArray;
@property (nonatomic,assign) int subClass_count;
@property (nonatomic,assign) int subClass_index;
-(FTJsonSubClassModel *)getSubClassItemAtIndex:(int)index;

@end
