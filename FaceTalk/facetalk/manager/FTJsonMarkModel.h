//
//  FTJsonMarkModel.h
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTJsonMarkModel : NSObject

@property (nonatomic,assign) NSInteger old_mark;
@property (nonatomic,assign) NSInteger new_mark;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *desc;

@end
