//
//  FTDDataPacketManager.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/14.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDDataPacketManager.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <ZipArchive/ZipArchive.h>

#define FILENAME @"attract"//文件夹名字
#define ZIPNAME @"datafile.zip"//文件名字
#define DATA_PACKET_URL @"http://imo.tohours.com/attract/resource.zip"
@implementation FTDDataPacketManager
+ (FTDDataPacketManager *)sharedInstance
{
    static FTDDataPacketManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}
-(void)downloadFile
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    NSString *path = [self downloadDestinationPath];
    NSLog(@"%@",path);
    
    [self downloadFileURL:DATA_PACKET_URL savePath:path fileName:ZIPNAME tag:1];
    
}

/**
 * 下载文件
 *
 * @param string aUrl 请求文件地址
 * @param string aSavePath 保存地址
 * @param string aFileName 文件名
 * @param int aTag tag标识
 */
- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [SVProgressHUD showWithStatus:@"请求中..." maskType:SVProgressHUDMaskTypeBlack];
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath,aFileName];
    
    //检查附件是否存在
//    if ([fileManager fileExistsAtPath:fileName]) {
//        NSData *audioData = [NSData dataWithContentsOfFile:fileName];
//        //[self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
//    }else{
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        //下载附件
        NSURL *url = [[NSURL alloc] initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{
        
        }];
        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        
        //下载进度控制
        
         [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
         NSLog(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
             
             float percent= (float)totalBytesRead/totalBytesExpectedToRead;
             
             [SVProgressHUD showProgress:percent status:[NSString stringWithFormat:@"下载资源%.0f%%",percent*100 ] maskType:SVProgressHUDMaskTypeBlack];
         }];
        
        
        //已完成下载
    __weak __typeof(self)weakSelf = self;
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"成功了");
            [weakSelf unzip];
             
            //NSData *audioData = [NSData dataWithContentsOfFile:fileName];
            //设置下载数据到res字典对象中并用代理返回下载数据NSData
            //[self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"失败了");
            [SVProgressHUD dismiss];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请求网络超时,是否重新下载？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            
            //下载失败
            //[self requestFailed:aTag];
        }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
    //}
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self downloadFile];
    }
    else if (buttonIndex==0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FTDREQUESTFAILED" object:nil ];
        
    }
}


#pragma - FilePath
-(NSString *)basePath {
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return path;
}

-(NSString *)catchPath {
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Catch"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return path;
}



-(NSString *)downloadDestinationPath{
    NSMutableString *basePath = [NSMutableString stringWithString:[self basePath]];
    NSString *path = [NSString stringWithFormat:@"%@/%@",basePath,FILENAME];
    return path;
}

-(NSString *)unzipDestinationPath{
    NSMutableString *basePath = [NSMutableString stringWithString:[self basePath]];
    NSString *path = [NSString stringWithFormat:@"%@/%@",basePath, FILENAME];
    return path;
}

-(BOOL)removeFile:(NSString*)filePath{
    BOOL ret =  NO;
    
    if ([filePath isKindOfClass:[NSString class]] && [filePath length] > 0) {
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:filePath]) {
            ret = [fm removeItemAtPath:filePath error:nil];
        }
    }
    
    return ret;
}

-(void)removeAllSourceFile
{
    [self removeFile:[self catchPath]];
    [self removeFile:[self downloadDestinationPath]];
}



#pragma  mark zip delegate
-(void)unzip
{
    if ([self unzipFile:[NSString stringWithFormat:@"%@/%@",[self downloadDestinationPath],ZIPNAME
                         ] withDstPath:[self unzipDestinationPath]]) {
        NSLog(@"解压成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FTDUNZIPSUCCESS" object:nil ];
        
        [SVProgressHUD dismiss];
        // parse json data
        
    }
}
-(BOOL)unzipFile:(NSString*)filePath withDstPath:(NSString*)dstPath{
    BOOL ret =  NO;
    if ([filePath isKindOfClass:[NSString class]] && [filePath length] > 0) {
        ZipArchive *za = [[ZipArchive alloc] init];
        if ([za UnzipOpenFile: filePath])
        {
            ret = [za UnzipFileTo: dstPath overWrite: YES];
            if (ret){
                NSLog(@"unzipFile success");
                
            }
            [za UnzipCloseFile];
        }
    }
    return ret;
}


@end
