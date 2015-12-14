//
//  FTDAES256.m
//  AESTest
//
//  Created by Mao-MacPro on 15/12/4.
//  Copyright © 2015年 杜甲. All rights reserved.
//

#import "FTDAES256.h"
#import "NSData+Encryption.h"

@implementation FTDAES256

+(NSString *)AES256EncryptWithString:(NSString *)string//加密
{
    NSData *plainTextData = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte keyByte[] = { 0x09, 0x06, 0x00, 0x04, 0x0b, 0x03, 0x05, 0x0c,
        0x07, 0x01, 0x0a, 0x05, 0x0a, 0x0b, 0x0b, 0x02, 0x0b, 0x00,
        0x0c, 0x09, 0x0b, 0x06, 0x01, 0x0c, 0x0d, 0x0d, 0x08, 0x03,
        0x0a, 0x0a, 0x0f, 0x0e };
    NSData *keyData = [[NSData alloc] initWithBytes:keyByte length:32];
    //byte转换为NSData类型，以便下边加密方法的调用
    NSData *cipherTextData = [plainTextData AES256EncryptWithKey:keyData];
    NSString *resultStr = [FTDAES256 stringFromData:cipherTextData];
    return resultStr;
}
+(NSString *)AES256DecryptWithString:(NSString *)string//解密
{
    NSData *data = [FTDAES256 dataFromString:string];
    Byte keyByte[] = { 0x09, 0x06, 0x00, 0x04, 0x0b, 0x03, 0x05, 0x0c,
        0x07, 0x01, 0x0a, 0x05, 0x0a, 0x0b, 0x0b, 0x02, 0x0b, 0x00,
        0x0c, 0x09, 0x0b, 0x06, 0x01, 0x0c, 0x0d, 0x0d, 0x08, 0x03,
        0x0a, 0x0a, 0x0f, 0x0e };
    NSData *keyData = [[NSData alloc] initWithBytes:keyByte length:32];
    
    NSData *resultData = [data AES256DecryptWithKey:keyData];
    
    NSString * resultStr= [[NSString alloc]initWithData:resultData encoding:NSUTF8StringEncoding];
    return resultStr;
    
}




+(NSString *)stringFromData:(NSData *)data
{
    NSString *hexStr=@"";
    Byte *bytes = (Byte *)[data bytes];
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    
    return hexStr;
}



+(NSData *)dataFromString:(NSString *)hexString
{
    int len = [hexString length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [hexString length] / 2; i++) {
        byte_chars[0] = [hexString characterAtIndex:i*2];
        byte_chars[1] = [hexString characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}
@end
