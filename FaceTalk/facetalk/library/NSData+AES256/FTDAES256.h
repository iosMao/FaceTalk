//
//  FTDAES256.h
//  AESTest
//
//  Created by Mao-MacPro on 15/12/4.
//  Copyright © 2015年 杜甲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTDAES256 : NSObject
+(NSString *)AES256EncryptWithString:(NSString *)string;//加密
+(NSString *)AES256DecryptWithString:(NSString *)string;//解密

@end
