//
//  FTDDBManager.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/2.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
@interface FTDDBManager : NSObject
+(void)NetaddToLocalDB:(NSDictionary *)dic;//网上的人才库拉进本地的人才库
+(NSArray *)searchLocalDB;//查询本地的人才库
+(void)LocalAddToDB:(NSDictionary *)dic;//本地新增对象到本地人才库
+(NSArray *)searchLocalDBWithKeys:(NSPredicate *)predicate;//本地数据库关键字搜索
+(NSString *)localDBisContainTalent:(NSDictionary *)dic;
+(void)addImageUrl:(NSString *)urlstr andToTalentId:(NSString *)talentid;//本地照片url添加进本地数据库
+(void)changeTalentIsPushContain:(Person *)person;
@end
