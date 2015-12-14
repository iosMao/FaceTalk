//
//  FTDkeyChainManager.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/12/14.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTDkeyChainManager : NSObject
+(void)savePassWord:(NSString *)password;
+(id)readPassWord;
+(void)deletePassWord;
@end
