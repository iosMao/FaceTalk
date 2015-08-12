//
//  FTDImageManage.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/7.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDImageManage.h"
#define  ImageFileName @"Mimage"

@implementation FTDImageManage

+(NSString *)getImageLocalUrl
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory%@",documentsDirectory);
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:ImageFileName];
    return testDirectory;
}

+(NSArray *)getImageArray//获取文件列表名
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory%@",documentsDirectory);
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:ImageFileName];
    //方法一
    NSArray *file = [fileManage subpathsOfDirectoryAtPath: myDirectory error:nil];
    return  file;
    
}
+(BOOL)saveImageToDocument:(UIImage *)image imageName:(NSString *)imagename//保存照片到本地
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:ImageFileName];
    // 创建目录
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *imagePath = [testDirectory stringByAppendingPathComponent:imagename];
    BOOL isSuccess= [fileManager createFileAtPath:imagePath contents:UIImagePNGRepresentation(image) attributes:nil];
    
    return isSuccess;
}
+(BOOL)removeImage:(NSString *)imagename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:ImageFileName];
    NSString *imagePath = [testDirectory stringByAppendingPathComponent:imagename];
    BOOL isSuccess=[fileManager removeItemAtPath:imagePath error:nil];
    return isSuccess;
    
}

@end
