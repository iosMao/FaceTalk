//
//  FTWDataManager.h
//  FaceTalk
//
//  Created by wen on 15/8/18.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFWOrderModel.h"
#import "FTWElementItem.h"

@interface FTWDataManager : NSObject

@property (nonatomic,strong) NSArray *tenElementArray;

+(FTWDataManager *)shareManager;

//定制面谈排序
-(BOOL)saveSelectOrder:(TFWOrderModel *)order;
-(TFWOrderModel *)selectOrder;

@end
