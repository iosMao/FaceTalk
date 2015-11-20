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
#define FTD_BASE_IPSURL @"http://imo.tohours.com/attract/isp?"
#define FTD_BASE_URL @"http://imo.tohours.com/attract/"

#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
@implementation FTDDataProvider

-(void)userLogin:(NSDictionary *)infoDic
{
     NSString *urlString = [NSString stringWithFormat:@"%@account=%@&co=%@&password=%@",FTD_BASE_IPSURL,[infoDic objectForKey:@"account"],[infoDic objectForKey:@"co"],[infoDic objectForKey:@"password"]];
     //NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:FTD_BASE_IPSURL parameters:infoDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

-(void)getTalents:(NSString *)agentId
{
    NSString *urlString = [NSString stringWithFormat:@"%@getTalentByAgentId?agentId=%@",FTD_BASE_URL,agentId];
    [self requestData:urlString];
}

-(void)pullTalentsInfoArray:(NSArray *)talentArray
{
     _indexPeople = 0;
    _indexReport = 0;
    _personArray = [[NSArray alloc]initWithArray:talentArray];
    [FTDDBManager NetaddToLocalDB:[_personArray objectAtIndex:_indexPeople]];
    [self sessionDownload];
}
- (void)sessionDownload
{
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
    }
    
    __weak FTDDataProvider *weakself = self;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *urlString = [[reports objectAtIndex:weakself.indexReport] objectForKey:@"downImageUrl"];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        
        self.path = [ImagePathManage saveImageToPath:[[self.personArray objectAtIndex:self.indexPeople] objectForKey:@"id"] andImageName:[FTDCreatIDManager creatImageName]];
        
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
        [FTDDBManager addImageUrl:weakself.path andToTalentId:[[self.personArray objectAtIndex:self.indexPeople] objectForKey:@"id"]];
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSLog(@"上传的人才ID：%@",self.personInfo.personid);
    NSLog(@"上传的人才名字：%@",self.personInfo.name);
    NSLog(@"上传的人才的性别：%@",self.personInfo.sex);
    
    [dic setObject:self.personInfo.personid forKey:@"id"];
    [dic setObject:self.personInfo.name forKey:@"name"];
    [dic setObject:[FTDChangeDate dateStr: self.personInfo.chattime] forKey:@"chatTime"];
    [dic setObject:[NSString stringWithFormat:@"%@",self.personInfo.sex] forKey:@"sex"];
    [dic setObject:[get_Dsp(@"DUSERINFO")objectForKey:@"agentId"] forKey:@"agentId"];
    [dic setObject:[FTDChangeDate dateStr: self.personInfo.birthday] forKey:@"birthday"];
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
        [dic setObject:strR forKey:[NSString stringWithFormat:@"imageUrl"]];
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
            
            NSData *data = UIImagePNGRepresentation(image);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"imgFile"] fileName:fileName mimeType:@"image/png"];
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
            strongself.index ++;
            if (strongself.index < strongself.personArray.count) {
                strongself.personInfo = [strongself.personArray objectAtIndex:strongself.index];
                NSLog(@"递归前上传的Index:%ld",strongself.index);
                NSLog(@"递归前上传的数组%@",strongself.personArray);
                NSLog(@"递归前上传的人才ID：%@",strongself.personInfo.personid);
                NSLog(@"递归前上传的人才名字：%@",strongself.personInfo.name);
                NSLog(@"递归前上传的人才的性别：%@",strongself.personInfo.sex);
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
                    NSLog(@"递归前上传的Index:%ld",strongself.index);
                    NSLog(@"递归前上传的数组%@",strongself.personArray);
                    NSLog(@"递归前上传的人才ID：%@",personmao .personid);
                    NSLog(@"递归前上传的人才名字：%@",personmao .name);
                    NSLog(@"递归前上传的人才的性别：%@",personmao.sex);
                    
                    
                    
                    
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
