//
//  FTWElementItem.h
//  FaceTalk
//
//  Created by wen on 15/8/18.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFWRSButtonView.h"

@interface FTWElementItem : NSObject

@property (nonatomic,assign) TenElementType type;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *iconName;
@property (nonatomic,assign) float currentScore;
@property (nonatomic,assign) float hopeScore;
@property (nonatomic,strong) NSMutableArray *orderArray;

@end
