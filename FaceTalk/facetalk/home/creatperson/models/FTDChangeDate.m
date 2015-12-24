//
//  FTDChangeDate.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/5.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDChangeDate.h"

@implementation FTDChangeDate
+(NSString *)dateStr:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSDate *)dateFromString:(NSString *)dateString{
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600*8];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    //NSString *str = @"2015-11-11";
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}


@end
