//
//  FTDKeyChain.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/12/14.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
@interface FTDKeyChain : NSObject
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end
