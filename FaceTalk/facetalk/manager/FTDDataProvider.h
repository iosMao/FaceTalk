//
//  FTDDataProvider.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/14.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Report.h"
@class FTDDataProvider;

typedef void(^dataProviderFinishBlock)(NSDictionary *);
typedef void(^dataProviderFailedBlock)(NSString *);

@interface FTDDataProvider : NSObject
@property(nonatomic, strong)dataProviderFinishBlock finishBlock;
@property(nonatomic, strong)dataProviderFailedBlock failedBlock;
@property(nonatomic, strong)NSDictionary *resultDict;
@property(nonatomic, strong)NSArray *personArray;
@property(nonatomic, assign)NSInteger index;
@property(nonatomic, assign)NSInteger indexPeople;
@property(nonatomic, assign)NSInteger indexReport;
@property(nonatomic, copy)NSString *path;
@property(nonatomic ,strong)Person *personInfo;


-(void)userLogin:(NSDictionary *)infoDic;
-(void)getTalents:(NSString *)agentId;
-(void)pushTalentsInfo:(Person *)person;
-(void)pushTalentsInfoArray:(NSArray *)personArray;//上传人才库

-(void)pullTalentsInfoArray:(NSArray *)talentArray;//下拉人才库


@end
