//
//  FTDChangePrice.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/19.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTDChangePrice : NSObject
+(NSString *)changePriceFromint:(int)price;
+(int)priceToInt:(int)value;
@end
