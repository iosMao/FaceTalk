//
//  FTDDataProvider.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/14.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDDataProvider.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking/AFURLSessionManager.h>
#import "FTDChangeDate.h"
#import "ImagePathManage.h"
#import "FTDCreatIDManager.h"
#import "FTDDBManager.h"
#import "FTDFileManager.h"
#import "FTDDataPacketManager.h"
#import <SVProgressHUD.h>
#import "FTDAES256.h"
//#define FTD_BASE_IPSURL @"http://imo.tohours.com/attract/isp?"
//#define FTD_BASE_URL @"http://imo.tohours.com/attract/"
//#define FTD_UPdateFile_URL @"http://imo.tohours.com/attract/data.json"

//#define FTD_BASE_IPSURL @"http://uat.aia.com.cn/cms/attract/isp?"
//#define FTD_BASE_URL @"http://uat.aia.com.cn/cms/attract/"
//#define FTD_UPdateFile_URL @"http://uat.aia.com.cn/cms/attract/data.json"

#define FTD_BASE_IPSURL @"https://aes.aia.com.cn/cms/attract/isp?"
#define FTD_BASE_URL @"https://aes.aia.com.cn/cms/attract/"
#define FTD_UPdateFile_URL @"https://aes.aia.com.cn/cms/attract/data.json"


#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
@implementation FTDDataProvider

-(void)userLogin:(NSDictionary *)infoDic
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [dic setObject:[FTDAES256 AES256EncryptWithString:identifierStr] forKey:@"deviceNum"];
    [dic setObject:[FTDAES256 AES256EncryptWithString:[infoDic objectForKey:@"account"]] forKey:@"account"];
    [dic setObject:[FTDAES256 AES256EncryptWithString:[infoDic objectForKey:@"co"]] forKey:@"co"];
    [dic setObject:[FTDAES256 AES256EncryptWithString:[infoDic objectForKey:@"password"]] forKey:@"password"];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:FTD_BASE_IPSURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
       self.resultDict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        self.finishBlock(self.resultDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.failedBlock([NSString stringWithFormat:@"%@",error]);
    }];
}

-(void)getJsonUrl
{
    NSString *urlString = [NSString stringWithFormat:@"%@downloadDataJson",FTD_BASE_URL];
    [self requestData:urlString];
}

-(void)upDateJsonFile:(NSString *)strurl
{
    
    
    //检查附件是否存在
    //    if ([fileManager fileExistsAtPath:fileName]) {
    //        NSData *audioData = [NSData dataWithContentsOfFile:fileName];
    //        //[self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
    //    }else{
    //创建附件存储目录
     
    NSString *fileName=[[FTDDataPacketManager sharedInstance]unzipDestinationPath];
    
    fileName =[fileName stringByAppendingPathComponent:@"uploads"];
     fileName =[fileName stringByAppendingPathComponent:@"data.json"];
    //下载附件
    NSURL *url = [[NSURL alloc] initWithString:strurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{
        
    }];
    operation.inputStream   = [NSInputStream inputStreamWithURL:url];
    operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
    
    //下载进度控制
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
    }];
    
    
    //已完成下载
    __weak __typeof(self)weakSelf = self;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"成功了");
        self.finishBlock(@{@"success":@"1"});
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败了");
        
        
        //下载失败
        //[self requestFailed:aTag];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
