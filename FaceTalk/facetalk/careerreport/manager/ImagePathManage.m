//
//  ImagePathManage.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/3.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "ImagePathManage.h"

@implementation ImagePathManage

+(NSString *)saveImageToPath:(NSString *)filename andImageName:(NSString *)imagename
{
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *path1 = [NSString stringWithFormat:@"%@/%@",path,filename];//拼装图片的本地沙盒路径
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path1]) {
        [fm createDirectoryAtPath:path1 withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    
    NSString *path2 = [NSString stringWithFormat:@"/%@/%@.png",filename,imagename];//返回图片的本地相对路径
    return path2;
}

@end
