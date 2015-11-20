//
//  FTDDBManager.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/2.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDDBManager.h"
#import "Person.h"
#import "Report.h"
#import "FTDChangeDate.h"
@implementation FTDDBManager
+(void)NetaddToLocalDB:(NSDictionary *)dic//网上的人才库拉进本地的人才库
{
    Person *person = [Person MR_createEntity];
    person.name = [dic objectForKey:@"name"];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:[dic objectForKey:@"sex"]];
    person.sex = myNumber;
    person.birthday = [FTDChangeDate dateFromString:[dic objectForKey:@"birthday"]];
    person.personid = [dic objectForKey:@"id"];
    person.chattime = [FTDChangeDate dateFromString:[dic objectForKey:@"chatTime"]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}
+(NSArray *)searchLocalDB//查询本地的人才库
{
    NSArray *persons = [Person MR_findAll];
    return persons;
}
+(void)LocalAddToDB:(NSDictionary *)dic//本地新增对象到本地人才库
{
    Person *person = [Person MR_createEntity];
    person.name = [dic objectForKey:@"name"];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:[dic objectForKey:@"sex"]];
    person.sex = myNumber;
    person.birthday = [dic objectForKey:@"birthday"];
    person.personid = [dic objectForKey:@"personid"];
    person.chattime = [dic objectForKey:@"chattime"];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}
+(NSArray *)searchLocalDBWithKeys:(NSPredicate *)predicate//本地数据库关键字搜索
{
    NSArray *array = [Person MR_findAllWithPredicate:predicate];
    return array;

}

+(void)addImageUrl:(NSString *)urlstr andToTalentId:(NSString *)talentid
{
    NSArray *persons = [Person MR_findByAttribute:@"personid" withValue:talentid];

    Person *person = [persons objectAtIndex:0];//找到那个人
    
    //NSManagedObjectContext *context = [person managedObjectContext];
    
    //Report *report = [Report MR_createEntityInContext:context];
    Report *report = [Report MR_createEntity];
    report.imgurl = urlstr;
    
    NSMutableOrderedSet *mutset = [person.report mutableCopy];
    [mutset addObject:report];
    person.report = [mutset copy];
    
//    NSDate *senddate = [NSDate date];
//    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *  locationString = [dateformatter stringFromDate:senddate];
//    NSLog(@"locationString:%@",locationString);
//    NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc] init];
//    [dateformatter1 setDateFormat:@"YYYY-MM-dd"];
//    NSDate *destDate = [dateformatter1 dateFromString:locationString];
//    person.chattime = destDate;
    
    
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
    
    
}

@end