-(void)getTalents:(NSString *)agentId
{
   // NSString *aesStr = [FTDAES256 AES256EncryptWithString:agentId];
    NSString *urlString = [NSString stringWithFormat:@"%@getTalentByAgentId?agentId=%@",FTD_BASE_URL,agentId];
    [self requestData:urlString];
}
-(void)getFinishDate
{
    NSString *urlString = [NSString stringWithFormat:@"%@getAppLastDate",FTD_BASE_URL];
    [self requestData:urlString];
}
-(void)pullTalentsInfoArray:(NSArray *)talentArray
{
    _indexPeople = 0;
    _indexReport = 0;
    _totalTalents = 0;
    _currentNum = 0;
    _personArray = [[NSArray alloc]initWithArray:talentArray];
    for (int i = 0; i < _personArray.count; i ++) {
        for (int j = 0; j < [[[_personArray objectAtIndex:i] objectForKey:@"reports"]count]; j ++) {
            _totalTalents ++ ;
        }
    }
    [FTDDBManager NetaddToLocalDB:[_personArray objectAtIndex:_indexPeople]];
    [self sessionDownload];
}
- (void)sessionDownload
{
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"已同步人才%.0f%%...",_currentNum/_totalTalents*100] maskType:SVProgressHUDMaskTypeBlack];
    
    if (_indexPeople >= _personArray.count) {
        self.finishBlock(@{@"success":@"1"});
        return;
    }
    
    NSArray *reports = [[NSArray alloc]initWithArray:[[_personArray objectAtIndex:_indexPeople] objectForKey:@"reports"]];
    if (_indexReport >= reports.count) {
        _indexReport = 0;
        _indexPeople++;
        
        if (_indexPeople >= _personArray.count) {
            self.finishBlock(@{@"success":@"1"});
            return;
        }
        [FTDDBManager NetaddToLocalDB:[_personArray objectAtIndex:_indexPeople]];//其他字段存本地数据库
        reports = [[_personArray objectAtIndex:_indexPeople] objectForKey:@"reports"];
        if (reports.count == 0) {
            _indexReport = 0;
            _indexPeople++;
            [self sessionDownload];
            return;
        }
    }
    
    __weak FTDDataProvider *weakself = self;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *urlString = [FTDAES256 AES256DecryptWithString:[[reports objectAtIndex:weakself.indexReport] objectForKey:@"downImageUrl"]];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSString *pathid = [FTDAES256 AES256DecryptWithString:[[self.personArray objectAtIndex:self.indexPeople] objectForKey:@"id"]];
        self.path = [ImagePathManage saveImageToPath:pathid andImageName:[FTDCreatIDManager creatImageName]];
        
        //[FTDDBManager addImageUrl:self.path andToTalentId:[[self.personArray objectAtIndex:self.indexPeople] objectForKey:@"id"]];//图片相对路径存数据库
        NSString* localPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *localAllPath = [NSString stringWithFormat:@"%@%@",localPath,self.path];
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        
        NSURL *fileURL = [NSURL fileURLWithPath:localAllPath];
        
        NSLog(@"|||| %@",   fileURL);
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath, error);
        NSLog(@"哈哈error.localizedDescription:::::%@",error.localizedDescription);
        
        
        if (error != nil) {
            weakself.failedBlock(@"fail");
            return ;
        }
        weakself.currentNum ++ ;
        NSString *pathid = [FTDAES256 AES256DecryptWithString:[[self.personArray objectAtIndex:self.indexPeople] objectForKey:@"id"]];
        [FTDDBManager addImageUrl:weakself.path andToTalentId:pathid];
        weakself.indexReport++;
        [weakself sessionDownload];
    }];
    
    [task resume];
}









-(void)pushTalentsInfoArray:(NSArray *)personArray
{
    _index = 0;
    _personArray = [[NSArray alloc]initWithArray:personArray];
    //self.personInfo = [[Person alloc]init];
    self.personInfo = (Person *)[_personArray firstObject];
    [self pushTalentsInfo];
    
    
}

