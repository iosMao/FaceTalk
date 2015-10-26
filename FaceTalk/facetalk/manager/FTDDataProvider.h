//
//  FTDDataProvider.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/14.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FTDDataProvider;

typedef void(^dataProviderFinishBlock)(NSDictionary *);
typedef void(^dataProviderFailedBlock)(NSString *);

@interface FTDDataProvider : NSObject
@property(nonatomic, strong)dataProviderFinishBlock finishBlock;
@property(nonatomic, strong)dataProviderFailedBlock failedBlock;
@property(nonatomic, strong)NSDictionary *resultDict;

-(void)userLogin:(NSDictionary *)infoDic;


@end
