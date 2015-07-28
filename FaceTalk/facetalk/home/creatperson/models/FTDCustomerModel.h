//
//  FTDCustomerModel.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/22.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTDCustomerModel : NSObject

@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *birthday;

@end
