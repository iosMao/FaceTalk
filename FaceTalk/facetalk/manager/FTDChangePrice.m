//
//  FTDChangePrice.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/19.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDChangePrice.h"

@implementation FTDChangePrice
+(NSString *)changePriceFromint:(int)price
{
    int count = 0;
    NSString *num = [NSString stringWithFormat:@"%d",price];
    long long int a = num.longLongValue;
    while (a != 0){
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;

    
    
    
}

+(int)priceToInt:(int)value
{
    int i = 0;
    if (value == 0) {
        i = 0;
    }
    else if (value > 0 && value <= 1000) {
        i = 1000;
    }
    else if (value > 1000 && value <= 20000)
    {
        i = (value+500)/1000*1000;
        
        //round(i);
        NSLog(@"%d",i);
    }
    return i;
    
}


@end
