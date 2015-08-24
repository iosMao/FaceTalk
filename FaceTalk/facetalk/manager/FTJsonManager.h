//
//  FTJsonManager.h
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTJsonElementModel.h"
#import "FTJsonExcellentModel.h"

@interface FTJsonManager : NSObject

@property (nonatomic,readonly) NSString *index_background;
@property (nonatomic,readonly) NSArray *ten_objective_elements;
@property (nonatomic,readonly) NSArray *ten_aia_elements;
@property (nonatomic,readonly) NSArray *guide_page;

@property (nonatomic,assign) int excellence_count;
@property (nonatomic,assign) int excellence_index;

+(FTJsonManager *)shareManager;
-(NSString *)basePath;
-(FTJsonExcellentModel *)getElementItemAtIndex:(int)index;

@end
