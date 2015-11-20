//
//  FTDChangeDate.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/5.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTDChangeDate : NSObject
+(NSString *)dateStr:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)dateString;
@end