-(void)pushTalentsInfo
{
    if ([self.personInfo.isPush isEqualToString:@"1"]) {
        self.index ++;
        if (self.index < self.personArray.count) {
            self.personInfo = [self.personArray objectAtIndex:self.index];
            [self pushTalentsInfo];
        }
        else{
            self.finishBlock(@{@"success":@"1"});
        }
        
    }
    else{
    
    
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
         manager.responseSerializer = [AFJSONResponseSerializer serializer];
         manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSLog(@"上传的人才ID：%@",self.personInfo.personid);
        NSLog(@"上传的人才名字：%@",self.personInfo.name);
        NSLog(@"上传的人才的性别：%@",self.personInfo.sex);
        
        [dic setObject:[FTDAES256 AES256EncryptWithString:self.personInfo.personid] forKey:@"id"];
        [dic setObject:[FTDAES256 AES256EncryptWithString:self.personInfo.name] forKey:@"name"];
        [dic setObject:[FTDAES256 AES256EncryptWithString:[FTDChangeDate dateStr: self.personInfo.chattime]] forKey:@"chatTime"];
        [dic setObject:[FTDAES256 AES256EncryptWithString:[NSString stringWithFormat:@"%@",self.personInfo.sex]] forKey:@"sex"];
        [dic setObject:[get_Dsp(@"DUSERINFO")objectForKey:@"agentId"] forKey:@"agentId"];//登录接口返回的未解密，直接传
        [dic setObject:[FTDAES256 AES256EncryptWithString:[FTDChangeDate dateStr: self.personInfo.birthday]] forKey:@"birthday"];
        NSOrderedSet *orderset = self.personInfo.report;
        NSString *strUrlTotal = [[NSString alloc]init];
        if (orderset.count > 0) {
            for (int m = 0; m <orderset.count; m++) {
                Report *report = [self.personInfo.report objectAtIndex:m];
                //NSLog(@"报告：,%@",report.imgurl);
                NSString *strPart1 = strUrlTotal;
                NSString *strPart2 = [NSString stringWithFormat:@",%@",report.imgurl];
                strUrlTotal = [strPart1 stringByAppendingString:strPart2];
                
            }
            NSString *strR = [strUrlTotal substringFromIndex:1];
            [dic setObject:[FTDAES256 AES256EncryptWithString:strR] forKey:[NSString stringWithFormat:@"imageUrl"]];
        }
        
        NSString *strUrl = [NSString stringWithFormat:@"%@addTalent",FTD_BASE_URL];
        __weak FTDDataProvider *weakself = self;
        
        [manager POST:strUrl parameters:dic
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (orderset.count > 0) {
            for (int m = 0; m <orderset.count; m++) {
                Report *report = [self.personInfo.report objectAtIndex:m];
               // NSLog(@"报告：%@",report.imgurl);
                NSString* localPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
                
                NSString *imagePath = [NSString stringWithFormat:@"%@%@",localPath,report.imgurl];
                UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
                
                NSData *data = UIImageJPEGRepresentation(image, 0.03);
                //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
//                formatter.dateFormat = @"yyyyMMddHHmmss";
//                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *imageUrl = report.imgurl;
                 NSRange range1 = [imageUrl rangeOfString:@"."];
                NSString *fileName = [imageUrl substringFromIndex:range1.location-14];
                //NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"imgFile"] fileName:fileName mimeType:@"image/jpeg"];
    //            NSString * Name = [NSString stringWithFormat:@"%@%zi", Image_Name,m+1];            // 上传filename
    //            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];                        [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpeg"
                
                
            }
            
        }
    //        NSData *data = UIImagePNGRepresentation(_userImage);
    //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //        // 设置时间格式
    //        formatter.dateFormat = @"yyyyMMddHHmmss";
    //        NSString *str = [formatter stringFromDate:[NSDate date]];
    //        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    //        [formData appendPartWithFileData:data name:@"logo_img" fileName:fileName mimeType:@"image/png"];
        
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            __strong FTDDataProvider *strongself = weakself;
            
            NSString *html = operation.responseString;
            NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dic = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            if ([[dic objectForKey:@"success"] intValue] == 1) {
                [FTDDBManager changeTalentIsPushContain:strongself.personInfo];
                strongself.index ++;
                if (strongself.index < strongself.personArray.count) {
                    strongself.personInfo = [strongself.personArray objectAtIndex:strongself.index];
    //                NSLog(@"递归前上传的Index:%ld",strongself.index);
    //                NSLog(@"递归前上传的数组%@",strongself.personArray);
    //                NSLog(@"递归前上传的人才ID：%@",strongself.personInfo.personid);
    //                NSLog(@"递归前上传的人才名字：%@",strongself.personInfo.name);
    //                NSLog(@"递归前上传的人才的性别：%@",strongself.personInfo.sex);
                    [strongself pushTalentsInfo];
                }
                else{
                    strongself.finishBlock(dic);
                }
            }
            else {
                if ([[dic objectForKey:@"msg"]isEqualToString:@"id在talent中已存在"]) {
                    strongself.index ++;
                    if (strongself.index < strongself.personArray.count) {
                        strongself.personInfo  = [strongself.personArray objectAtIndex:strongself.index];
                        Person *personmao = [strongself.personArray objectAtIndex:strongself.index];
    //                    NSLog(@"递归前上传的Index:%ld",strongself.index);
    //                    NSLog(@"递归前上传的数组%@",strongself.personArray);
    //                    NSLog(@"递归前上传的人才ID：%@",personmao .personid);
    //                    NSLog(@"递归前上传的人才名字：%@",personmao .name);
    //                    NSLog(@"递归前上传的人才的性别：%@",personmao.sex);
                        
                        
                        
                        
                        [strongself pushTalentsInfo];
                    }
                    else{
                        strongself.finishBlock(dic);
                    }
                }
                else{
                    strongself.finishBlock(dic);
                }
                //weakself.finishBlock(weakself.resultDict);
            }
            //
           
        
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
             NSString *html = operation.responseString;
            __strong FTDDataProvider *strongself = weakself;
            
            strongself.failedBlock(@"fail");
        }];
    }
}



- (void)requestData:(NSString *)urlString
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        self.resultDict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        self.finishBlock(self.resultDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.failedBlock([NSString stringWithFormat:@"%@",error]);
    }];
}

- (void)dealloc
{
    self.resultDict = nil;
    self.finishBlock = nil;
    self.failedBlock = nil;
}
@end
