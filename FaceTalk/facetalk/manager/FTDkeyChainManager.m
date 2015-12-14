//
//  FTDkeyChainManager.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/12/14.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDkeyChainManager.h"
#import "FTDKeyChain.h"
static NSString * const KEY_IN_KEYCHAIN = @"com.maoyundong.app.allinfo";
static NSString * const KEY_PASSWORD = @"com.maoyundong.app.password";
@implementation FTDkeyChainManager
+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [FTDKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[FTDKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [FTDKeyChain delete:KEY_IN_KEYCHAIN];
}
@end
