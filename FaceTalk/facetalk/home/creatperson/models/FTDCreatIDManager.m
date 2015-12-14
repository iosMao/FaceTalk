//
//  FTDCreatIDManager.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/4.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDCreatIDManager.h"

@implementation FTDCreatIDManager
+(NSString *)creatTalentId
{
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *  locationString = [dateformatter stringFromDate:senddate];
    NSLog(@"locationString:%@",locationString);
    
    NSString *strId = [NSString stringWithFormat:@"%@%@",identifierStr,locationString];
    return strId;
    
    
}
+(NSString *)creatImageName
{
    NSDate *senddate = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *str = [formatter stringFromDate:senddate];
    return str;
    
    
   
    
    
}
@end
